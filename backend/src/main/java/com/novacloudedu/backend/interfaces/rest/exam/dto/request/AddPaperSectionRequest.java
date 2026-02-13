package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

/**
 * 添加试卷大题请求
 */
@Schema(description = "添加试卷大题请求")
public record AddPaperSectionRequest(
        @Schema(description = "大题标题", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "大题标题不能为空")
        String title,

        @Schema(description = "大题描述")
        String description,

        @Schema(description = "题型")
        String questionType,

        @Schema(description = "排序")
        Integer sortOrder
) {
}
