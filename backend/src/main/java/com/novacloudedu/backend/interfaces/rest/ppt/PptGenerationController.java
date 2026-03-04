package com.novacloudedu.backend.interfaces.rest.ppt;

import com.novacloudedu.backend.application.service.PptGenerationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.request.PptGenerationRequest;
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

/**
 * PPT生成助手控制器
 * 单一SSE端点，通过 action 路由多步骤生成流程
 */
@Slf4j
@RestController
@RequestMapping("/api/ppt/generation")
@RequiredArgsConstructor
@Tag(name = "PPT生成助手", description = "AI驱动的多步骤PPT生成流程（SSE）")
public class PptGenerationController {

    private final PptGenerationService pptGenerationService;

    // ==================== 会话管理 ====================

    @GetMapping("/sessions")
    @Operation(summary = "获取PPT会话列表")
    public BaseResponse<List<Map<String, Object>>> listSessions(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        return ResultUtils.success(pptGenerationService.listSessions(userId));
    }

    @GetMapping("/sessions/{sessionId}")
    @Operation(summary = "获取PPT会话详情")
    public BaseResponse<Map<String, Object>> getSessionDetail(
            @PathVariable @Parameter(description = "会话ID") Long sessionId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        return ResultUtils.success(pptGenerationService.getSessionDetail(sessionId, userId));
    }

    @DeleteMapping("/sessions/{sessionId}")
    @Operation(summary = "删除PPT会话")
    public BaseResponse<Void> deleteSession(
            @PathVariable @Parameter(description = "会话ID") Long sessionId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        pptGenerationService.deleteSession(sessionId, userId);
        return ResultUtils.success(null);
    }

    // ==================== SSE 流式生成 ====================

    @PostMapping(value = "/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "PPT生成助手（SSE流式）",
            description = """
                    多步骤PPT生成流程，通过 action 字段控制：
                    0. detect_intent - AI判断用户是否要生成PPT，提取主题
                    1. generate_outline - 输入主题，AI生成Markdown大纲
                    2. revise_outline - 不满意可修改大纲
                    3. confirm_outline - 确认大纲
                    4. select_template - 选择模板（系统模板ID 或 自定义URL）
                    5. generate_ppt - AI逐页生成内容并生成最终PPT文件
                    
                    SSE事件：status / message / intent / outline / template_parsed / slide_progress / result / error / done
                    """)
    public SseEmitter stream(
            @Valid @RequestBody PptGenerationRequest request,
            Authentication authentication) {

        Long userId = Long.parseLong(authentication.getName());
        log.info("PPT生成请求: action={}, sessionId={}, userId={}",
                request.getAction(), request.getSessionId(), userId);

        Map<String, Object> params = new HashMap<>();
        params.put("sessionId", request.getSessionId());
        params.put("message", request.getMessage());
        params.put("topic", request.getTopic());
        params.put("requirements", request.getRequirements());
        params.put("feedback", request.getFeedback());
        params.put("templateId", request.getTemplateId());
        params.put("templateUrl", request.getTemplateUrl());
        params.put("outlineJson", request.getOutlineJson());
        params.put("projectId", request.getProjectId());

        return pptGenerationService.handleAction(request.getAction(), params, userId);
    }
}
