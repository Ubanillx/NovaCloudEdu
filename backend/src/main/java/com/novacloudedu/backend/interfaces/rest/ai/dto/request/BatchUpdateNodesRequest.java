package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

/**
 * 批量更新节点请求
 */
@Data
@Schema(description = "批量更新节点请求")
public class BatchUpdateNodesRequest {

    @NotEmpty(message = "节点列表不能为空")
    @Valid
    @Schema(description = "要添加或更新的节点列表")
    private List<AddNodeRequest> nodes;

    @Schema(description = "要删除的节点ID列表")
    private List<String> deleteNodeIds;

    @Schema(description = "要添加或更新的连接线列表")
    private List<AddEdgeRequest> edges;

    @Schema(description = "要删除的连接线ID列表")
    private List<String> deleteEdgeIds;
}
