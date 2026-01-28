package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 添加工作流变量请求
 */
@Data
@Schema(description = "添加工作流变量请求")
public class AddVariableRequest {

    @NotBlank(message = "变量名称不能为空")
    @Schema(description = "变量名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "userQuery")
    private String name;

    @NotBlank(message = "变量类型不能为空")
    @Schema(description = "变量类型", requiredMode = Schema.RequiredMode.REQUIRED, 
            example = "string", allowableValues = {"string", "number", "boolean", "object", "array"})
    private String type;

    @Schema(description = "默认值", example = "")
    private Object defaultValue;

    @Schema(description = "变量描述", example = "用户输入的查询问题")
    private String description;
}
