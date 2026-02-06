package com.novacloudedu.backend.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 多模型配置属性
 * 
 * 配置格式：
 * ai.chat-models.providers.{providerName}.api-key=xxx
 * ai.chat-models.providers.{providerName}.base-url=xxx（仅 openai 兼容协议需要）
 * ai.chat-models.providers.{providerName}.enabled=true
 * ai.chat-models.providers.{providerName}.models.{modelName}.type=text/vision
 * ai.chat-models.providers.{providerName}.models.{modelName}.temperature=0.7
 * ai.chat-models.providers.{providerName}.models.{modelName}.max-tokens=2000
 * 
 * modelId 格式: "{providerName}/{modelName}"，如 "dashscope/qwen-max", "openai/gpt-4o"
 */
@Data
@Component
@ConfigurationProperties(prefix = "ai.chat-models")
public class ChatModelProperties {

    /** 默认文本模型 ID，格式: provider/model */
    private String defaultModel = "dashscope/qwen-max";

    /** 默认视觉模型 ID */
    private String defaultVisionModel = "dashscope/qwen-vl-max";

    /** 各供应商配置 */
    private Map<String, ProviderConfig> providers = new HashMap<>();

    @Data
    public static class ProviderConfig {
        private boolean enabled = true;
        private String apiKey;
        /** 仅 OpenAI 兼容协议需要（DeepSeek/Moonshot/SiliconFlow 等） */
        private String baseUrl;
        /** 该供应商下可用的模型列表 */
        private Map<String, ModelConfig> models = new HashMap<>();
    }

    @Data
    public static class ModelConfig {
        /** 模型类型: text / vision */
        private String type = "text";
        private Double temperature = 0.7;
        private Integer maxTokens = 2000;
        private Double topP = 0.8;
    }

    /**
     * 解析 modelId（格式: "provider/model"）
     */
    public ProviderAndModel parseModelId(String modelId) {
        if (modelId == null || !modelId.contains("/")) {
            throw new IllegalArgumentException("modelId 格式错误，应为 provider/model，如 dashscope/qwen-max");
        }
        int idx = modelId.indexOf('/');
        return new ProviderAndModel(modelId.substring(0, idx), modelId.substring(idx + 1));
    }

    /**
     * 获取指定 modelId 的供应商配置
     */
    public ProviderConfig getProviderConfig(String providerName) {
        ProviderConfig config = providers.get(providerName);
        if (config == null || !config.isEnabled()) {
            throw new IllegalArgumentException("模型供应商未配置或未启用: " + providerName);
        }
        return config;
    }

    /**
     * 获取指定 modelId 的模型配置（如果有详细配置则返回，否则返回默认值）
     */
    public ModelConfig getModelConfig(String providerName, String modelName) {
        ProviderConfig provider = getProviderConfig(providerName);
        ModelConfig mc = provider.getModels().get(modelName);
        return mc != null ? mc : new ModelConfig();
    }

    public record ProviderAndModel(String provider, String model) {}
}
