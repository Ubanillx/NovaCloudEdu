package com.novacloudedu.backend.interfaces.rest.course.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "更新章节请求")
public class UpdateChapterRequest {

    @NotBlank(message = "章节标题不能为空")
    @Schema(description = "章节标题")
    private String title;

    @Schema(description = "章节描述")
    private String description;

    @NotNull(message = "排序不能为空")
    @Schema(description = "排序，数字越小排序越靠前")
    private Integer sort;
}
