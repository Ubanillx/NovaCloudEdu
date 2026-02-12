package com.novacloudedu.backend.infrastructure.ai;

import com.novacloudedu.backend.config.ChatModelProperties;
import com.novacloudedu.backend.config.ChatModelProperties.ModelConfig;
import com.novacloudedu.backend.config.ChatModelProperties.ProviderAndModel;
import com.novacloudedu.backend.config.ChatModelProperties.ProviderConfig;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.chat.StreamingChatLanguageModel;
import dev.langchain4j.model.dashscope.QwenChatModel;
import dev.langchain4j.model.dashscope.QwenStreamingChatModel;
import dev.langchain4j.model.ollama.OllamaChatModel;
import dev.langchain4j.model.ollama.OllamaStreamingChatModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.model.openai.OpenAiStreamingChatModel;
import dev.langchain4j.model.zhipu.ZhipuAiChatModel;
import dev.langchain4j.model.zhipu.ZhipuAiStreamingChatModel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * 聊天模型工厂
 * 
 * 根据 modelId（格式: "provider/model"）创建和缓存 Langchain4j StreamingChatLanguageModel 实例。
 * 支持的供应商：
 * - dashscope: 阿里云通义千问（qwen-max, qwen-vl-max 等）
 * - openai: OpenAI 兼容协议（GPT-4o, DeepSeek, Moonshot, SiliconFlow 等）
 * - zhipu: 智谱 GLM
 * - ollama: 本地模型
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ChatModelFactory {

    private final ChatModelProperties properties;

    /** 流式模型实例缓存 */
    private final Map<String, StreamingChatLanguageModel> modelCache = new ConcurrentHashMap<>();
    /** 非流式模型实例缓存（用于 tool calling） */
    private final Map<String, ChatLanguageModel> chatModelCache = new ConcurrentHashMap<>();

    /**
     * 获取流式聊天模型（带缓存）
     * 
     * @param modelId 格式: "provider/model"，如 "dashscope/qwen-max"
     */
    public StreamingChatLanguageModel getStreamingModel(String modelId) {
        return modelCache.computeIfAbsent(modelId, this::createStreamingModel);
    }

    /**
     * 获取默认文本模型
     */
    public StreamingChatLanguageModel getDefaultModel() {
        return getStreamingModel(properties.getDefaultModel());
    }

    /**
     * 获取默认视觉模型
     */
    public StreamingChatLanguageModel getDefaultVisionModel() {
        return getStreamingModel(properties.getDefaultVisionModel());
    }

    /**
     * 获取所有可用的模型列表（仅 enabled=true 的供应商）
     */
    public List<Map<String, Object>> listAvailableModels() {
        return listAllModels(true);
    }

    /**
     * 获取全量模型列表（包含所有供应商，标注启用状态和默认标记）
     */
    public List<Map<String, Object>> listAllModels(boolean enabledOnly) {
        String defaultModel = properties.getDefaultModel();
        String defaultVision = properties.getDefaultVisionModel();

        return properties.getProviders().entrySet().stream()
                .filter(e -> !enabledOnly || e.getValue().isEnabled())
                .flatMap(provider -> provider.getValue().getModels().entrySet().stream()
                        .map(model -> {
                            String modelId = provider.getKey() + "/" + model.getKey();
                            Map<String, Object> info = new LinkedHashMap<>();
                            info.put("modelId", modelId);
                            info.put("provider", provider.getKey());
                            info.put("model", model.getKey());
                            info.put("type", model.getValue().getType());
                            info.put("enabled", provider.getValue().isEnabled());
                            info.put("isDefault", modelId.equals(defaultModel));
                            info.put("isDefaultVision", modelId.equals(defaultVision));
                            return info;
                        }))
                .collect(Collectors.toList());
    }

    /**
     * 创建带自定义参数的流式聊天模型（不缓存，每次新建）
     * 用于 AI 助手等需要自定义 temperature/topP/maxTokens 的场景
     */
    public StreamingChatLanguageModel createStreamingModelWithParams(
            String modelId, Double temperature, Double topP, Integer maxTokens) {
        return createStreamingModelWithParams(modelId, temperature, topP, maxTokens, false);
    }

    /**
     * 创建带自定义参数和能力开关的流式聊天模型（不缓存，每次新建）
     *
     * @param enableSearch 是否启用联网搜索（仅 DashScope 供应商支持）
     */
    public StreamingChatLanguageModel createStreamingModelWithParams(
            String modelId, Double temperature, Double topP, Integer maxTokens,
            boolean enableSearch) {
        ProviderAndModel pm = properties.parseModelId(modelId);
        ProviderConfig providerConfig = properties.getProviderConfig(pm.provider());

        log.info("创建自定义参数模型: provider={}, model={}, temperature={}, topP={}, maxTokens={}, enableSearch={}",
                pm.provider(), pm.model(), temperature, topP, maxTokens, enableSearch);

        return switch (pm.provider()) {
            case "dashscope" -> {
                var builder = QwenStreamingChatModel.builder()
                        .apiKey(providerConfig.getApiKey())
                        .modelName(pm.model())
                        .temperature(temperature != null ? temperature.floatValue() : 0.7f)
                        .maxTokens(maxTokens != null ? maxTokens : 2000)
                        .topP(topP);
                if (enableSearch) {
                    builder.enableSearch(true);
                }
                yield builder.build();
            }
            case "openai", "deepseek", "moonshot", "siliconflow" -> {
                var builder = OpenAiStreamingChatModel.builder()
                        .apiKey(providerConfig.getApiKey())
                        .modelName(pm.model())
                        .temperature(temperature)
                        .maxTokens(maxTokens)
                        .topP(topP);
                if (providerConfig.getBaseUrl() != null && !providerConfig.getBaseUrl().isEmpty()) {
                    builder.baseUrl(providerConfig.getBaseUrl());
                }
                yield builder.build();
            }
            case "zhipu" -> ZhipuAiStreamingChatModel.builder()
                    .apiKey(providerConfig.getApiKey())
                    .model(pm.model())
                    .temperature(temperature)
                    .maxToken(maxTokens != null ? maxTokens : 2000)
                    .topP(topP)
                    .build();
            case "ollama" -> OllamaStreamingChatModel.builder()
                    .baseUrl(providerConfig.getBaseUrl())
                    .modelName(pm.model())
                    .temperature(temperature)
                    .build();
            default -> throw new IllegalArgumentException("不支持的模型供应商: " + pm.provider());
        };
    }

    // ==================== 非流式模型（Tool Calling 场景） ====================

    /**
     * 获取非流式聊天模型（带缓存），用于 tool calling 等需要同步响应的场景
     */
    public ChatLanguageModel getChatModel(String modelId) {
        return chatModelCache.computeIfAbsent(modelId, this::createChatModel);
    }

    /**
     * 创建带自定义参数的非流式聊天模型（不缓存），用于 tool calling
     */
    public ChatLanguageModel createChatModelWithParams(
            String modelId, Double temperature, Double topP, Integer maxTokens) {
        ProviderAndModel pm = properties.parseModelId(modelId);
        ProviderConfig providerConfig = properties.getProviderConfig(pm.provider());

        log.info("创建非流式模型(tool calling): provider={}, model={}, temperature={}, topP={}, maxTokens={}",
                pm.provider(), pm.model(), temperature, topP, maxTokens);

        return switch (pm.provider()) {
            case "dashscope" -> QwenChatModel.builder()
                    .apiKey(providerConfig.getApiKey())
                    .modelName(pm.model())
                    .temperature(temperature != null ? temperature.floatValue() : 0.7f)
                    .maxTokens(maxTokens != null ? maxTokens : 4096)
                    .topP(topP)
                    .build();
            case "openai", "deepseek", "moonshot", "siliconflow" -> {
                var builder = OpenAiChatModel.builder()
                        .apiKey(providerConfig.getApiKey())
                        .modelName(pm.model())
                        .temperature(temperature)
                        .maxTokens(maxTokens)
                        .topP(topP);
                if (providerConfig.getBaseUrl() != null && !providerConfig.getBaseUrl().isEmpty()) {
                    builder.baseUrl(providerConfig.getBaseUrl());
                }
                yield builder.build();
            }
            case "zhipu" -> ZhipuAiChatModel.builder()
                    .apiKey(providerConfig.getApiKey())
                    .model(pm.model())
                    .temperature(temperature)
                    .maxToken(maxTokens != null ? maxTokens : 4096)
                    .topP(topP)
                    .build();
            case "ollama" -> OllamaChatModel.builder()
                    .baseUrl(providerConfig.getBaseUrl())
                    .modelName(pm.model())
                    .temperature(temperature)
                    .build();
            default -> throw new IllegalArgumentException("不支持的模型供应商: " + pm.provider());
        };
    }

    /**
     * 清除缓存（配置变更后调用）
     */
    public void clearCache() {
        modelCache.clear();
        chatModelCache.clear();
        log.info("模型缓存已清除");
    }

    // ==================== 私有方法：创建各供应商模型实例 ====================

    private StreamingChatLanguageModel createStreamingModel(String modelId) {
        ProviderAndModel pm = properties.parseModelId(modelId);
        ProviderConfig providerConfig = properties.getProviderConfig(pm.provider());
        ModelConfig modelConfig = properties.getModelConfig(pm.provider(), pm.model());

        log.info("创建流式聊天模型: provider={}, model={}", pm.provider(), pm.model());

        return switch (pm.provider()) {
            case "dashscope" -> createDashScopeModel(providerConfig, modelConfig, pm.model());
            case "openai", "deepseek", "moonshot", "siliconflow" ->
                    createOpenAiModel(providerConfig, modelConfig, pm.model());
            case "zhipu" -> createZhipuModel(providerConfig, modelConfig, pm.model());
            case "ollama" -> createOllamaModel(providerConfig, modelConfig, pm.model());
            default -> throw new IllegalArgumentException("不支持的模型供应商: " + pm.provider());
        };
    }

    private StreamingChatLanguageModel createDashScopeModel(ProviderConfig provider, ModelConfig model, String modelName) {
        return QwenStreamingChatModel.builder()
                .apiKey(provider.getApiKey())
                .modelName(modelName)
                .temperature(model.getTemperature().floatValue())
                .maxTokens(model.getMaxTokens())
                .topP(model.getTopP())
                .build();
    }

    private StreamingChatLanguageModel createOpenAiModel(ProviderConfig provider, ModelConfig model, String modelName) {
        var builder = OpenAiStreamingChatModel.builder()
                .apiKey(provider.getApiKey())
                .modelName(modelName)
                .temperature(model.getTemperature())
                .maxTokens(model.getMaxTokens())
                .topP(model.getTopP());

        if (provider.getBaseUrl() != null && !provider.getBaseUrl().isEmpty()) {
            builder.baseUrl(provider.getBaseUrl());
        }

        return builder.build();
    }

    private StreamingChatLanguageModel createZhipuModel(ProviderConfig provider, ModelConfig model, String modelName) {
        return ZhipuAiStreamingChatModel.builder()
                .apiKey(provider.getApiKey())
                .model(modelName)
                .temperature(model.getTemperature())
                .maxToken(model.getMaxTokens())
                .topP(model.getTopP())
                .build();
    }

    private StreamingChatLanguageModel createOllamaModel(ProviderConfig provider, ModelConfig model, String modelName) {
        return OllamaStreamingChatModel.builder()
                .baseUrl(provider.getBaseUrl())
                .modelName(modelName)
                .temperature(model.getTemperature())
                .build();
    }

    // ==================== 非流式模型创建 ====================

    private ChatLanguageModel createChatModel(String modelId) {
        ProviderAndModel pm = properties.parseModelId(modelId);
        ProviderConfig providerConfig = properties.getProviderConfig(pm.provider());
        ModelConfig modelConfig = properties.getModelConfig(pm.provider(), pm.model());

        log.info("创建非流式聊天模型: provider={}, model={}", pm.provider(), pm.model());

        return switch (pm.provider()) {
            case "dashscope" -> QwenChatModel.builder()
                    .apiKey(providerConfig.getApiKey())
                    .modelName(pm.model())
                    .temperature(modelConfig.getTemperature().floatValue())
                    .maxTokens(modelConfig.getMaxTokens())
                    .topP(modelConfig.getTopP())
                    .build();
            case "openai", "deepseek", "moonshot", "siliconflow" -> {
                var builder = OpenAiChatModel.builder()
                        .apiKey(providerConfig.getApiKey())
                        .modelName(pm.model())
                        .temperature(modelConfig.getTemperature())
                        .maxTokens(modelConfig.getMaxTokens())
                        .topP(modelConfig.getTopP());
                if (providerConfig.getBaseUrl() != null && !providerConfig.getBaseUrl().isEmpty()) {
                    builder.baseUrl(providerConfig.getBaseUrl());
                }
                yield builder.build();
            }
            case "zhipu" -> ZhipuAiChatModel.builder()
                    .apiKey(providerConfig.getApiKey())
                    .model(pm.model())
                    .temperature(modelConfig.getTemperature())
                    .maxToken(modelConfig.getMaxTokens())
                    .topP(modelConfig.getTopP())
                    .build();
            case "ollama" -> OllamaChatModel.builder()
                    .baseUrl(providerConfig.getBaseUrl())
                    .modelName(pm.model())
                    .temperature(modelConfig.getTemperature())
                    .build();
            default -> throw new IllegalArgumentException("不支持的模型供应商: " + pm.provider());
        };
    }
}
