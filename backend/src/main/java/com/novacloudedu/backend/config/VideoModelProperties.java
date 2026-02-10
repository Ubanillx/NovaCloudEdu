package com.novacloudedu.backend.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 文生视频模型配置属性
 * 
 * 配置格式：
 * ai.video-models.default-model=dashscope/wanx2.1-t2v-plus
 * ai.video-models.providers.{providerName}.api-key=xxx
 * ai.video-models.providers.{providerName}.models.{modelName}.size=1280*720
 * ai.video-models.providers.{providerName}.models.{modelName}.duration=5
 * 
 * modelId 格式: "{providerName}/{modelName}"
 */
@Data
@Component
@ConfigurationProperties(prefix = "ai.video-models")
public class VideoModelProperties {

    /** 是否启用文生视频功能 */
    private boolean enabled = false;

    /** 默认文生视频模型 ID */
    private String defaultModel = "dashscope/wanx2.1-t2v-plus";

    /** 是否将生成的视频上传到OSS持久化存储 */
    private boolean uploadToOss = true;

    /** 各供应商配置 */
    private Map<String, VideoProviderConfig> providers = new HashMap<>();

    @Data
    public static class VideoProviderConfig {
        private boolean enabled = true;
        private String apiKey;
        /** API 基础URL */
        private String baseUrl;
        /** 供应商类型: dashscope */
        private String type = "dashscope";
        /** 该供应商下可用的模型列表 */
        private Map<String, VideoModelConfig> models = new HashMap<>();
    }

    @Data
    public static class VideoModelConfig {
        /** 视频尺寸，如 "1280*720" */
        private String size = "1280*720";
        /** 视频时长（秒） */
        private Integer duration = 5;
        /** 是否启用提示词扩展 */
        private Boolean promptExtend = true;
    }

    /**
     * 解析 modelId（格式: "provider/model"）
     */
    public ProviderAndModel parseModelId(String modelId) {
        if (modelId == null || !modelId.contains("/")) {
            throw new IllegalArgumentException("modelId 格式错误，应为 provider/model");
        }
        int idx = modelId.indexOf('/');
        return new ProviderAndModel(modelId.substring(0, idx), modelId.substring(idx + 1));
    }

    public VideoProviderConfig getProviderConfig(String providerName) {
        VideoProviderConfig config = providers.get(providerName);
        if (config == null || !config.isEnabled()) {
            throw new IllegalArgumentException("文生视频供应商未配置或未启用: " + providerName);
        }
        return config;
    }

    public VideoModelConfig getModelConfig(String providerName, String modelName) {
        VideoProviderConfig provider = getProviderConfig(providerName);
        VideoModelConfig mc = provider.getModels().get(modelName);
        return mc != null ? mc : new VideoModelConfig();
    }

    public record ProviderAndModel(String provider, String model) {}
}
