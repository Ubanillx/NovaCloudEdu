package com.novacloudedu.backend.interfaces.rest.clazz.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "添加班级课程请求")
public class AddClassCourseRequest {

    @Schema(description = "课程ID", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotNull(message = "课程ID不能为空")
    private Long courseId;
}
