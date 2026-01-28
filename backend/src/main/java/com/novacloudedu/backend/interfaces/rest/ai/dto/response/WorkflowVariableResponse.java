package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 工作流变量响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流变量响应")
public class WorkflowVariableResponse {

    @Schema(description = "变量名称", example = "userQuery")
    private String name;

    @Schema(description = "变量类型", example = "string")
    private String type;

    @Schema(description = "默认值", example = "")
    private Object defaultValue;

    @Schema(description = "变量描述", example = "用户输入的查询问题")
    private String description;
}
