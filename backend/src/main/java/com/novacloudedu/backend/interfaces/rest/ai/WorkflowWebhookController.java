package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.entity.WorkflowTrigger;
import com.novacloudedu.backend.domain.ai.repository.WorkflowRepository;
import com.novacloudedu.backend.domain.ai.repository.WorkflowTriggerRepository;
import com.novacloudedu.backend.domain.ai.service.WorkflowEngine;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowExecutionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 * 工作流Webhook控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/webhook/workflow")
@RequiredArgsConstructor
@Tag(name = "工作流Webhook", description = "工作流Webhook触发接口")
public class WorkflowWebhookController {

    private final WorkflowTriggerRepository triggerRepository;
    private final WorkflowRepository workflowRepository;
    private final WorkflowEngine workflowEngine;

    @PostMapping("/{webhookId}")
    @Operation(summary = "Webhook触发工作流")
    public ResponseEntity<BaseResponse<WebhookResponse>> triggerWorkflow(
            @PathVariable String webhookId,
            @RequestHeader(value = "X-Webhook-Signature", required = false) String signature,
            @RequestBody(required = false) Map<String, Object> payload) {

        String webhookPath = "/api/v1/webhook/workflow/" + webhookId;

        // 查找触发器
        WorkflowTrigger trigger = triggerRepository.findByWebhookPath(webhookPath)
                .orElse(null);

        if (trigger == null) {
            log.warn("Webhook触发器不存在: path={}", webhookPath);
            return ResponseEntity.notFound().build();
        }

        if (!trigger.isEnabled()) {
            log.warn("Webhook触发器已禁用: triggerId={}", trigger.getId());
            return ResponseEntity.badRequest()
                    .body(new BaseResponse<>(400, null, "Webhook触发器已禁用"));
        }

        // 验证签名
        Boolean validateSignature = (Boolean) trigger.getConfig().getOrDefault("validateSignature", false);
        if (validateSignature && !verifySignature(trigger.getWebhookSecret(), payload, signature)) {
            log.warn("Webhook签名验证失败: triggerId={}", trigger.getId());
            return ResponseEntity.status(401)
                    .body(new BaseResponse<>(401, null, "签名验证失败"));
        }

        try {
            // 获取工作流
            Workflow workflow = workflowRepository.findById(trigger.getWorkflowId())
                    .orElseThrow(() -> new IllegalStateException("工作流不存在"));

            if (!workflow.canExecute()) {
                return ResponseEntity.badRequest()
                        .body(new BaseResponse<>(400, null, "工作流未发布"));
            }

            // 构建输入参数
            Map<String, Object> input = new HashMap<>();
            input.put("_triggerType", "WEBHOOK");
            input.put("_triggerId", trigger.getId());
            input.put("_triggerTime", LocalDateTime.now().toString());
            input.put("_webhookPath", webhookPath);
            if (payload != null) {
                input.put("webhookPayload", payload);
                input.putAll(payload);
            }

            // 异步执行工作流
            WorkflowExecutionId executionId = workflowEngine.executeAsync(
                    workflow, input, UserId.of(workflow.getCreatorId().value()));

            // 记录触发
            trigger.recordTrigger();
            triggerRepository.update(trigger);

            log.info("Webhook触发工作流成功: triggerId={}, executionId={}", 
                    trigger.getId(), executionId.value());

            WebhookResponse response = new WebhookResponse(
                    executionId.value(),
                    trigger.getWorkflowId().value(),
                    "ACCEPTED",
                    "工作流已触发执行"
            );

            return ResponseEntity.accepted().body(new BaseResponse<>(200, response, "success"));

        } catch (Exception e) {
            log.error("Webhook触发工作流失败: triggerId={}, error={}", trigger.getId(), e.getMessage(), e);
            return ResponseEntity.internalServerError()
                    .body(new BaseResponse<>(500, null, "触发失败: " + e.getMessage()));
        }
    }

    @GetMapping("/{webhookId}/info")
    @Operation(summary = "获取Webhook信息")
    public ResponseEntity<BaseResponse<WebhookInfo>> getWebhookInfo(@PathVariable String webhookId) {
        String webhookPath = "/api/v1/webhook/workflow/" + webhookId;

        return triggerRepository.findByWebhookPath(webhookPath)
                .map(trigger -> {
                    WebhookInfo info = new WebhookInfo(
                            trigger.getId(),
                            trigger.getName(),
                            trigger.getWorkflowId().value(),
                            webhookPath,
                            trigger.isEnabled(),
                            trigger.getTriggerCount(),
                            trigger.getLastTriggeredAt()
                    );
                    return ResponseEntity.ok(new BaseResponse<>(200, info, "success"));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * 验证Webhook签名
     */
    private boolean verifySignature(String secret, Map<String, Object> payload, String signature) {
        if (signature == null || signature.isBlank()) {
            return false;
        }

        try {
            String payloadJson = new com.fasterxml.jackson.databind.ObjectMapper()
                    .writeValueAsString(payload);

            Mac mac = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKeySpec = new SecretKeySpec(
                    secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            mac.init(secretKeySpec);

            byte[] hash = mac.doFinal(payloadJson.getBytes(StandardCharsets.UTF_8));
            String expectedSignature = "sha256=" + Base64.getEncoder().encodeToString(hash);

            return expectedSignature.equals(signature);

        } catch (Exception e) {
            log.error("签名验证异常: {}", e.getMessage());
            return false;
        }
    }

    public record WebhookResponse(
            String executionId,
            Long workflowId,
            String status,
            String message
    ) {}

    public record WebhookInfo(
            Long triggerId,
            String triggerName,
            Long workflowId,
            String webhookPath,
            boolean enabled,
            int triggerCount,
            LocalDateTime lastTriggeredAt
    ) {}
}
