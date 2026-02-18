package com.novacloudedu.backend.infrastructure.ocr;

import com.baidu.aip.ocr.AipOcr;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

/**
 * 百度OCR客户端（通道A：文字识别）
 * <p>
 * 使用百度AIP Java SDK，支持：
 * <ul>
 *   <li>通用文字识别（高精度版）accurate — 印刷体高精度</li>
 *   <li>通用文字识别 general — 日常通用</li>
 *   <li>手写文字识别 handwriting — 手写体专用</li>
 * </ul>
 * 通过 baidu.ocr.api-type 配置切换识别模式，默认 accurate。
 * 替代 PaddleOCR Docker 方案，无需本地部署。
 */
@Slf4j
@Component
public class BaiduOcrClient {

    private final AipOcr aipOcr;

    @Value("${baidu.ocr.api-type:accurate}")
    private String apiType;

    private static final Pattern HEIC_PATTERN =
            Pattern.compile("\\.hei[cf]$", Pattern.CASE_INSENSITIVE);

    private static final int MAX_SIDE = 2048;

    public BaiduOcrClient(
            @Value("${baidu.ocr.app-id}") String appId,
            @Value("${baidu.ocr.api-key}") String apiKey,
            @Value("${baidu.ocr.secret-key}") String secretKey) {
        this.aipOcr = new AipOcr(appId, apiKey, secretKey);
        aipOcr.setConnectionTimeoutInMillis(30000);
        aipOcr.setSocketTimeoutInMillis(60000);
        log.info("百度OCR客户端初始化完成: appId={}", appId);
    }

    /**
     * 通过阿里云 OSS 图片处理参数确保图片兼容百度OCR：
     * 1. HEIC/HEIF → 转为 JPEG
     * 2. 所有图片 → 限制最长边不超过 MAX_SIDE
     */
    private String ensureCompatibleUrl(String imageUrl) {
        if (imageUrl == null) return imageUrl;
        String urlWithoutQuery = imageUrl.contains("?")
                ? imageUrl.substring(0, imageUrl.indexOf('?')) : imageUrl;
        boolean isHeic = HEIC_PATTERN.matcher(urlWithoutQuery).find();

        // 构建 OSS 图片处理管道：resize + 可选 format
        StringBuilder process = new StringBuilder("image/resize,l_" + MAX_SIDE);
        if (isHeic) {
            process.append("/format,jpg");
        }

        String separator = imageUrl.contains("?") ? "&" : "?";
        String converted = imageUrl + separator + "x-oss-process=" + process;
        if (isHeic) {
            log.info("HEIC图片自动转换+缩放: {} -> OSS处理", imageUrl);
        }
        return converted;
    }

    // ==================== OCR 文字识别 ====================

    /**
     * 调用百度OCR识别图片中的文字
     *
     * @param imageUrl 图片 URL（OSS 公网可访问地址）
     * @return 识别结果列表（文字 + 置信度 + 坐标框）
     */
    public List<TextBlock> recognizeFromUrl(String imageUrl) {
        try {
            String processedUrl = ensureCompatibleUrl(imageUrl);
            log.info("百度OCR识别开始: apiType={}, url={}", apiType, imageUrl);

            HashMap<String, String> options = new HashMap<>();
            options.put("detect_direction", "true");
            options.put("paragraph", "true");
            options.put("probability", "true");

            byte[] imageBytes = downloadImageBytes(processedUrl);
            log.info("图片下载完成: {}KB", imageBytes.length / 1024);

            JSONObject result = switch (apiType) {
                case "handwriting" -> aipOcr.handwriting(imageBytes, options);
                case "general" -> aipOcr.general(imageBytes, options);
                default -> aipOcr.accurateGeneral(imageBytes, options);
            };

            return parseOcrResponse(result);
        } catch (Exception e) {
            log.error("百度OCR识别异常: url={}, error={}", imageUrl, e.getMessage());
            return List.of();
        }
    }

    /**
     * 从 OSS 处理后的 URL 下载图片字节
     */
    private byte[] downloadImageBytes(String url) throws Exception {
        HttpURLConnection conn = (HttpURLConnection) URI.create(url).toURL().openConnection();
        conn.setConnectTimeout(30000);
        conn.setReadTimeout(60000);
        conn.setRequestMethod("GET");
        try (InputStream is = conn.getInputStream();
             ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
            byte[] buf = new byte[8192];
            int len;
            while ((len = is.read(buf)) != -1) {
                bos.write(buf, 0, len);
            }
            return bos.toByteArray();
        } finally {
            conn.disconnect();
        }
    }

    /**
     * 布局分析（百度OCR无直接等价接口，返回空结果，由多模态模型补充）
     */
    public LayoutResult analyzeLayoutFromUrl(String imageUrl) {
        return new LayoutResult(List.of(), List.of());
    }

    /**
     * 解析百度OCR响应
     * 响应格式:
     * {
     *   "words_result_num": 5,
     *   "words_result": [
     *     {
     *       "words": "识别的文字",
     *       "location": {"top": 10, "left": 20, "width": 100, "height": 30},
     *       "probability": {"average": 0.98, "min": 0.95, "variance": 0.001}
     *     }
     *   ]
     * }
     */
    private List<TextBlock> parseOcrResponse(JSONObject result) {
        List<TextBlock> blocks = new ArrayList<>();

        if (result.has("error_code")) {
            log.error("百度OCR返回错误: code={}, msg={}",
                    result.optInt("error_code"), result.optString("error_msg"));
            return blocks;
        }

        JSONArray wordsResult = result.optJSONArray("words_result");
        if (wordsResult == null) {
            log.warn("百度OCR返回空结果");
            return blocks;
        }

        for (int i = 0; i < wordsResult.length(); i++) {
            JSONObject item = wordsResult.getJSONObject(i);
            String words = item.optString("words", "").trim();

            double confidence = 0.0;
            JSONObject probability = item.optJSONObject("probability");
            if (probability != null) {
                confidence = probability.optDouble("average", 0.0);
            }

            int[] box = null;
            JSONObject location = item.optJSONObject("location");
            if (location != null) {
                int left = location.optInt("left");
                int top = location.optInt("top");
                int width = location.optInt("width");
                int height = location.optInt("height");
                box = new int[]{left, top, left + width, top + height};
            }

            if (!words.isEmpty()) {
                blocks.add(new TextBlock(words, confidence, box));
            }
        }

        log.info("百度OCR识别完成: {} 个文本块", blocks.size());
        return blocks;
    }

    // ==================== 数据结构 ====================

    /**
     * OCR 识别的文字块（含坐标）
     */
    public record TextBlock(
            String text,
            double confidence,
            int[] box
    ) {}

    /**
     * 布局检测区域
     */
    public record LayoutBlock(
            String label,
            double score,
            int[] box
    ) {}

    /**
     * 表格识别结果
     */
    public record TableResult(
            String html
    ) {}

    /**
     * 布局分析综合结果
     */
    public record LayoutResult(
            List<LayoutBlock> blocks,
            List<TableResult> tables
    ) {}
}
