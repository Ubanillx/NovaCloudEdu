package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import com.novacloudedu.backend.domain.ai.valueobject.WorkflowDefinition;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 更新工作流定义请求
 */
@Data
@Schema(description = "更新工作流定义请求")
public class UpdateWorkflowDefinitionRequest {

    @NotNull(message = "工作流定义不能为空")
    @Schema(description = "工作流定义", requiredMode = Schema.RequiredMode.REQUIRED)
    private WorkflowDefinition definition;
}
