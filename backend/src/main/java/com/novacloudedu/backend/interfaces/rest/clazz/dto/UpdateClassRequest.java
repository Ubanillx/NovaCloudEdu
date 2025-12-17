package com.novacloudedu.backend.interfaces.rest.clazz.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "更新班级请求")
public class UpdateClassRequest {

    @Schema(description = "班级名称")
    private String className;

    @Schema(description = "班级描述")
    private String description;
}
