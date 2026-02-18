package com.novacloudedu.backend.interfaces.rest.dailylearning;

import com.novacloudedu.backend.application.service.ArticleChatService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request.ArticleChatRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;
import java.util.Map;

/**
 * 文章 AI 对话接口
 * 提供用户与文章内容进行 AI 对话的 SSE 流式接口
 */
@Slf4j
@RestController
@RequestMapping("/api/articles")
@RequiredArgsConstructor
@Tag(name = "文章AI对话", description = "用户与文章内容进行AI对话的接口")
public class ArticleChatController {

    private final ArticleChatService articleChatService;

    /**
     * 流式对话（SSE）
     */
    @PostMapping(value = "/chat/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "流式对话", description = "与文章内容进行AI流式对话，返回SSE事件流")
    public SseEmitter streamChat(@Valid @RequestBody ArticleChatRequest request) {
        log.info("文章流式对话请求: articleId={}", request.getArticleId());
        
        // 创建 SSE Emitter，超时时间 5 分钟
        SseEmitter emitter = new SseEmitter(5 * 60 * 1000L);
        
        // 设置完成和超时回调
        emitter.onCompletion(() -> log.debug("SSE 连接完成: articleId={}", request.getArticleId()));
        emitter.onTimeout(() -> log.warn("SSE 连接超时: articleId={}", request.getArticleId()));
        emitter.onError(e -> log.error("SSE 连接错误: articleId={}", request.getArticleId(), e));
        
        // 异步执行流式对话
        new Thread(() -> articleChatService.streamChat(
                request.getArticleId(),
                request.getMessage(),
                request.getHistory(),
                emitter
        )).start();
        
        return emitter;
    }

    /**
     * 非流式对话
     */
    @PostMapping("/chat")
    @Operation(summary = "非流式对话", description = "与文章内容进行AI对话，返回完整回复")
    public BaseResponse<Map<String, String>> chat(@Valid @RequestBody ArticleChatRequest request) {
        log.info("文章对话请求: articleId={}", request.getArticleId());
        
        String response = articleChatService.chat(
                request.getArticleId(),
                request.getMessage(),
                request.getHistory()
        );
        
        return ResultUtils.success(Map.of("content", response));
    }

    /**
     * GET 方式的流式对话（便于前端 EventSource 使用）
     */
    @GetMapping(value = "/{articleId}/chat/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "GET流式对话", description = "使用GET方式进行流式对话，便于EventSource使用")
    public SseEmitter streamChatGet(
            @PathVariable Long articleId,
            @RequestParam String message,
            @RequestParam(required = false) String historyJson) {
        log.info("文章流式对话请求(GET): articleId={}", articleId);
        
        // 创建 SSE Emitter
        SseEmitter emitter = new SseEmitter(5 * 60 * 1000L);
        
        emitter.onCompletion(() -> log.debug("SSE 连接完成: articleId={}", articleId));
        emitter.onTimeout(() -> log.warn("SSE 连接超时: articleId={}", articleId));
        emitter.onError(e -> log.error("SSE 连接错误: articleId={}", articleId, e));
        
        // 解析历史消息
        List<Map<String, String>> history = null;
        if (historyJson != null && !historyJson.isBlank()) {
            try {
                com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
                history = mapper.readValue(historyJson, 
                        mapper.getTypeFactory().constructCollectionType(List.class, Map.class));
            } catch (Exception e) {
                log.warn("解析历史消息失败", e);
            }
        }
        
        // 异步执行
        List<Map<String, String>> finalHistory = history;
        new Thread(() -> articleChatService.streamChat(articleId, message, finalHistory, emitter)).start();
        
        return emitter;
    }
}
