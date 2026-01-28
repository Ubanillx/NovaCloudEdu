package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 更新工作流变量请求
 */
@Data
@Schema(description = "更新工作流变量请求")
public class UpdateVariableRequest {

    @Schema(description = "变量类型", example = "number", 
            allowableValues = {"string", "number", "boolean", "object", "array"})
    private String type;

    @Schema(description = "默认值", example = "0")
    private Object defaultValue;

    @Schema(description = "变量描述", example = "用户输入的查询问题（已更新）")
    private String description;
}
