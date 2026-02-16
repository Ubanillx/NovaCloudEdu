package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.AiAssistantApplicationService;
import com.novacloudedu.backend.application.service.AiAssistantWorkflowService;
import com.novacloudedu.backend.application.service.AiChatApplicationService;
import com.novacloudedu.backend.application.ai.command.CreateAiAssistantCommand;
import com.novacloudedu.backend.application.ai.command.UpdateAiAssistantCommand;
import com.novacloudedu.backend.application.ai.dto.AiAssistantVO;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.infrastructure.ai.ImageGenerationService;
import com.novacloudedu.backend.interfaces.rest.ai.dto.AssistantChatRequest;
import com.novacloudedu.backend.interfaces.rest.ai.dto.GenerateAvatarRequest;
import com.novacloudedu.backend.interfaces.rest.ai.dto.GenerateAvatarResponse;
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

import java.util.List;

/**
 * AI助手管理控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/ai/assistants")
@RequiredArgsConstructor
@Tag(name = "AI助手管理", description = "AI助手CRUD接口")
public class AiAssistantController {

    private final AiAssistantApplicationService assistantService;
    private final AiAssistantWorkflowService workflowService;
    private final AiChatApplicationService aiChatApplicationService;
    private final ImageGenerationService imageGenerationService;

    @PostMapping
    @Operation(summary = "创建AI助手", operationId = "assistantCreate")
    public BaseResponse<AiAssistantVO> create(
            @RequestParam Long userId,
            @Valid @RequestBody CreateAiAssistantCommand dto) {
        try {
            AiAssistantVO vo = assistantService.create(userId, dto);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("创建AI助手失败", e);
            return (BaseResponse<AiAssistantVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新AI助手", operationId = "assistantUpdate")
    public BaseResponse<AiAssistantVO> update(
            @PathVariable Long id,
            @Valid @RequestBody UpdateAiAssistantCommand dto) {
        try {
            AiAssistantVO vo = assistantService.update(id, dto);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("更新AI助手失败", e);
            return (BaseResponse<AiAssistantVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取AI助手详情", operationId = "assistantGetById")
    public BaseResponse<AiAssistantVO> getById(@PathVariable Long id) {
        try {
            AiAssistantVO vo = assistantService.getById(id);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("获取AI助手失败", e);
            return (BaseResponse<AiAssistantVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping
    @Operation(summary = "获取用户的AI助手列表", operationId = "assistantListByCreator")
    public BaseResponse<List<AiAssistantVO>> listByCreator(
            @RequestParam Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<AiAssistantVO> list = assistantService.listByCreator(userId, page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("获取AI助手列表失败", e);
            return (BaseResponse<List<AiAssistantVO>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/public")
    @Operation(summary = "获取公开的AI助手列表", operationId = "assistantListPublic")
    public BaseResponse<List<AiAssistantVO>> listPublic(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<AiAssistantVO> list = assistantService.listPublic(page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("获取公开AI助手列表失败", e);
            return (BaseResponse<List<AiAssistantVO>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/search")
    @Operation(summary = "搜索AI助手", operationId = "assistantSearch")
    public BaseResponse<List<AiAssistantVO>> search(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        try {
            List<AiAssistantVO> list = assistantService.search(keyword, page, size);
            return ResultUtils.success(list);
        } catch (Exception e) {
            log.error("搜索AI助手失败", e);
            return (BaseResponse<List<AiAssistantVO>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除AI助手", operationId = "assistantDelete")
    public BaseResponse<Void> delete(@PathVariable Long id) {
        try {
            assistantService.delete(id);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除AI助手失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}/publish")
    @Operation(summary = "发布AI助手", operationId = "assistantPublish")
    public BaseResponse<AiAssistantVO> publish(@PathVariable Long id) {
        try {
            AiAssistantVO vo = assistantService.publish(id);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("发布AI助手失败", e);
            return (BaseResponse<AiAssistantVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}/archive")
    @Operation(summary = "归档AI助手", operationId = "assistantArchive")
    public BaseResponse<AiAssistantVO> archive(@PathVariable Long id) {
        try {
            AiAssistantVO vo = assistantService.archive(id);
            return ResultUtils.success(vo);
        } catch (Exception e) {
            log.error("归档AI助手失败", e);
            return (BaseResponse<AiAssistantVO>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/knowledge-bases/{kbId}")
    @Operation(summary = "绑定知识库", operationId = "assistantBindKnowledgeBase")
    public BaseResponse<Void> bindKnowledgeBase(
            @PathVariable Long id,
            @PathVariable Long kbId) {
        try {
            assistantService.bindKnowledgeBase(id, kbId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("绑定知识库失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @DeleteMapping("/{id}/knowledge-bases/{kbId}")
    @Operation(summary = "解绑知识库", operationId = "assistantUnbindKnowledgeBase")
    public BaseResponse<Void> unbindKnowledgeBase(
            @PathVariable Long id,
            @PathVariable Long kbId) {
        try {
            assistantService.unbindKnowledgeBase(id, kbId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("解绑知识库失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}/workflows")
    @Operation(summary = "获取AI助手绑定的工作流列表", operationId = "assistantGetWorkflows")
    public BaseResponse<List<Long>> getWorkflows(@PathVariable Long id) {
        try {
            List<Long> workflowIds = workflowService.getWorkflowIds(id);
            return ResultUtils.success(workflowIds);
        } catch (Exception e) {
            log.error("获取工作流列表失败", e);
            return (BaseResponse<List<Long>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}/workflow-skills")
    @Operation(summary = "获取AI助手的工作流技能列表", operationId = "assistantGetWorkflowSkills",
            description = "返回绑定的工作流详情，包含描述、输入参数、输出参数，供前端展示或 AI 助手对话时使用")
    public BaseResponse<List<AiAssistantWorkflowService.WorkflowSkillVO>> getWorkflowSkills(@PathVariable Long id) {
        try {
            List<AiAssistantWorkflowService.WorkflowSkillVO> skills = workflowService.getWorkflowSkills(id);
            return ResultUtils.success(skills);
        } catch (Exception e) {
            log.error("获取工作流技能列表失败", e);
            return (BaseResponse<List<AiAssistantWorkflowService.WorkflowSkillVO>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/workflows/{workflowId}")
    @Operation(summary = "绑定工作流到AI助手", operationId = "assistantBindWorkflow")
    public BaseResponse<Void> bindWorkflow(
            @PathVariable Long id,
            @PathVariable Long workflowId) {
        try {
            workflowService.bindWorkflow(id, workflowId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("绑定工作流失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @DeleteMapping("/{id}/workflows/{workflowId}")
    @Operation(summary = "解绑工作流", operationId = "assistantUnbindWorkflow")
    public BaseResponse<Void> unbindWorkflow(
            @PathVariable Long id,
            @PathVariable Long workflowId) {
        try {
            workflowService.unbindWorkflow(id, workflowId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("解绑工作流失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/workflows/{workflowId}/execute")
    @Operation(summary = "执行AI助手绑定的工作流", operationId = "assistantExecuteWorkflow")
    public BaseResponse<java.util.Map<String, Object>> executeWorkflow(
            @PathVariable Long id,
            @PathVariable Long workflowId,
            @RequestParam Long userId,
            @RequestBody(required = false) java.util.Map<String, Object> input) {
        try {
            java.util.Map<String, Object> result = workflowService.executeWorkflow(id, workflowId, input, userId);
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("执行工作流失败", e);
            return (BaseResponse<java.util.Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    // ==================== AI生成头像 ====================

    @PostMapping("/generate-avatar")
    @Operation(summary = "AI生成助手头像", operationId = "assistantGenerateAvatar",
            description = "根据提示词使用AI生成助手头像图片，图片会自动上传到OSS持久化存储，返回OSS图片URL")
    public BaseResponse<GenerateAvatarResponse> generateAvatar(
            @Valid @RequestBody GenerateAvatarRequest request) {
        try {
            ImageGenerationService.ImageResult result = imageGenerationService.generateImageForAvatar(request.getPrompt());
            if (result.success()) {
                return ResultUtils.success(GenerateAvatarResponse.success(result.imageUrl()));
            } else {
                return ResultUtils.success(GenerateAvatarResponse.failure(result.errorMessage()));
            }
        } catch (Exception e) {
            log.error("AI生成头像失败", e);
            return ResultUtils.success(GenerateAvatarResponse.failure(e.getMessage()));
        }
    }

    // ==================== AI助手对话 ====================

    @PostMapping(value = "/{id}/chat/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "AI助手流式对话", operationId = "assistantChat",
            description = "通过助手ID与配置好的AI助手进行SSE流式对话。" +
                    "自动使用助手的systemPrompt和modelConfig，" +
                    "自动从绑定的知识库进行RAG检索，" +
                    "支持文档解析、多模态图片理解、文生图、图参生图、文生视频等全部外部技能。" +
                    "如不传sessionId则自动创建新会话，支持会话级记忆管理。")
    public SseEmitter assistantChat(
            @PathVariable @Parameter(description = "AI助手ID") Long id,
            @Valid @RequestBody AssistantChatRequest request,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        log.info("AI助手对话请求: assistantId={}, sessionId={}, msg={}, 图片数: {}, 文档数: {}",
                id, request.getSessionId(), request.getMessage(),
                request.getImageUrls() != null ? request.getImageUrls().size() : 0,
                request.getDocumentUrls() != null ? request.getDocumentUrls().size() : 0);

        java.util.Map<String, Object> result = aiChatApplicationService.assistantStreamChat(
                id, userId, request.getSessionId(),
                request.getMessage(),
                request.getImageUrls(),
                request.getDocumentUrls()
        );

        return (SseEmitter) result.get("emitter");
    }
}
