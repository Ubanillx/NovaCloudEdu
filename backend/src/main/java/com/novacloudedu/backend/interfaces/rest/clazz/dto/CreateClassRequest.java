package com.novacloudedu.backend.interfaces.rest.clazz.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
@Schema(description = "创建班级请求")
public class CreateClassRequest {

    @Schema(description = "班级名称", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotBlank(message = "班级名称不能为空")
    private String className;

    @Schema(description = "班级描述")
    private String description;
}
