package com.novacloudedu.backend.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 文生图模型配置属性
 * 
 * 配置格式：
 * ai.image-models.default-model=dashscope/wanx2.1-t2i-turbo
 * ai.image-models.providers.{providerName}.api-key=xxx
 * ai.image-models.providers.{providerName}.base-url=xxx
 * ai.image-models.providers.{providerName}.enabled=true
 * ai.image-models.providers.{providerName}.models.{modelName}.size=1024*1024
 * ai.image-models.providers.{providerName}.models.{modelName}.steps=20
 * 
 * modelId 格式: "{providerName}/{modelName}"，如 "dashscope/wanx2.1-t2i-turbo"
 */
@Data
@Component
@ConfigurationProperties(prefix = "ai.image-models")
public class ImageModelProperties {

    /** 是否启用文生图功能 */
    private boolean enabled = true;

    /** 默认文生图模型 ID */
    private String defaultModel = "dashscope/wanx2.1-t2i-turbo";

    /** 是否将生成的图片上传到OSS持久化存储 */
    private boolean uploadToOss = true;

    /** 各供应商配置 */
    private Map<String, ImageProviderConfig> providers = new HashMap<>();

    @Data
    public static class ImageProviderConfig {
        private boolean enabled = true;
        private String apiKey;
        /** API 基础URL（OpenAI兼容协议需要） */
        private String baseUrl;
        /** 供应商类型: dashscope / openai */
        private String type = "dashscope";
        /** 该供应商下可用的模型列表 */
        private Map<String, ImageModelConfig> models = new HashMap<>();
    }

    @Data
    public static class ImageModelConfig {
        /** 图片尺寸，如 "1024*1024"（旧）或 "1280*1280"（wan2.6） */
        private String size = "1024*1024";
        /** 生成步数（仅部分模型支持） */
        private Integer steps;
        /** 生成数量 */
        private Integer n = 1;
        /** 是否启用提示词扩展（wan2.6 推荐开启） */
        private Boolean promptExtend;
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

    public ImageProviderConfig getProviderConfig(String providerName) {
        ImageProviderConfig config = providers.get(providerName);
        if (config == null || !config.isEnabled()) {
            throw new IllegalArgumentException("文生图供应商未配置或未启用: " + providerName);
        }
        return config;
    }

    public ImageModelConfig getModelConfig(String providerName, String modelName) {
        ImageProviderConfig provider = getProviderConfig(providerName);
        ImageModelConfig mc = provider.getModels().get(modelName);
        return mc != null ? mc : new ImageModelConfig();
    }

    public record ProviderAndModel(String provider, String model) {}
}
