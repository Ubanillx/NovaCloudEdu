package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * 条件分支节点配置请求
 */
@Data
@Schema(description = "条件分支节点配置")
public class ConditionNodeConfigRequest {

    @Schema(description = "条件列表，按顺序匹配")
    private List<ConditionBranchDTO> conditions;

    @Schema(description = "默认分支（所有条件都不满足时执行）的目标节点ID")
    private String defaultTargetNodeId;

    @Data
    @Schema(description = "条件分支")
    public static class ConditionBranchDTO {
        @Schema(description = "分支名称", example = "高分用户")
        private String name;

        @Schema(description = "条件表达式，支持变量引用", example = "${score} > 80")
        private String expression;

        @Schema(description = "条件类型", example = "EXPRESSION", 
                allowableValues = {"EXPRESSION", "VARIABLE_EQUALS", "VARIABLE_CONTAINS", "VARIABLE_EMPTY", "VARIABLE_NOT_EMPTY"})
        private String conditionType;

        @Schema(description = "比较变量名（用于简单条件）", example = "userType")
        private String variable;

        @Schema(description = "比较操作符", example = "EQUALS", 
                allowableValues = {"EQUALS", "NOT_EQUALS", "GREATER_THAN", "LESS_THAN", "CONTAINS", "STARTS_WITH", "ENDS_WITH"})
        private String operator;

        @Schema(description = "比较值", example = "VIP")
        private Object compareValue;

        @Schema(description = "满足条件时的目标节点ID", example = "node-high-score")
        private String targetNodeId;
    }
}
