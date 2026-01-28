package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 工作流连接线响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流连接线响应")
public class WorkflowEdgeResponse {

    @Schema(description = "连接线ID", example = "edge-1")
    private String id;

    @Schema(description = "源节点ID", example = "node-1")
    private String sourceNodeId;

    @Schema(description = "目标节点ID", example = "node-2")
    private String targetNodeId;

    @Schema(description = "源节点输出句柄", example = "output-1")
    private String sourceHandle;

    @Schema(description = "目标节点输入句柄", example = "input-1")
    private String targetHandle;

    @Schema(description = "条件表达式", example = "${result.score > 0.8}")
    private String condition;

    @Schema(description = "连接线标签", example = "是")
    private String label;
}
