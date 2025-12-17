package com.novacloudedu.backend.interfaces.rest.teacher.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "更新讲师信息请求")
public class UpdateTeacherRequest {

    @NotBlank(message = "讲师姓名不能为空")
    @Schema(description = "讲师姓名")
    private String name;

    @Schema(description = "讲师简介")
    private String introduction;

    @NotEmpty(message = "专业领域不能为空")
    @Schema(description = "专业领域")
    private List<String> expertise;
}
