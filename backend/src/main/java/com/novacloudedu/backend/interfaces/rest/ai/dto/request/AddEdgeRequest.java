package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 添加工作流连接线请求
 */
@Data
@Schema(description = "添加工作流连接线请求")
public class AddEdgeRequest {

    @NotBlank(message = "连接线ID不能为空")
    @Schema(description = "连接线唯一标识", requiredMode = Schema.RequiredMode.REQUIRED, example = "edge-1")
    private String edgeId;

    @NotBlank(message = "源节点ID不能为空")
    @Schema(description = "源节点ID", requiredMode = Schema.RequiredMode.REQUIRED, example = "node-1")
    private String sourceNodeId;

    @NotBlank(message = "目标节点ID不能为空")
    @Schema(description = "目标节点ID", requiredMode = Schema.RequiredMode.REQUIRED, example = "node-2")
    private String targetNodeId;

    @Schema(description = "源节点输出句柄", example = "output-1")
    private String sourceHandle;

    @Schema(description = "目标节点输入句柄", example = "input-1")
    private String targetHandle;

    @Schema(description = "条件表达式（用于条件分支）", example = "${result.score > 0.8}")
    private String condition;

    @Schema(description = "连接线标签", example = "是")
    private String label;
}
