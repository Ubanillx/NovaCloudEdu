package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * 多路分支(Switch)节点配置请求
 */
@Data
@Schema(description = "多路分支节点配置")
public class SwitchNodeConfigRequest {

    @Schema(description = "判断变量名", example = "userIntent")
    private String switchVariable;

    @Schema(description = "分支case列表")
    private List<SwitchCaseDTO> cases;

    @Schema(description = "默认分支的目标节点ID")
    private String defaultTargetNodeId;

    @Data
    @Schema(description = "Switch分支")
    public static class SwitchCaseDTO {
        @Schema(description = "case名称", example = "查询意图")
        private String name;

        @Schema(description = "匹配值", example = "QUERY")
        private Object value;

        @Schema(description = "匹配值列表（多值匹配）")
        private List<Object> values;

        @Schema(description = "目标节点ID", example = "node-query-handler")
        private String targetNodeId;
    }
}
