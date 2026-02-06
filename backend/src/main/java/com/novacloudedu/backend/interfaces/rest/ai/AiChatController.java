package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.AiChatApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.ai.entity.AiChatMessage;
import com.novacloudedu.backend.domain.ai.entity.AiChatSession;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.interfaces.rest.ai.dto.ChatRequest;
import com.novacloudedu.backend.interfaces.rest.ai.dto.SessionChatRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
@Tag(name = "AI聊天", description = "AI聊天相关接口")
public class AiChatController {

    private final AiChatApplicationService aiChatApplicationService;
    private final LangchainChatService langchainChatService;

    // ==================== 会话管理 ====================

    @PostMapping("/chat/sessions")
    @Operation(summary = "创建新会话")
    public BaseResponse<Map<String, Object>> createSession(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        AiChatSession session = aiChatApplicationService.createSession(userId);

        Map<String, Object> result = new HashMap<>();
        result.put("sessionId", session.getId().value());
        result.put("createTime", session.getCreateTime());
        return ResultUtils.success(result);
    }

    @GetMapping("/chat/sessions")
    @Operation(summary = "获取会话列表")
    public BaseResponse<List<Map<String, Object>>> listSessions(
            Authentication authentication,
            @RequestParam(defaultValue = "0") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "20") @Parameter(description = "每页大小") int size) {
        Long userId = Long.parseLong(authentication.getName());
        List<AiChatSession> sessions = aiChatApplicationService.listSessions(userId, page, size);

        List<Map<String, Object>> result = sessions.stream().map(s -> {
            Map<String, Object> map = new HashMap<>();
            map.put("sessionId", s.getId().value());
            map.put("title", s.getTitle());
            map.put("messageCount", s.getMessageCount());
            map.put("createTime", s.getCreateTime());
            map.put("updateTime", s.getUpdateTime());
            return map;
        }).collect(Collectors.toList());

        return ResultUtils.success(result);
    }

    @GetMapping("/chat/sessions/{sessionId}")
    @Operation(summary = "获取会话详情（含消息列表）")
    public BaseResponse<Map<String, Object>> getSessionDetail(
            @PathVariable @Parameter(description = "会话ID") Long sessionId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Map<String, Object> detail = aiChatApplicationService.getSessionDetail(sessionId, userId);

        AiChatSession session = (AiChatSession) detail.get("session");
        @SuppressWarnings("unchecked")
        List<AiChatMessage> messages = (List<AiChatMessage>) detail.get("messages");

        Map<String, Object> sessionMap = new HashMap<>();
        sessionMap.put("sessionId", session.getId().value());
        sessionMap.put("title", session.getTitle());
        sessionMap.put("messageCount", session.getMessageCount());
        sessionMap.put("createTime", session.getCreateTime());
        sessionMap.put("updateTime", session.getUpdateTime());

        List<Map<String, Object>> messageList = messages.stream().map(m -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", m.getId().value());
            map.put("role", m.getRole());
            map.put("content", m.getContent());
            map.put("attachments", m.getAttachments());
            map.put("createTime", m.getCreateTime());
            return map;
        }).collect(Collectors.toList());

        Map<String, Object> result = new HashMap<>();
        result.put("session", sessionMap);
        result.put("messages", messageList);
        return ResultUtils.success(result);
    }

    @DeleteMapping("/chat/sessions/{sessionId}")
    @Operation(summary = "删除会话")
    public BaseResponse<Void> deleteSession(
            @PathVariable @Parameter(description = "会话ID") Long sessionId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        aiChatApplicationService.deleteSession(sessionId, userId);
        return ResultUtils.success(null);
    }

    // ==================== 会话级流式对话（带记忆） ====================

    @PostMapping(value = "/chat/sessions/{sessionId}/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "会话级流式对话", description = "基于会话的SSE对话，服务端自动管理记忆（滑动窗口+摘要压缩）")
    public SseEmitter sessionStreamChat(
            @PathVariable @Parameter(description = "会话ID") Long sessionId,
            @Valid @RequestBody SessionChatRequest request,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        log.info("收到会话级对话请求: sessionId={}, msg={}, 图片数: {}",
                sessionId, request.getMessage(),
                request.getImageUrls() != null ? request.getImageUrls().size() : 0);
        return aiChatApplicationService.sessionStreamChat(
                sessionId, userId,
                request.getMessage(),
                request.getSystemPrompt(),
                request.getImageUrls(),
                request.getModelId()
        );
    }

    // ==================== 无状态流式对话（向后兼容） ====================

    @PostMapping(value = "/chat/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "无状态流式对话", description = "前端自行管理历史的SSE对话，支持图片URL")
    public SseEmitter streamChat(@Valid @RequestBody ChatRequest request) {
        log.info("收到无状态流式对话请求: {}, 图片数: {}", request.getMessage(),
                request.getImageUrls() != null ? request.getImageUrls().size() : 0);
        return aiChatApplicationService.streamChat(
                request.getMessage(),
                request.getHistory(),
                request.getSystemPrompt(),
                request.getImageUrls(),
                request.getModelId()
        );
    }

    // ==================== 模型管理 ====================

    @GetMapping("/chat/models")
    @Operation(summary = "获取可用模型列表", description = "仅返回已启用的模型，前端用于模型选择下拉框")
    public BaseResponse<List<Map<String, Object>>> listModels() {
        return ResultUtils.success(langchainChatService.listAvailableModels());
    }

    @GetMapping("/chat/models/all")
    @Operation(summary = "获取全量模型配置", description = "返回所有供应商的所有模型（含未启用的），标注 enabled/isDefault 状态")
    public BaseResponse<List<Map<String, Object>>> listAllModels() {
        return ResultUtils.success(langchainChatService.listAllModels());
    }
}
