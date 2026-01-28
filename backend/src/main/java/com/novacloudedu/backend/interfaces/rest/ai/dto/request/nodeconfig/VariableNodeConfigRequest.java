package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 变量操作节点配置请求（设置变量/获取变量）
 */
@Data
@Schema(description = "变量操作节点配置")
public class VariableNodeConfigRequest {

    @Schema(description = "操作类型", example = "SET", 
            allowableValues = {"SET", "GET", "DELETE", "INCREMENT", "APPEND"})
    private String operation;

    @Schema(description = "变量赋值列表（SET操作）")
    private List<VariableAssignmentDTO> assignments;

    @Schema(description = "要获取的变量名列表（GET操作）")
    private List<String> variableNames;

    @Schema(description = "要删除的变量名列表（DELETE操作）")
    private List<String> deleteVariables;

    @Data
    @Schema(description = "变量赋值")
    public static class VariableAssignmentDTO {
        @Schema(description = "变量名", example = "totalScore")
        private String variableName;

        @Schema(description = "值类型", example = "LITERAL", 
                allowableValues = {"LITERAL", "VARIABLE", "EXPRESSION", "JSON"})
        private String valueType;

        @Schema(description = "字面值")
        private Object literalValue;

        @Schema(description = "源变量名（VARIABLE类型）")
        private String sourceVariable;

        @Schema(description = "表达式（EXPRESSION类型）", example = "${score1} + ${score2}")
        private String expression;

        @Schema(description = "JSON值（JSON类型）")
        private Map<String, Object> jsonValue;

        @Schema(description = "变量作用域", example = "WORKFLOW", 
                allowableValues = {"WORKFLOW", "NODE", "GLOBAL"})
        private String scope;
    }
}
