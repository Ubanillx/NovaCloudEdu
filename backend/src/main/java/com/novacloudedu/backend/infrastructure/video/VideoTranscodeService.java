package com.novacloudedu.backend.infrastructure.video;

import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.service.VideoEncryptionKeyService;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.file.service.OssService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;

/**
 * 视频转码服务
 * 负责将原始 MP4 视频通过 FFmpeg 转码为 HLS(m3u8) + AES-128 加密切片
 * 然后将结果上传到 OSS
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class VideoTranscodeService {

    private final OssService ossService;
    private final VideoEncryptionKeyService keyService;
    private final CourseSectionRepository sectionRepository;

    @Value("${video.transcode.ffmpeg-path:ffmpeg}")
    private String ffmpegPath;

    @Value("${video.transcode.hls-time:10}")
    private int hlsTime;

    @Value("${server.base-url:http://localhost:8080}")
    private String serverBaseUrl;

    /**
     * 异步执行视频转码
     * 1. 从 OSS 下载原始视频
     * 2. 生成 AES-128 密钥
     * 3. FFmpeg 转码为 HLS + AES-128 加密切片
     * 4. 上传 m3u8 和所有 ts 切片到 OSS
     * 5. 更新数据库
     */
    @Async
    public void transcodeAsync(Long sectionId, String videoUrl) {
        log.info("开始视频转码, sectionId={}, videoUrl={}", sectionId, videoUrl);

        // 标记为转码中
        CourseSection section = sectionRepository.findById(SectionId.of(sectionId)).orElse(null);
        if (section == null) {
            log.error("小节不存在, sectionId={}", sectionId);
            return;
        }
        section.updateTranscodeStatus(1); // 转码中
        sectionRepository.save(section);

        Path tempDir = null;
        try {
            // 创建临时目录
            tempDir = Files.createTempDirectory("hls-transcode-");
            Path inputFile = tempDir.resolve("input.mp4");
            Path outputDir = tempDir.resolve("output");
            Files.createDirectories(outputDir);

            // 1. 下载原始视频到本地临时文件
            downloadFromOss(videoUrl, inputFile);

            // 2. 生成 AES-128 密钥
            String keyId = keyService.generateAndStoreKey();
            byte[] aesKey = keyService.getKey(keyId);

            // 3. 准备密钥文件和 key_info 文件
            Path keyFile = tempDir.resolve("enc.key");
            Files.write(keyFile, aesKey);

            // key_info 文件格式：
            // 第1行: Key URI（播放器请求密钥的地址）
            // 第2行: 本地密钥文件路径（FFmpeg 读取用）
            // 第3行: IV（可选，不指定则使用 segment number）
            String keyUri = serverBaseUrl + "/api/video/key?keyId=" + keyId;
            Path keyInfoFile = tempDir.resolve("key_info.txt");
            String keyInfoContent = keyUri + "\n" + keyFile.toAbsolutePath() + "\n";
            Files.writeString(keyInfoFile, keyInfoContent);

            // 4. 执行 FFmpeg 转码
            Path playlistFile = outputDir.resolve("playlist.m3u8");
            Path segmentPattern = outputDir.resolve("seg_%03d.ts");

            ProcessBuilder pb = new ProcessBuilder(
                    ffmpegPath,
                    "-i", inputFile.toAbsolutePath().toString(),
                    "-c:v", "libx264",
                    "-c:a", "aac",
                    "-hls_time", String.valueOf(hlsTime),
                    "-hls_list_size", "0",
                    "-hls_key_info_file", keyInfoFile.toAbsolutePath().toString(),
                    "-hls_segment_filename", segmentPattern.toAbsolutePath().toString(),
                    "-f", "hls",
                    playlistFile.toAbsolutePath().toString()
            );
            pb.redirectErrorStream(true);
            Process process = pb.start();

            // 读取 FFmpeg 输出日志
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    log.debug("FFmpeg: {}", line);
                }
            }

            int exitCode = process.waitFor();
            if (exitCode != 0) {
                throw new RuntimeException("FFmpeg 转码失败, exitCode=" + exitCode);
            }

            log.info("FFmpeg 转码完成, sectionId={}", sectionId);

            // 5. 上传 m3u8 和所有 ts 切片到 OSS
            String hlsUrl = uploadHlsToOss(outputDir, sectionId);

            // 6. 生成缩略图雪碧图
            String thumbnailOssUrl = null;
            int thumbnailCount = 0;
            try {
                Path thumbnailDir = tempDir.resolve("thumbnails");
                Files.createDirectories(thumbnailDir);
                int[] result = generateThumbnailSprite(inputFile, thumbnailDir, sectionId);
                if (result != null) {
                    thumbnailOssUrl = result[0] > 0
                            ? uploadThumbnailToOss(thumbnailDir.resolve("sprite.jpg"), sectionId)
                            : null;
                    thumbnailCount = result[0];
                }
            } catch (Exception e) {
                log.warn("缩略图生成失败（不影响转码结果）, sectionId={}", sectionId, e);
            }

            // 7. 更新数据库
            section = sectionRepository.findById(SectionId.of(sectionId)).orElse(null);
            if (section != null) {
                section.updateHlsInfo(hlsUrl, keyId);
                if (thumbnailOssUrl != null) {
                    section.updateThumbnailInfo(thumbnailOssUrl, thumbnailCount);
                }
                sectionRepository.save(section);
            }

            log.info("视频转码并上传完成, sectionId={}, hlsUrl={}, thumbnailCount={}",
                    sectionId, hlsUrl, thumbnailCount);

        } catch (Exception e) {
            log.error("视频转码失败, sectionId={}", sectionId, e);
            // 标记为失败
            section = sectionRepository.findById(SectionId.of(sectionId)).orElse(null);
            if (section != null) {
                section.updateTranscodeStatus(3); // 失败
                sectionRepository.save(section);
            }
        } finally {
            // 清理临时目录
            if (tempDir != null) {
                cleanupTempDir(tempDir);
            }
        }
    }

    /**
     * 从 OSS 下载文件到本地
     */
    private void downloadFromOss(String fileUrl, Path destination) throws IOException {
        // 使用 OssService 读取文件内容（这里需要二进制读取）
        // 由于 OssService 目前只有 readFileAsString，我们直接用 URL 下载
        String presignedUrl = ossService.generatePresignedUrl(fileUrl, 3600);
        try (InputStream in = new java.net.URI(presignedUrl).toURL().openStream();
             OutputStream out = Files.newOutputStream(destination)) {
            in.transferTo(out);
        } catch (Exception e) {
            throw new IOException("从 OSS 下载文件失败: " + e.getMessage(), e);
        }
        log.info("视频文件下载完成, size={}MB", Files.size(destination) / 1024 / 1024);
    }

    /**
     * 将 HLS 输出目录中的所有文件上传到 OSS 的固定目录
     * 保留原始文件名，确保 m3u8 中的相对路径引用正确
     * ts 切片设为公开读（已 AES-128 加密，公开无安全风险）
     * @return m3u8 文件的 OSS URL
     */
    private String uploadHlsToOss(Path outputDir, Long sectionId) throws IOException {
        String m3u8Url = null;
        String hlsDir = "course/hls/" + sectionId + "/";

        File[] files = outputDir.toFile().listFiles();
        if (files == null) {
            throw new IOException("HLS 输出目录为空");
        }

        for (File file : files) {
            byte[] data = Files.readAllBytes(file.toPath());
            String objectName = hlsDir + file.getName();

            if (file.getName().endsWith(".m3u8")) {
                // m3u8 保持私有，通过预签名 URL 访问
                String url = ossService.uploadToPath(data, objectName, "application/vnd.apple.mpegurl", false);
                m3u8Url = url;
            } else if (file.getName().endsWith(".ts")) {
                // ts 切片设为公开读（已 AES-128 加密）
                ossService.uploadToPath(data, objectName, "video/mp2t", true);
            } else {
                ossService.uploadToPath(data, objectName, "application/octet-stream", false);
            }
        }

        if (m3u8Url == null) {
            throw new IOException("未找到生成的 m3u8 文件");
        }

        return m3u8Url;
    }

    /**
     * 生成视频缩略图雪碧图
     * 1. 用 FFmpeg 获取视频时长
     * 2. 计算截取间隔（目标约60张缩略图，最少10张）
     * 3. 用 FFmpeg 按间隔截取缩略帧
     * 4. 用 FFmpeg 将所有帧拼成一张雪碧图（10列）
     *
     * @return [thumbnailCount, columns] 或 null（失败时）
     */
    private int[] generateThumbnailSprite(Path inputFile, Path thumbnailDir, Long sectionId) throws Exception {
        // 1. 获取视频时长
        double duration = getVideoDuration(inputFile);
        if (duration <= 0) {
            log.warn("无法获取视频时长, sectionId={}", sectionId);
            return null;
        }

        // 2. 计算截取间隔和总数（目标60张，最少10张，最多100张）
        int targetCount = 60;
        double interval = duration / targetCount;
        if (interval < 1.0) interval = 1.0; // 最小1秒间隔
        int count = (int) Math.floor(duration / interval);
        if (count < 1) count = 1;
        if (count > 100) count = 100;
        int columns = 10;

        log.info("生成缩略图: sectionId={}, duration={}s, interval={}s, count={}", sectionId, duration, interval, count);

        // 3. 用 FFmpeg 按间隔截取帧并直接拼成雪碧图
        // fps=1/interval 表示每 interval 秒截取一帧
        // tile=10xN 表示每行10个，自动计算行数
        int rows = (int) Math.ceil((double) count / columns);
        Path spriteFile = thumbnailDir.resolve("sprite.jpg");

        ProcessBuilder pb = new ProcessBuilder(
                ffmpegPath,
                "-i", inputFile.toAbsolutePath().toString(),
                "-vf", String.format("fps=1/%d,scale=160:90,tile=%dx%d", (int) Math.ceil(interval), columns, rows),
                "-frames:v", "1",
                "-q:v", "5",
                "-y",
                spriteFile.toAbsolutePath().toString()
        );
        pb.redirectErrorStream(true);
        Process process = pb.start();

        // 消费输出避免阻塞
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            while (reader.readLine() != null) { /* consume */ }
        }

        int exitCode = process.waitFor();
        if (exitCode != 0 || !Files.exists(spriteFile)) {
            log.warn("缩略图雪碧图生成失败, exitCode={}, sectionId={}", exitCode, sectionId);
            return null;
        }

        log.info("缩略图雪碧图生成完成, sectionId={}, count={}, size={}KB",
                sectionId, count, Files.size(spriteFile) / 1024);
        return new int[]{count, columns};
    }

    /**
     * 获取视频时长（秒）
     */
    private double getVideoDuration(Path inputFile) throws Exception {
        ProcessBuilder pb = new ProcessBuilder(
                ffmpegPath.replace("ffmpeg", "ffprobe"),
                "-v", "error",
                "-show_entries", "format=duration",
                "-of", "default=noprint_wrappers=1:nokey=1",
                inputFile.toAbsolutePath().toString()
        );
        pb.redirectErrorStream(true);
        Process process = pb.start();

        String output;
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            output = reader.readLine();
        }
        process.waitFor();

        if (output != null && !output.isBlank()) {
            try {
                return Double.parseDouble(output.trim());
            } catch (NumberFormatException e) {
                log.warn("解析视频时长失败: {}", output);
            }
        }
        return -1;
    }

    /**
     * 上传缩略图雪碧图到 OSS
     * 设为公开读（缩略图无安全风险）
     * @return OSS URL
     */
    private String uploadThumbnailToOss(Path spriteFile, Long sectionId) throws IOException {
        byte[] data = Files.readAllBytes(spriteFile);
        String objectName = "course/thumbnails/" + sectionId + "/sprite.jpg";
        return ossService.uploadToPath(data, objectName, "image/jpeg", true);
    }

    /**
     * 清理临时目录
     */
    private void cleanupTempDir(Path tempDir) {
        try {
            Files.walk(tempDir)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
        } catch (IOException e) {
            log.warn("清理临时目录失败: {}", tempDir, e);
        }
    }
}
