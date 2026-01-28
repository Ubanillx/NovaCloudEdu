package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * 并行执行节点配置请求
 */
@Data
@Schema(description = "并行执行节点配置")
public class ParallelNodeConfigRequest {

    @Schema(description = "并行分支列表")
    private List<ParallelBranchDTO> branches;

    @Schema(description = "等待策略", example = "ALL", 
            allowableValues = {"ALL", "ANY", "N_OF_M"})
    private String waitStrategy;

    @Schema(description = "需要完成的分支数（N_OF_M策略）", example = "2")
    private Integer requiredCount;

    @Schema(description = "超时时间（毫秒）", example = "60000")
    private Long timeout;

    @Schema(description = "是否在任一分支失败时终止其他分支", example = "false")
    private Boolean failFast;

    @Schema(description = "合并结果的变量名", example = "parallelResults")
    private String resultVariable;

    @Schema(description = "结果合并策略", example = "OBJECT", 
            allowableValues = {"ARRAY", "OBJECT", "FIRST", "LAST"})
    private String mergeStrategy;

    @Data
    @Schema(description = "并行分支")
    public static class ParallelBranchDTO {
        @Schema(description = "分支名称", example = "branch-1")
        private String name;

        @Schema(description = "分支起始节点ID", example = "node-branch1-start")
        private String startNodeId;

        @Schema(description = "分支结果变量名", example = "branch1Result")
        private String resultVariable;

        @Schema(description = "分支优先级", example = "1")
        private Integer priority;

        @Schema(description = "是否可选（失败不影响整体）", example = "false")
        private Boolean optional;
    }
}
