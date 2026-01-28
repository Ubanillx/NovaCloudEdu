package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

/**
 * 执行工作流请求
 */
@Data
@Schema(description = "执行工作流请求")
public class ExecuteWorkflowRequest {

    @NotNull(message = "用户ID不能为空")
    @Schema(description = "执行用户ID", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Long userId;

    @Schema(description = "工作流输入参数", example = "{\"query\": \"什么是机器学习?\", \"knowledgeBaseId\": 1}")
    private Map<String, Object> input;
}
