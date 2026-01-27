package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.AiChatApplicationService;
import com.novacloudedu.backend.interfaces.rest.ai.dto.ChatRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Slf4j
@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
@Tag(name = "AI聊天", description = "AI聊天相关接口")
public class AiChatController {

    private final AiChatApplicationService aiChatApplicationService;

    @PostMapping(value = "/chat/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "流式对话", description = "使用SSE推送方式进行AI对话")
    public SseEmitter streamChat(@Valid @RequestBody ChatRequest request) {
        log.info("收到流式对话请求: {}", request.getMessage());
        return aiChatApplicationService.streamChat(
                request.getMessage(),
                request.getHistory(),
                request.getSystemPrompt()
        );
    }
}
