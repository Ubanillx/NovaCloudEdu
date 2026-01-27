package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.infrastructure.ai.DashScopeLlmService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AiChatApplicationService {

    private final DashScopeLlmService dashScopeLlmService;
    private final ExecutorService executor = Executors.newCachedThreadPool();

    public SseEmitter streamChat(String message, List<Map<String, String>> history, String systemPrompt) {
        SseEmitter emitter = new SseEmitter(300000L);
        
        executor.execute(() -> {
            try {
                List<Map<String, String>> messages = buildMessages(message, history, systemPrompt);
                
                StringBuilder fullResponse = new StringBuilder();
                
                dashScopeLlmService.streamChatWithMessages(messages, token -> {
                    try {
                        fullResponse.append(token);
                        emitter.send(SseEmitter.event()
                                .name("message")
                                .data(token));
                    } catch (IOException e) {
                        log.error("SSE发送失败", e);
                        emitter.completeWithError(e);
                    }
                });
                
                emitter.send(SseEmitter.event()
                        .name("done")
                        .data("[DONE]"));
                emitter.complete();
                
                log.info("流式对话完成，总字符数: {}", fullResponse.length());
                
            } catch (Exception e) {
                log.error("流式对话异常", e);
                try {
                    emitter.send(SseEmitter.event()
                            .name("error")
                            .data("对话失败: " + e.getMessage()));
                } catch (IOException ioException) {
                    log.error("发送错误消息失败", ioException);
                }
                emitter.completeWithError(e);
            }
        });
        
        return emitter;
    }

    private List<Map<String, String>> buildMessages(String message, List<Map<String, String>> history, String systemPrompt) {
        List<Map<String, String>> messages = new ArrayList<>();
        
        if (systemPrompt != null && !systemPrompt.trim().isEmpty()) {
            Map<String, String> systemMessage = new HashMap<>();
            systemMessage.put("role", "system");
            systemMessage.put("content", systemPrompt);
            messages.add(systemMessage);
        }
        
        if (history != null && !history.isEmpty()) {
            messages.addAll(history);
        }
        
        Map<String, String> userMessage = new HashMap<>();
        userMessage.put("role", "user");
        userMessage.put("content", message);
        messages.add(userMessage);
        
        return messages;
    }
}
