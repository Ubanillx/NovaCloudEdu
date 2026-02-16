package com.novacloudedu.backend.infrastructure.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.config.ImageModelProperties;
import com.novacloudedu.backend.config.ImageModelProperties.ImageModelConfig;
import com.novacloudedu.backend.config.ImageModelProperties.ImageProviderConfig;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文生图服务
 * 
 * 支持的供应商：
 * - dashscope: 阿里云通义万相（wanx2.1-t2i-turbo 等），异步任务模式
 * - openai: OpenAI 兼容协议（SiliconFlow FLUX 等），同步模式
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ImageGenerationService {

    private final ImageModelProperties properties;
    private final OssService ossService;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * 生成图片结果
     */
    public record ImageResult(String imageUrl, String prompt, boolean success, String errorMessage) {
        public static ImageResult success(String imageUrl, String prompt) {
            return new ImageResult(imageUrl, prompt, true, null);
        }
        public static ImageResult failure(String prompt, String errorMessage) {
            return new ImageResult(null, prompt, false, errorMessage);
        }
    }

    /**
     * 文生图（使用默认模型）
     */
    public ImageResult generateImage(String prompt) {
        return generateImage(prompt, null);
    }

    /**
     * 文生图（指定模型）
     * 
     * @param prompt  图片描述（英文效果更好）
     * @param modelId 模型ID，null 则使用默认模型
     */
    public ImageResult generateImage(String prompt, String modelId) {
        return doGenerate(prompt, null, modelId);
    }

    /**
     * 图参生图（使用参考图 + 文字描述生成新图片）
     * 
     * @param prompt          新图片的描述（英文效果更好）
     * @param referenceImgUrl 参考图片的URL
     */
    public ImageResult generateImageWithReference(String prompt, String referenceImgUrl) {
        return generateImageWithReference(prompt, referenceImgUrl, null);
    }

    /**
     * 图参生图（指定模型）
     */
    public ImageResult generateImageWithReference(String prompt, String referenceImgUrl, String modelId) {
        return doGenerate(prompt, referenceImgUrl, modelId);
    }

    private ImageResult doGenerate(String prompt, String referenceImgUrl, String modelId) {
        if (!properties.isEnabled()) {
            return ImageResult.failure(prompt, "文生图功能未启用");
        }

        if (modelId == null || modelId.isBlank()) {
            modelId = properties.getDefaultModel();
        }

        boolean hasRef = referenceImgUrl != null && !referenceImgUrl.isBlank();

        try {
            ImageModelProperties.ProviderAndModel pm = properties.parseModelId(modelId);
            ImageProviderConfig providerConfig = properties.getProviderConfig(pm.provider());
            ImageModelConfig modelConfig = properties.getModelConfig(pm.provider(), pm.model());

            log.info("{}请求: provider={}, model={}, prompt={}, refImg={}",
                    hasRef ? "图参生图" : "文生图", pm.provider(), pm.model(), prompt,
                    hasRef ? referenceImgUrl : "无");

            String imageUrl = switch (providerConfig.getType()) {
                case "dashscope" -> generateWithDashScope(providerConfig, modelConfig, pm.model(), prompt, referenceImgUrl);
                case "openai" -> generateWithOpenAi(providerConfig, modelConfig, pm.model(), prompt, referenceImgUrl);
                default -> throw new IllegalArgumentException("不支持的文生图供应商类型: " + providerConfig.getType());
            };

            // 如果配置了上传到OSS，则下载图片并上传
            if (properties.isUploadToOss() && imageUrl != null) {
                imageUrl = uploadImageToOss(imageUrl);
            }

            log.info("{}成功: url={}", hasRef ? "图参生图" : "文生图", imageUrl);
            return ImageResult.success(imageUrl, prompt);

        } catch (Exception e) {
            log.error("{}失败: prompt={}", hasRef ? "图参生图" : "文生图", prompt, e);
            return ImageResult.failure(prompt, e.getMessage());
        }
    }

    /**
     * 是否启用文生图
     */
    public boolean isEnabled() {
        return properties.isEnabled();
    }

    // ==================== DashScope 通义万相（异步任务模式） ====================

    /**
     * 判断模型是否使用 wan2.6 新版 API
     * wan2.6 使用 image-generation/generation 端点 + messages 格式
     * 旧版使用 text2image/image-synthesis 端点 + prompt 格式
     */
    private boolean isWan26Model(String modelName) {
        return modelName != null && modelName.startsWith("wan2.6");
    }

    private String generateWithDashScope(ImageProviderConfig provider, ImageModelConfig config,
                                          String modelName, String prompt, String referenceImgUrl) {
        String apiKey = provider.getApiKey();
        boolean hasRef = referenceImgUrl != null && !referenceImgUrl.isBlank();

        // wan2.6 不支持 ref_img，图参生图需回退到旧模型
        if (isWan26Model(modelName) && hasRef) {
            log.info("wan2.6 不支持图参生图，尝试回退到 wanx2.1-t2i-plus");
            // 尝试获取旧模型配置，没有则用默认配置
            ImageModelConfig fallbackConfig = provider.getModels().getOrDefault(
                    "wanx2.1-t2i-plus", new ImageModelConfig());
            return generateWithDashScopeLegacy(apiKey, "wanx2.1-t2i-plus", fallbackConfig, prompt, referenceImgUrl);
        }

        if (isWan26Model(modelName)) {
            return generateWithDashScopeV2(apiKey, modelName, config, prompt);
        } else {
            return generateWithDashScopeLegacy(apiKey, modelName, config, prompt, referenceImgUrl);
        }
    }

    /**
     * wan2.6 新版 API（异步）
     * 端点: /api/v1/services/aigc/image-generation/generation
     * 格式: input.messages[{role:"user", content:[{text:"..."}]}]
     */
    private String generateWithDashScopeV2(String apiKey, String modelName,
                                            ImageModelConfig config, String prompt) {
        String submitUrl = "https://dashscope.aliyuncs.com/api/v1/services/aigc/image-generation/generation";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("X-DashScope-Async", "enable");

        Map<String, Object> body = new HashMap<>();
        body.put("model", modelName);
        body.put("input", Map.of("messages", List.of(
                Map.of("role", "user", "content", List.of(Map.of("text", prompt)))
        )));

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("size", config.getSize());
        if (config.getN() != null) parameters.put("n", config.getN());
        if (config.getPromptExtend() != null) parameters.put("prompt_extend", config.getPromptExtend());
        body.put("parameters", parameters);

        return submitDashScopeTask(apiKey, submitUrl, body);
    }

    /**
     * wanx2.1 / wan2.2 / wan2.5 旧版 API（异步）
     * 端点: /api/v1/services/aigc/text2image/image-synthesis
     * 格式: input.prompt + input.ref_img
     */
    private String generateWithDashScopeLegacy(String apiKey, String modelName,
                                                ImageModelConfig config, String prompt,
                                                String referenceImgUrl) {
        String submitUrl = "https://dashscope.aliyuncs.com/api/v1/services/aigc/text2image/image-synthesis";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("X-DashScope-Async", "enable");

        Map<String, Object> body = new HashMap<>();
        body.put("model", modelName);

        Map<String, Object> input = new HashMap<>();
        input.put("prompt", prompt);
        if (referenceImgUrl != null && !referenceImgUrl.isBlank()) {
            input.put("ref_img", referenceImgUrl);
        }
        body.put("input", input);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("size", config.getSize());
        if (config.getN() != null) parameters.put("n", config.getN());
        if (config.getSteps() != null) parameters.put("steps", config.getSteps());
        body.put("parameters", parameters);

        return submitDashScopeTask(apiKey, submitUrl, body);
    }

    /**
     * 统一提交 DashScope 异步任务并轮询结果
     */
    private String submitDashScopeTask(String apiKey, String submitUrl, Map<String, Object> body) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("X-DashScope-Async", "enable");

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
        log.info("DashScope 文生图请求: url={}, body={}", submitUrl, body);

        ResponseEntity<String> response;
        try {
            response = restTemplate.postForEntity(submitUrl, request, String.class);
        } catch (HttpClientErrorException e) {
            String errorBody = e.getResponseBodyAsString();
            log.error("DashScope 文生图请求失败: status={}, body={}", e.getStatusCode(), errorBody);
            try {
                JsonNode errorJson = parseJson(errorBody);
                String msg = errorJson.path("message").asText(errorBody);
                throw new RuntimeException("DashScope 文生图失败: " + msg);
            } catch (RuntimeException re) {
                if (re.getMessage().startsWith("DashScope")) throw re;
                throw new RuntimeException("DashScope 文生图失败: " + e.getStatusCode() + " - " + errorBody);
            }
        }

        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("DashScope 提交任务失败: " + response.getStatusCode());
        }

        JsonNode responseJson = parseJson(response.getBody());
        String taskId = responseJson.path("output").path("task_id").asText();
        if (taskId == null || taskId.isEmpty()) {
            throw new RuntimeException("DashScope 未返回 task_id: " + response.getBody());
        }

        log.info("DashScope 文生图任务已提交: taskId={}", taskId);
        return pollDashScopeTask(apiKey, taskId);
    }

    private String pollDashScopeTask(String apiKey, String taskId) {
        String taskUrl = "https://dashscope.aliyuncs.com/api/v1/tasks/" + taskId;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + apiKey);
        HttpEntity<Void> request = new HttpEntity<>(headers);

        int maxAttempts = 60; // 最多等待60次（约120秒）
        for (int i = 0; i < maxAttempts; i++) {
            try {
                Thread.sleep(2000); // 每2秒轮询一次
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new RuntimeException("轮询被中断", e);
            }

            ResponseEntity<String> response = restTemplate.exchange(taskUrl, HttpMethod.GET, request, String.class);
            JsonNode taskJson = parseJson(response.getBody());
            String status = taskJson.path("output").path("task_status").asText();

            log.debug("DashScope 任务[{}] 状态: {}", taskId, status);

            switch (status) {
                case "SUCCEEDED" -> {
                    // wan2.6 新版格式: output.choices[0].message.content[0].image
                    JsonNode choices = taskJson.path("output").path("choices");
                    if (choices.isArray() && choices.size() > 0) {
                        JsonNode content = choices.get(0).path("message").path("content");
                        if (content.isArray()) {
                            for (JsonNode item : content) {
                                String imageUrl = item.path("image").asText(null);
                                if (imageUrl != null && !imageUrl.isEmpty()) {
                                    return imageUrl;
                                }
                            }
                        }
                    }
                    // 旧版格式: output.results[0].url
                    JsonNode results = taskJson.path("output").path("results");
                    if (results.isArray() && results.size() > 0) {
                        String url = results.get(0).path("url").asText(null);
                        if (url != null && !url.isEmpty()) {
                            return url;
                        }
                        // 兼容部分模型返回 b64_image 的情况
                        String b64 = results.get(0).path("b64_image").asText(null);
                        if (b64 != null && !b64.isEmpty()) {
                            byte[] imageBytes = java.util.Base64.getDecoder().decode(b64);
                            return ossService.uploadBytes(imageBytes, ".png", FileBusinessType.AI_GENERATED_IMAGE);
                        }
                    }
                    log.error("DashScope 任务成功但无法解析图片URL, 响应: {}", response.getBody());
                    throw new RuntimeException("DashScope 任务成功但未返回图片URL");
                }
                case "FAILED" -> {
                    String errorMsg = taskJson.path("output").path("message").asText("未知错误");
                    throw new RuntimeException("DashScope 文生图失败: " + errorMsg);
                }
                // PENDING / RUNNING 继续轮询
            }
        }

        throw new RuntimeException("DashScope 文生图超时: taskId=" + taskId);
    }

    // ==================== OpenAI 兼容协议（同步模式） ====================

    private String generateWithOpenAi(ImageProviderConfig provider, ImageModelConfig config,
                                       String modelName, String prompt, String referenceImgUrl) {
        String baseUrl = provider.getBaseUrl();
        if (baseUrl == null || baseUrl.isEmpty()) {
            baseUrl = "https://api.openai.com/v1";
        }
        String url = baseUrl + "/images/generations";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + provider.getApiKey());

        Map<String, Object> body = new HashMap<>();
        body.put("model", modelName);
        body.put("prompt", prompt);
        body.put("n", config.getN() != null ? config.getN() : 1);
        body.put("size", config.getSize().replace("*", "x")); // OpenAI用 "1024x1024"

        if (config.getSteps() != null) {
            body.put("num_inference_steps", config.getSteps());
        }

        // 图参生图：传入参考图片URL
        if (referenceImgUrl != null && !referenceImgUrl.isBlank()) {
            body.put("image", referenceImgUrl);
        }

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);

        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("OpenAI 文生图失败: " + response.getStatusCode() + " " + response.getBody());
        }

        JsonNode responseJson = parseJson(response.getBody());
        JsonNode data = responseJson.path("data");

        if (data.isArray() && data.size() > 0) {
            // 优先取 url
            String imageUrl = data.get(0).path("url").asText(null);
            if (imageUrl != null && !imageUrl.isEmpty()) {
                return imageUrl;
            }
            // 兼容 base64 返回
            String b64 = data.get(0).path("b64_json").asText(null);
            if (b64 != null && !b64.isEmpty()) {
                byte[] imageBytes = java.util.Base64.getDecoder().decode(b64);
                return ossService.uploadBytes(imageBytes, ".png", FileBusinessType.AI_GENERATED_IMAGE);
            }
        }

        throw new RuntimeException("OpenAI 文生图未返回图片数据");
    }

    /**
     * 生成头像图片（始终上传到OSS，不依赖 uploadToOss 配置）
     * 
     * @param prompt 图片描述
     * @return 上传到OSS后的图片URL
     */
    public ImageResult generateImageForAvatar(String prompt) {
        if (!properties.isEnabled()) {
            return ImageResult.failure(prompt, "文生图功能未启用");
        }

        String modelId = properties.getDefaultModel();
        try {
            ImageModelProperties.ProviderAndModel pm = properties.parseModelId(modelId);
            ImageProviderConfig providerConfig = properties.getProviderConfig(pm.provider());
            ImageModelConfig modelConfig = properties.getModelConfig(pm.provider(), pm.model());

            log.info("生成AI助手头像: provider={}, model={}, prompt={}", pm.provider(), pm.model(), prompt);

            String imageUrl = switch (providerConfig.getType()) {
                case "dashscope" -> generateWithDashScope(providerConfig, modelConfig, pm.model(), prompt, null);
                case "openai" -> generateWithOpenAi(providerConfig, modelConfig, pm.model(), prompt, null);
                default -> throw new IllegalArgumentException("不支持的文生图供应商类型: " + providerConfig.getType());
            };

            // 强制上传到OSS
            String ossUrl = forceUploadImageToOss(imageUrl);
            log.info("AI助手头像生成并上传OSS成功: ossUrl={}", ossUrl);
            return ImageResult.success(ossUrl, prompt);

        } catch (Exception e) {
            log.error("生成AI助手头像失败: prompt={}", prompt, e);
            return ImageResult.failure(prompt, e.getMessage());
        }
    }

    /**
     * 强制下载图片并上传到OSS（失败时抛出异常，不回退到原始URL）
     */
    private String forceUploadImageToOss(String imageUrl) {
        if (imageUrl == null || imageUrl.isBlank()) {
            throw new RuntimeException("图片URL为空，无法上传到OSS");
        }
        // 使用 java.net.URI 下载，避免 RestTemplate 添加额外 HTTP 头导致预签名 URL 签名校验失败
        try {
            byte[] imageBytes = new java.net.URI(imageUrl).toURL().openStream().readAllBytes();
            String extension = ".png";
            if (imageUrl.contains(".jpg") || imageUrl.contains(".jpeg")) {
                extension = ".jpg";
            } else if (imageUrl.contains(".webp")) {
                extension = ".webp";
            }
            return ossService.uploadBytes(imageBytes, extension, FileBusinessType.AI_GENERATED_IMAGE);
        } catch (Exception e) {
            throw new RuntimeException("下载图片并上传OSS失败: " + e.getMessage(), e);
        }
    }

    // ==================== 工具方法 ====================

    /**
     * 下载图片并上传到OSS
     */
    private String uploadImageToOss(String imageUrl) {
        try {
            ResponseEntity<byte[]> response = restTemplate.getForEntity(imageUrl, byte[].class);
            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                String extension = ".png";
                if (imageUrl.contains(".jpg") || imageUrl.contains(".jpeg")) {
                    extension = ".jpg";
                } else if (imageUrl.contains(".webp")) {
                    extension = ".webp";
                }
                return ossService.uploadBytes(response.getBody(), extension, FileBusinessType.AI_GENERATED_IMAGE);
            }
            log.warn("下载图片失败，使用原始URL: {}", imageUrl);
            return imageUrl;
        } catch (Exception e) {
            log.warn("上传图片到OSS失败，使用原始URL: {}", imageUrl, e);
            return imageUrl;
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
