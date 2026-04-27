package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.file.service.OssService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * HLS m3u8 代理服务
 * 动态修改 m3u8 内容，将 key URI 替换为带 token 的验证地址
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class HlsProxyService {

    private final CourseSectionRepository sectionRepository;
    private final OssService ossService;
    private final VideoPlayTokenService tokenService;

    @Value("${server.base-url:http://localhost:8080}")
    private String serverBaseUrl;

    @Value("${video.hls.proxy-segments:false}")
    private boolean proxySegments;

    /**
     * 获取带 token 的 HLS m3u8 流（供播放器直接使用）
     * 内部自动生成并附加 token
     * @param sectionId 小节ID
     * @param userId 用户ID
     * @return 修改后的 m3u8 内容，null 表示获取失败
     */
    public String getM3u8Stream(Long sectionId, Long userId, String requestBaseUrl) {
        // 1. 获取小节信息
        CourseSection section = sectionRepository.findById(SectionId.of(sectionId)).orElse(null);
        if (section == null || section.getHlsUrl() == null) {
            log.warn("m3u8流获取失败: 小节不存在或无HLS地址, sectionId={}", sectionId);
            return null;
        }

        String hlsUrl = section.getHlsUrl();
        String keyId = section.getEncryptionKeyId();

        // 2. 如果视频未加密或无 keyId，直接返回原始 m3u8 URL（使用预签名）
        if (keyId == null || keyId.isBlank()) {
            log.debug("视频未加密, 直接返回预签名m3u8, sectionId={}", sectionId);
            return generatePresignedM3u8(sectionId, hlsUrl, requestBaseUrl, null);
        }

        // 3. 生成播放令牌（用于 key URI）
        String keyToken = tokenService.generateToken(userId, keyId);

        // 5. 下载原始 m3u8 内容
        String originalM3u8 = downloadM3u8(hlsUrl);
        if (originalM3u8 == null) {
            log.error("下载m3u8失败, sectionId={}, hlsUrl={}", sectionId, hlsUrl);
            return null;
        }

        // 6. 替换 key URI：附加 token 参数
        // 原始格式: #EXT-X-KEY:METHOD=AES-128,URI="https://host/api/video/key?keyId=xxx"
        // 修改为:   #EXT-X-KEY:METHOD=AES-128,URI="https://host/api/video/key?keyId=xxx&token=yyy"
        String modifiedM3u8 = modifyKeyUri(originalM3u8, keyId, keyToken, requestBaseUrl);

        if (proxySegments) {
            // 降级方案：通过同域后端代理 ts 分片，绕过 CDN/OSS 跨域问题
            String streamToken = tokenService.generateStreamToken(userId, sectionId);
            modifiedM3u8 = makeSegmentUrlsWithProxy(modifiedM3u8, sectionId, requestBaseUrl, streamToken);
        } else {
            // 默认方案：分片继续走 CDN/OSS，减轻后端带宽和内存压力
            modifiedM3u8 = makeSegmentUrlsDirect(modifiedM3u8, hlsUrl);
        }

        log.debug("m3u8流生成成功, sectionId={}, userId={}, keyId={}", sectionId, userId, keyId);
        return modifiedM3u8;
    }

    // 兼容旧调用方（若存在），默认回退到配置项 server.base-url
    public String getM3u8Stream(Long sectionId, Long userId) {
        return getM3u8Stream(sectionId, userId, serverBaseUrl);
    }

    /**
     * 获取带 token 的 HLS m3u8 内容（兼容旧方法，使用外部传入的 token）
     * @param sectionId 小节ID
     * @param token 播放令牌
     * @return 修改后的 m3u8 内容
     */
    public String getM3u8WithToken(Long sectionId, String token) {
        // 1. 获取小节信息
        CourseSection section = sectionRepository.findById(SectionId.of(sectionId)).orElse(null);
        if (section == null || section.getHlsUrl() == null) {
            log.warn("m3u8代理失败: 小节不存在或无HLS地址, sectionId={}", sectionId);
            return null;
        }

        String hlsUrl = section.getHlsUrl();
        String keyId = section.getEncryptionKeyId();

        // 2. 如果视频未加密或无 keyId，直接返回原始 m3u8 URL（使用预签名）
        if (keyId == null || keyId.isBlank()) {
            log.debug("视频未加密, 直接返回预签名URL, sectionId={}", sectionId);
            return generatePresignedM3u8(sectionId, hlsUrl, serverBaseUrl, null);
        }

        // 3. 下载原始 m3u8 内容
        String originalM3u8 = downloadM3u8(hlsUrl);
        if (originalM3u8 == null) {
            log.error("下载m3u8失败, sectionId={}, hlsUrl={}", sectionId, hlsUrl);
            return null;
        }

        // 4. 替换 key URI：将 keyId 参数附加到 key 请求 URL
        String modifiedM3u8 = modifyKeyUri(originalM3u8, keyId, token, serverBaseUrl);

        if (proxySegments) {
            modifiedM3u8 = makeSegmentUrlsWithProxy(modifiedM3u8, sectionId, serverBaseUrl, token);
        } else {
            modifiedM3u8 = makeSegmentUrlsDirect(modifiedM3u8, hlsUrl);
        }

        log.debug("m3u8代理成功, sectionId={}, token={}", sectionId, token);
        return modifiedM3u8;
    }

    /**
     * 生成预签名的 m3u8 内容
     * 将 m3u8 中的所有相对 ts 路径替换为预签名绝对路径
     */
    private String generatePresignedM3u8(Long sectionId, String hlsUrl, String requestBaseUrl, String token) {
        try {
            // downloadM3u8 内部已经处理预签名，直接传原始 OSS URL
            String m3u8Content = downloadM3u8(hlsUrl);
            if (m3u8Content == null) {
                return null;
            }
            if (proxySegments) {
                return makeSegmentUrlsWithProxy(m3u8Content, sectionId, requestBaseUrl, token);
            }
            return makeSegmentUrlsDirect(m3u8Content, hlsUrl);
        } catch (Exception e) {
            log.warn("生成预签名m3u8失败: {}", e.getMessage());
            return null;
        }
    }

    /**
     * 下载 m3u8 文件内容
     */
    private String downloadM3u8(String hlsUrl) {
        try {
            // 获取预签名 URL
            String presignedUrl = ossService.generatePresignedUrl(hlsUrl, 3600);
            URI uri = URI.create(presignedUrl);
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(uri.toURL().openStream(), StandardCharsets.UTF_8))) {
                return reader.lines().collect(Collectors.joining("\n"));
            }
        } catch (Exception e) {
            log.error("下载m3u8失败: url={}, error={}", hlsUrl, e.getMessage());
            return null;
        }
    }

    /**
     * 修改 m3u8 中的 key URI，附加 token 参数
     */
    private String modifyKeyUri(String m3u8Content, String keyId, String token, String requestBaseUrl) {
        String baseUrl = normalizeBaseUrl(requestBaseUrl);
        String finalKeyUri = baseUrl + "/api/video/key?keyId=" + keyId + "&token=" + token;

        // 无论历史 m3u8 里是 localhost/内网/旧域名，统一重写为当前请求域名
        String keyUriPattern = "URI=\\\"[^\\\"]*keyId=" + Pattern.quote(keyId) + "[^\\\"]*\\\"";
        String replaced = m3u8Content.replaceAll(keyUriPattern, "URI=\"" + Matcher.quoteReplacement(finalKeyUri) + "\"");

        // 兜底：若历史内容格式异常，至少保证 token 被附加
        if (replaced.equals(m3u8Content)) {
            String search = "keyId=" + keyId + "\"";
            String replace = "keyId=" + keyId + "&token=" + token + "\"";
            return m3u8Content.replace(search, replace);
        }
        return replaced;
    }

    private String normalizeBaseUrl(String baseUrl) {
        if (baseUrl == null || baseUrl.isBlank()) {
            return serverBaseUrl;
        }
        String trimmed = baseUrl.trim();
        return trimmed.endsWith("/") ? trimmed.substring(0, trimmed.length() - 1) : trimmed;
    }

    /**
     * 将 m3u8 中的相对 URL 转换为预签名的绝对 URL
     */
    private String makeSegmentUrlsWithProxy(String m3u8Content, Long sectionId, String requestBaseUrl, String token) {
        String baseUrl = normalizeBaseUrl(requestBaseUrl);
        // 处理相对路径行（以 seg_ 开头的 ts 切片）
        String[] lines = m3u8Content.split("\n");
        StringBuilder result = new StringBuilder();
        for (String line : lines) {
            String trimmed = line.trim();
            if (trimmed.startsWith("seg_") && trimmed.endsWith(".ts")) {
                result.append(baseUrl)
                        .append("/api/video/hls/")
                        .append(sectionId)
                        .append("/segments/")
                        .append(trimmed);
                if (token != null && !token.isBlank()) {
                    result.append("?token=").append(token);
                }
            } else {
                result.append(line);
            }
            result.append("\n");
        }
        return result.toString();
    }

    private String makeSegmentUrlsDirect(String m3u8Content, String hlsUrl) {
        String basePath = hlsUrl.substring(0, hlsUrl.lastIndexOf('/') + 1);
        String[] lines = m3u8Content.split("\n");
        StringBuilder result = new StringBuilder();
        for (String line : lines) {
            String trimmed = line.trim();
            if (trimmed.startsWith("seg_") && trimmed.endsWith(".ts")) {
                result.append(basePath).append(trimmed);
            } else {
                result.append(line);
            }
            result.append("\n");
        }
        return result.toString();
    }

    public String getSegmentPresignedUrl(Long sectionId, String fileName) {
        if (sectionId == null || fileName == null || fileName.isBlank()) {
            return null;
        }
        if (!fileName.matches("^seg_[A-Za-z0-9_-]+\\.ts$")) {
            log.warn("非法的分片文件名: sectionId={}, fileName={}", sectionId, fileName);
            return null;
        }

        CourseSection section = sectionRepository.findById(SectionId.of(sectionId)).orElse(null);
        if (section == null || section.getHlsUrl() == null || section.getHlsUrl().isBlank()) {
            return null;
        }

        String hlsUrl = section.getHlsUrl();
        String basePath = hlsUrl.substring(0, hlsUrl.lastIndexOf('/') + 1);
        String segmentUrl = basePath + fileName;
        return ossService.generatePresignedUrl(segmentUrl, 3600);
    }
}
