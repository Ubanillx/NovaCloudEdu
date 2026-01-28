package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 更新工作流连接线请求
 */
@Data
@Schema(description = "更新工作流连接线请求")
public class UpdateEdgeRequest {

    @Schema(description = "源节点ID", example = "node-1")
    private String sourceNodeId;

    @Schema(description = "目标节点ID", example = "node-3")
    private String targetNodeId;

    @Schema(description = "源节点输出句柄", example = "output-2")
    private String sourceHandle;

    @Schema(description = "目标节点输入句柄", example = "input-1")
    private String targetHandle;

    @Schema(description = "条件表达式", example = "${result.score > 0.9}")
    private String condition;

    @Schema(description = "连接线标签", example = "否")
    private String label;
}
