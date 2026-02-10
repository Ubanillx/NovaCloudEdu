package com.novacloudedu.backend.infrastructure.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.config.VideoModelProperties;
import com.novacloudedu.backend.config.VideoModelProperties.VideoModelConfig;
import com.novacloudedu.backend.config.VideoModelProperties.VideoProviderConfig;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 * 文生视频服务
 * 
 * 支持的供应商：
 * - dashscope: 阿里云通义万相视频生成，异步任务模式
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class VideoGenerationService {

    private final VideoModelProperties properties;
    private final OssService ossService;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * 视频生成结果
     */
    public record VideoResult(String videoUrl, String prompt, boolean success, String errorMessage) {
        public static VideoResult success(String videoUrl, String prompt) {
            return new VideoResult(videoUrl, prompt, true, null);
        }
        public static VideoResult failure(String prompt, String errorMessage) {
            return new VideoResult(null, prompt, false, errorMessage);
        }
    }

    /**
     * 文生视频（使用默认模型）
     */
    public VideoResult generateVideo(String prompt) {
        return generateVideo(prompt, null);
    }

    /**
     * 文生视频（指定模型）
     * 
     * @param prompt  视频描述（英文效果更好）
     * @param modelId 模型ID，null 则使用默认模型
     */
    public VideoResult generateVideo(String prompt, String modelId) {
        if (!properties.isEnabled()) {
            return VideoResult.failure(prompt, "文生视频功能未启用");
        }

        if (modelId == null || modelId.isBlank()) {
            modelId = properties.getDefaultModel();
        }

        try {
            VideoModelProperties.ProviderAndModel pm = properties.parseModelId(modelId);
            VideoProviderConfig providerConfig = properties.getProviderConfig(pm.provider());
            VideoModelConfig modelConfig = properties.getModelConfig(pm.provider(), pm.model());

            log.info("文生视频请求: provider={}, model={}, prompt={}", pm.provider(), pm.model(), prompt);

            String videoUrl = switch (providerConfig.getType()) {
                case "dashscope" -> generateWithDashScope(providerConfig, modelConfig, pm.model(), prompt);
                default -> throw new IllegalArgumentException("不支持的文生视频供应商类型: " + providerConfig.getType());
            };

            // 如果配置了上传到OSS，则下载视频并上传
            if (properties.isUploadToOss() && videoUrl != null) {
                videoUrl = uploadVideoToOss(videoUrl);
            }

            log.info("文生视频成功: url={}", videoUrl);
            return VideoResult.success(videoUrl, prompt);

        } catch (Exception e) {
            log.error("文生视频失败: prompt={}", prompt, e);
            return VideoResult.failure(prompt, e.getMessage());
        }
    }

    /**
     * 是否启用文生视频
     */
    public boolean isEnabled() {
        return properties.isEnabled();
    }

    // ==================== DashScope 通义万相视频生成（异步任务模式） ====================

    private String generateWithDashScope(VideoProviderConfig provider, VideoModelConfig config,
                                          String modelName, String prompt) {
        String apiKey = provider.getApiKey();
        String submitUrl = "https://dashscope.aliyuncs.com/api/v1/services/aigc/video-generation/video-synthesis";

        // 1. 提交异步任务
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("X-DashScope-Async", "enable");

        Map<String, Object> body = new HashMap<>();
        body.put("model", modelName);
        body.put("input", Map.of("prompt", prompt));

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("size", config.getSize());
        if (config.getDuration() != null) {
            parameters.put("duration", config.getDuration());
        }
        if (config.getPromptExtend() != null) {
            parameters.put("prompt_extend", config.getPromptExtend());
        }
        body.put("parameters", parameters);

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
        log.info("DashScope 文生视频请求体: {}", body);

        ResponseEntity<String> response;
        try {
            response = restTemplate.postForEntity(submitUrl, request, String.class);
        } catch (HttpClientErrorException e) {
            // 解析 DashScope 返回的详细错误
            String errorBody = e.getResponseBodyAsString();
            log.error("DashScope 文生视频请求失败: status={}, body={}", e.getStatusCode(), errorBody);
            try {
                JsonNode errorJson = parseJson(errorBody);
                String msg = errorJson.path("message").asText(errorJson.path("error").path("message").asText(errorBody));
                throw new RuntimeException("DashScope 文生视频失败: " + msg);
            } catch (RuntimeException re) {
                if (re.getMessage().startsWith("DashScope")) throw re;
                throw new RuntimeException("DashScope 文生视频失败: " + e.getStatusCode() + " - " + errorBody);
            }
        }

        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("DashScope 提交视频任务失败: " + response.getStatusCode());
        }

        JsonNode responseJson = parseJson(response.getBody());
        String taskId = responseJson.path("output").path("task_id").asText();
        if (taskId == null || taskId.isEmpty()) {
            throw new RuntimeException("DashScope 未返回 task_id: " + response.getBody());
        }

        log.info("DashScope 文生视频任务已提交: taskId={}", taskId);

        // 2. 轮询任务结果（视频生成时间较长，最多等待 10 分钟）
        return pollDashScopeTask(apiKey, taskId);
    }

    private String pollDashScopeTask(String apiKey, String taskId) {
        String taskUrl = "https://dashscope.aliyuncs.com/api/v1/tasks/" + taskId;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + apiKey);
        HttpEntity<Void> request = new HttpEntity<>(headers);

        int maxAttempts = 40; // 最多等待40次（约600秒 / 10分钟）
        for (int i = 0; i < maxAttempts; i++) {
            try {
                Thread.sleep(15000); // 每15秒轮询一次（官方建议）
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new RuntimeException("轮询被中断", e);
            }

            ResponseEntity<String> response = restTemplate.exchange(taskUrl, HttpMethod.GET, request, String.class);
            JsonNode taskJson = parseJson(response.getBody());
            String status = taskJson.path("output").path("task_status").asText();

            log.debug("DashScope 视频任务[{}] 状态: {}", taskId, status);

            switch (status) {
                case "SUCCEEDED" -> {
                    // 尝试从 video_url 获取
                    String videoUrl = taskJson.path("output").path("video_url").asText(null);
                    if (videoUrl != null && !videoUrl.isEmpty()) {
                        return videoUrl;
                    }
                    // 兼容 results 数组格式
                    JsonNode results = taskJson.path("output").path("results");
                    if (results.isArray() && results.size() > 0) {
                        String url = results.get(0).path("url").asText(null);
                        if (url != null && !url.isEmpty()) {
                            return url;
                        }
                    }
                    throw new RuntimeException("DashScope 视频任务成功但未返回视频URL");
                }
                case "FAILED" -> {
                    String errorMsg = taskJson.path("output").path("message").asText("未知错误");
                    throw new RuntimeException("DashScope 文生视频失败: " + errorMsg);
                }
                // PENDING / RUNNING 继续轮询
            }
        }

        throw new RuntimeException("DashScope 文生视频超时: taskId=" + taskId);
    }

    // ==================== 工具方法 ====================

    /**
     * 下载视频并上传到OSS
     */
    private String uploadVideoToOss(String videoUrl) {
        try {
            ResponseEntity<byte[]> response = restTemplate.getForEntity(videoUrl, byte[].class);
            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                String extension = ".mp4";
                if (videoUrl.contains(".webm")) {
                    extension = ".webm";
                }
                return ossService.uploadBytes(response.getBody(), extension, FileBusinessType.AI_GENERATED_VIDEO);
            }
            log.warn("下载视频失败，使用原始URL: {}", videoUrl);
            return videoUrl;
        } catch (Exception e) {
            log.warn("上传视频到OSS失败，使用原始URL: {}", videoUrl, e);
            return videoUrl;
        }
    }

    private JsonNode parseJson(String json) {
        try {
            return objectMapper.readTree(json);
        } catch (Exception e) {
            throw new RuntimeException("JSON解析失败: " + json, e);
        }
    }
}
