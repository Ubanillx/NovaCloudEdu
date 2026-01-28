package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 更新工作流基本信息请求
 */
@Data
@Schema(description = "更新工作流基本信息请求")
public class UpdateWorkflowRequest {

    @Size(min = 1, max = 100, message = "工作流名称长度必须在1-100之间")
    @Schema(description = "工作流名称", example = "知识库问答工作流V2")
    private String name;

    @Size(max = 500, message = "描述长度不能超过500")
    @Schema(description = "工作流描述", example = "基于知识库的智能问答工作流，支持多轮对话")
    private String description;
}
