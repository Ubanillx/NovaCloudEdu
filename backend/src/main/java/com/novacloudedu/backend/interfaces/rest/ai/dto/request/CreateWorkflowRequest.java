package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 创建工作流请求
 */
@Data
@Schema(description = "创建工作流请求")
public class CreateWorkflowRequest {

    @NotNull(message = "用户ID不能为空")
    @Schema(description = "用户ID", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Long userId;

    @NotBlank(message = "工作流名称不能为空")
    @Size(min = 1, max = 100, message = "工作流名称长度必须在1-100之间")
    @Schema(description = "工作流名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "知识库问答工作流")
    private String name;

    @Size(max = 500, message = "描述长度不能超过500")
    @Schema(description = "工作流描述", example = "基于知识库的智能问答工作流")
    private String description;
}
