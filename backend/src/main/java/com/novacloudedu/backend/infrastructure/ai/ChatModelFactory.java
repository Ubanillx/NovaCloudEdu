package com.novacloudedu.backend.infrastructure.ai;

import com.novacloudedu.backend.config.ChatModelProperties;
import com.novacloudedu.backend.config.ChatModelProperties.ModelConfig;
import com.novacloudedu.backend.config.ChatModelProperties.ProviderAndModel;
import com.novacloudedu.backend.config.ChatModelProperties.ProviderConfig;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.model.chat.ChatModel;
import dev.langchain4j.model.chat.StreamingChatModel;
import dev.langchain4j.community.model.dashscope.QwenChatModel;
import dev.langchain4j.community.model.dashscope.QwenStreamingChatModel;
import dev.langchain4j.model.ollama.OllamaChatModel;
import dev.langchain4j.model.ollama.OllamaStreamingChatModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.model.openai.OpenAiStreamingChatModel;
import dev.langchain4j.community.model.zhipu.ZhipuAiChatModel;
import dev.langchain4j.community.model.zhipu.ZhipuAiStreamingChatModel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Comparator;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * 聊天模型工厂
 * 
 * 根据 modelId（格式: "provider/model"）创建和缓存 Langchain4j StreamingChatModel 实例。
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
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    /** 流式模型实例缓存 */
    private final Map<String, StreamingChatModel> modelCache = new ConcurrentHashMap<>();
    /** 非流式模型实例缓存（用于 tool calling） */
    private final Map<String, ChatModel> chatModelCache = new ConcurrentHashMap<>();
    private volatile List<Map<String, Object>> openRouterModelCache = List.of();
    private volatile long openRouterModelCacheAt = 0L;
    private static final long OPENROUTER_MODEL_CACHE_TTL_MS = 10 * 60 * 1000L;

    /**
     * 获取流式聊天模型（带缓存）
     * 
     * @param modelId 格式: "provider/model"，如 "dashscope/qwen-max"
     */
    public StreamingChatModel getStreamingModel(String modelId) {
        return modelCache.computeIfAbsent(modelId, this::createStreamingModel);
    }

    /**
     * 获取默认文本模型
     */
    public StreamingChatModel getDefaultModel() {
        return getStreamingModel(properties.getDefaultModel());
    }

    /**
     * 获取默认视觉模型
     */
    public StreamingChatModel getDefaultVisionModel() {
        return getStreamingModel(properties.getDefaultVisionModel());
    }

    /**
     * 获取所有可用的模型列表（仅 enabled=true 的供应商）
     */
    public List<Map<String, Object>> listAvailableModels() {
        return listAllModels(true);
    }

    public List<Map<String, Object>> listAvailableModels(String providerName) {
        return listAllModels(true).stream()
                .filter(model -> providerName == null || providerName.isBlank()
                        || providerName.equals(model.get("provider")))
                .collect(Collectors.toList());
    }

    public List<Map<String, Object>> listAvailableProviders() {
        Map<String, Long> modelCounts = listAllModels(true).stream()
                .collect(Collectors.groupingBy(
                        model -> String.valueOf(model.get("provider")),
                        LinkedHashMap::new,
                        Collectors.counting()
                ));

        return properties.getProviders().entrySet().stream()
                .filter(e -> e.getValue().isEnabled())
                .map(e -> {
                    Map<String, Object> info = new LinkedHashMap<>();
                    info.put("provider", e.getKey());
                    info.put("enabled", e.getValue().isEnabled());
                    info.put("modelCount", modelCounts.getOrDefault(e.getKey(), 0L));
                    info.put("isDefault", properties.getDefaultModel() != null
                            && properties.getDefaultModel().startsWith(e.getKey() + "/"));
                    return info;
                })
                .collect(Collectors.toList());
    }

    /**
     * 获取全量模型列表（包含所有供应商，标注启用状态和默认标记）
     */
    public List<Map<String, Object>> listAllModels(boolean enabledOnly) {
        String defaultModel = properties.getDefaultModel();
        String defaultVision = properties.getDefaultVisionModel();

        return properties.getProviders().entrySet().stream()
                .filter(e -> !enabledOnly || e.getValue().isEnabled())
                .flatMap(provider -> {
                    if ("openrouter".equals(provider.getKey()) && provider.getValue().isEnabled()) {
                        return listOpenRouterModels(provider.getValue(), defaultModel, defaultVision).stream();
                    }
                    return listConfiguredModels(provider.getKey(), provider.getValue(), defaultModel, defaultVision).stream();
                })
                .collect(Collectors.toList());
    }

    private List<Map<String, Object>> listConfiguredModels(String providerName, ProviderConfig providerConfig,
                                                           String defaultModel, String defaultVision) {
        return providerConfig.getModels().entrySet().stream()
                .map(model -> buildModelInfo(
                        providerName,
                        model.getKey(),
                        model.getKey(),
                        model.getValue(),
                        providerConfig.isEnabled(),
                        defaultModel,
                        defaultVision,
                        null,
                        null
                ))
                .collect(Collectors.toList());
    }

    private List<Map<String, Object>> listOpenRouterModels(ProviderConfig providerConfig,
                                                           String defaultModel, String defaultVision) {
        List<Map<String, Object>> dynamicModels = fetchOpenRouterModels(providerConfig, defaultModel, defaultVision);
        if (!dynamicModels.isEmpty()) {
            return dynamicModels;
        }
        return listConfiguredModels("openrouter", providerConfig, defaultModel, defaultVision);
    }

    private List<Map<String, Object>> fetchOpenRouterModels(ProviderConfig providerConfig,
                                                            String defaultModel, String defaultVision) {
        long now = System.currentTimeMillis();
        if (!openRouterModelCache.isEmpty() && now - openRouterModelCacheAt < OPENROUTER_MODEL_CACHE_TTL_MS) {
            return openRouterModelCache;
        }

        try {
            String baseUrl = providerConfig.getBaseUrl() != null && !providerConfig.getBaseUrl().isBlank()
                    ? providerConfig.getBaseUrl()
                    : "https://openrouter.ai/api/v1";
            String url = baseUrl.replaceAll("/+$", "") + "/models?output_modalities=text";

            HttpHeaders headers = new HttpHeaders();
            if (providerConfig.getApiKey() != null && !providerConfig.getApiKey().isBlank()) {
                headers.setBearerAuth(providerConfig.getApiKey());
            }

            ResponseEntity<String> response = restTemplate.exchange(
                    url, HttpMethod.GET, new HttpEntity<>(headers), String.class);
            JsonNode data = objectMapper.readTree(response.getBody()).path("data");
            if (!data.isArray()) {
                return openRouterModelCache;
            }

            Map<String, ModelConfig> configuredModels = providerConfig.getModels();
            List<Map<String, Object>> models = new ArrayList<>();
            for (JsonNode node : data) {
                String model = node.path("id").asText("");
                if (model.isBlank()) {
                    continue;
                }
                ModelConfig configured = configuredModels.get(model);
                ModelConfig defaults = configured != null ? configured : new ModelConfig();
                String type = inferOpenRouterModelType(node, defaults);
                Integer maxTokens = configured != null && configured.getMaxTokens() != null
                        ? configured.getMaxTokens()
                        : openRouterMaxTokens(node);
                Map<String, Object> info = buildModelInfo(
                        "openrouter",
                        model,
                        node.path("name").asText(model),
                        defaults,
                        true,
                        defaultModel,
                        defaultVision,
                        node.path("context_length").isNumber() ? node.path("context_length").asInt() : null,
                        maxTokens
                );
                info.put("type", type);
                info.put("source", configured != null ? "configured+openrouter" : "openrouter");
                info.put("description", node.path("description").asText(null));
                models.add(info);
            }

            models.sort(Comparator.comparing(model -> String.valueOf(model.get("modelId"))));
            openRouterModelCache = models;
            openRouterModelCacheAt = now;
            return models;
        } catch (Exception e) {
            log.warn("获取 OpenRouter 模型列表失败，回退到本地配置: {}", e.getMessage());
            return openRouterModelCache;
        }
    }

    private String inferOpenRouterModelType(JsonNode node, ModelConfig defaults) {
        JsonNode inputs = node.path("architecture").path("input_modalities");
        if (inputs.isArray()) {
            for (JsonNode input : inputs) {
                if ("image".equalsIgnoreCase(input.asText())) {
                    return "vision";
                }
            }
        }
        return defaults.getType() != null ? defaults.getType() : "text";
    }

    private Integer openRouterMaxTokens(JsonNode node) {
        JsonNode maxCompletion = node.path("top_provider").path("max_completion_tokens");
        if (maxCompletion.isNumber() && maxCompletion.asInt() > 0) {
            return Math.min(maxCompletion.asInt(), 8000);
        }
        return 2000;
    }

    private Map<String, Object> buildModelInfo(String providerName, String model, String displayName,
                                               ModelConfig config, boolean enabled,
                                               String defaultModel, String defaultVision,
                                               Integer contextLength, Integer maxTokensOverride) {
        String modelId = providerName + "/" + model;
        Map<String, Object> info = new LinkedHashMap<>();
        info.put("modelId", modelId);
        info.put("provider", providerName);
        info.put("model", model);
        info.put("name", displayName);
        info.put("type", config.getType());
        info.put("enabled", enabled);
        info.put("isDefault", modelId.equals(defaultModel));
        info.put("isDefaultVision", modelId.equals(defaultVision));
        info.put("temperature", config.getTemperature());
        info.put("topP", config.getTopP());
        info.put("maxTokens", maxTokensOverride != null ? maxTokensOverride : config.getMaxTokens());
        if (contextLength != null) {
            info.put("contextLength", contextLength);
        }
        return info;
    }

    /**
     * 创建带自定义参数的流式聊天模型（不缓存，每次新建）
     * 用于 AI 助手等需要自定义 temperature/topP/maxTokens 的场景
     */
    public StreamingChatModel createStreamingModelWithParams(
            String modelId, Double temperature, Double topP, Integer maxTokens) {
        return createStreamingModelWithParams(modelId, temperature, topP, maxTokens, false);
    }

    /**
     * 创建带自定义参数和能力开关的流式聊天模型（不缓存，每次新建）
     *
     * @param enableSearch 是否启用联网搜索（仅 DashScope 供应商支持）
     */
    public StreamingChatModel createStreamingModelWithParams(
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
            case "openai", "deepseek", "moonshot", "siliconflow", "openrouter" -> {
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
    public ChatModel getChatModel(String modelId) {
        return chatModelCache.computeIfAbsent(modelId, this::createChatModel);
    }

    /**
     * 创建带自定义参数的非流式聊天模型（不缓存），用于 tool calling
     */
    public ChatModel createChatModelWithParams(
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
            case "openai", "deepseek", "moonshot", "siliconflow", "openrouter" -> {
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

    private StreamingChatModel createStreamingModel(String modelId) {
        ProviderAndModel pm = properties.parseModelId(modelId);
        ProviderConfig providerConfig = properties.getProviderConfig(pm.provider());
        ModelConfig modelConfig = properties.getModelConfig(pm.provider(), pm.model());

        log.info("创建流式聊天模型: provider={}, model={}", pm.provider(), pm.model());

        return switch (pm.provider()) {
            case "dashscope" -> createDashScopeModel(providerConfig, modelConfig, pm.model());
            case "openai", "deepseek", "moonshot", "siliconflow", "openrouter" ->
                    createOpenAiModel(providerConfig, modelConfig, pm.model());
            case "zhipu" -> createZhipuModel(providerConfig, modelConfig, pm.model());
            case "ollama" -> createOllamaModel(providerConfig, modelConfig, pm.model());
            default -> throw new IllegalArgumentException("不支持的模型供应商: " + pm.provider());
        };
    }

    private StreamingChatModel createDashScopeModel(ProviderConfig provider, ModelConfig model, String modelName) {
        return QwenStreamingChatModel.builder()
                .apiKey(provider.getApiKey())
                .modelName(modelName)
                .temperature(model.getTemperature().floatValue())
                .maxTokens(model.getMaxTokens())
                .topP(model.getTopP())
                .build();
    }

    private StreamingChatModel createOpenAiModel(ProviderConfig provider, ModelConfig model, String modelName) {
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

    private StreamingChatModel createZhipuModel(ProviderConfig provider, ModelConfig model, String modelName) {
        return ZhipuAiStreamingChatModel.builder()
                .apiKey(provider.getApiKey())
                .model(modelName)
                .temperature(model.getTemperature())
                .maxToken(model.getMaxTokens())
                .topP(model.getTopP())
                .build();
    }

    private StreamingChatModel createOllamaModel(ProviderConfig provider, ModelConfig model, String modelName) {
        return OllamaStreamingChatModel.builder()
                .baseUrl(provider.getBaseUrl())
                .modelName(modelName)
                .temperature(model.getTemperature())
                .build();
    }

    // ==================== 非流式模型创建 ====================

    private ChatModel createChatModel(String modelId) {
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
            case "openai", "deepseek", "moonshot", "siliconflow", "openrouter" -> {
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
