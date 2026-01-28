package com.novacloudedu.backend.infrastructure.ai;

import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

/**
 * 千问大模型客户端
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class QwenClient {

    private final RestTemplate restTemplate;

    @Value("${ai.dashscope.api-key:}")
    private String apiKey;

    @Value("${ai.dashscope.base-url:https://dashscope.aliyuncs.com/api/v1}")
    private String baseUrl;

    /**
     * 聊天对话
     */
    public ChatResponse chat(ChatRequest request) {
        String url = baseUrl + "/services/aigc/text-generation/generation";
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
        
        // 构建请求体
        Map<String, Object> requestBody = Map.of(
                "model", request.getModel(),
                "input", Map.of("messages", request.getMessages().stream()
                        .map(m -> Map.of("role", m.role(), "content", m.content()))
                        .toList()),
                "parameters", Map.of(
                        "temperature", request.getTemperature(),
                        "max_tokens", request.getMaxTokens(),
                        "result_format", "message"
                )
        );
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        
        try {
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
            
            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                Map<String, Object> body = response.getBody();
                Map<String, Object> output = (Map<String, Object>) body.get("output");
                Map<String, Object> usage = (Map<String, Object>) body.get("usage");
                
                if (output != null) {
                    List<Map<String, Object>> choices = (List<Map<String, Object>>) output.get("choices");
                    if (choices != null && !choices.isEmpty()) {
                        Map<String, Object> choice = choices.get(0);
                        Map<String, Object> message = (Map<String, Object>) choice.get("message");
                        if (message != null) {
                            String content = (String) message.get("content");
                            return ChatResponse.builder()
                                    .content(content)
                                    .usage(usage)
                                    .build();
                        }
                    }
                    
                    // 兼容旧格式
                    String text = (String) output.get("text");
                    if (text != null) {
                        return ChatResponse.builder()
                                .content(text)
                                .usage(usage)
                                .build();
                    }
                }
                
                throw new RuntimeException("千问API响应格式异常");
            }
            
            throw new RuntimeException("千问API调用失败: " + response.getStatusCode());
            
        } catch (Exception e) {
            log.error("千问API调用异常: {}", e.getMessage(), e);
            throw new RuntimeException("千问API调用异常: " + e.getMessage(), e);
        }
    }

    /**
     * 文本向量化
     */
    public EmbeddingResponse embedding(EmbeddingRequest request) {
        String url = baseUrl + "/services/embeddings/text-embedding/text-embedding";
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
        
        Map<String, Object> requestBody = Map.of(
                "model", request.getModel(),
                "input", Map.of("texts", request.getTexts()),
                "parameters", Map.of("text_type", "query")
        );
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        
        try {
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
            
            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                Map<String, Object> body = response.getBody();
                Map<String, Object> output = (Map<String, Object>) body.get("output");
                
                if (output != null) {
                    List<Map<String, Object>> embeddings = (List<Map<String, Object>>) output.get("embeddings");
                    if (embeddings != null) {
                        List<List<Double>> vectors = embeddings.stream()
                                .map(e -> (List<Double>) e.get("embedding"))
                                .toList();
                        return EmbeddingResponse.builder()
                                .embeddings(vectors)
                                .build();
                    }
                }
                
                throw new RuntimeException("千问Embedding API响应格式异常");
            }
            
            throw new RuntimeException("千问Embedding API调用失败: " + response.getStatusCode());
            
        } catch (Exception e) {
            log.error("千问Embedding API调用异常: {}", e.getMessage(), e);
            throw new RuntimeException("千问Embedding API调用异常: " + e.getMessage(), e);
        }
    }

    // ==================== 请求/响应类 ====================

    @Data
    @Builder
    public static class ChatRequest {
        private String model;
        private List<Message> messages;
        private Double temperature;
        private Integer maxTokens;
    }

    @Data
    @Builder
    public static class ChatResponse {
        private String content;
        private Map<String, Object> usage;
    }

    public record Message(String role, String content) {}

    @Data
    @Builder
    public static class EmbeddingRequest {
        private String model;
        private List<String> texts;
    }

    @Data
    @Builder
    public static class EmbeddingResponse {
        private List<List<Double>> embeddings;
    }
}
