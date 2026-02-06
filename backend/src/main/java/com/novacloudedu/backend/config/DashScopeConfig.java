package com.novacloudedu.backend.config;

import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.multimodalconversation.MultiModalConversation;
import com.alibaba.dashscope.embeddings.TextEmbedding;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 阿里云灵积平台 (DashScope) 配置类
 */
@Slf4j
@Configuration
public class DashScopeConfig {

    @Value("${ai.dashscope.api-key}")
    private String apiKey;

    @Value("${ai.dashscope.llm.model-name}")
    private String llmModelName;

    @Value("${ai.dashscope.embedding.model-name}")
    private String embeddingModelName;

    @Value("${ai.dashscope.llm.vision-model-name:qwen-vl-max}")
    private String visionModelName;

    /**
     * 配置 DashScope Generation 客户端
     */
    @Bean
    public Generation generation() {
        log.info("初始化 DashScope Generation 客户端，模型: {}", llmModelName);
        // DashScope SDK 会自动从环境变量或配置中读取 API Key
        System.setProperty("DASHSCOPE_API_KEY", apiKey);
        return new Generation();
    }

    /**
     * 配置 DashScope MultiModalConversation 客户端（视觉多模态）
     */
    @Bean
    public MultiModalConversation multiModalConversation() {
        log.info("初始化 DashScope MultiModalConversation 客户端，模型: {}", visionModelName);
        return new MultiModalConversation();
    }

    /**
     * 配置 DashScope TextEmbedding 客户端
     */
    @Bean
    public TextEmbedding textEmbedding() {
        log.info("初始化 DashScope TextEmbedding 客户端，模型: {}", embeddingModelName);
        System.setProperty("DASHSCOPE_API_KEY", apiKey);
        return new TextEmbedding();
    }

    public String getApiKey() {
        return apiKey;
    }

    public String getLlmModelName() {
        return llmModelName;
    }

    public String getEmbeddingModelName() {
        return embeddingModelName;
    }
}
