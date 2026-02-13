package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

/**
 * 创建试卷请求
 */
@Schema(description = "创建试卷请求")
public record CreateExamPaperRequest(
        @Schema(description = "试卷标题", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "试卷标题不能为空")
        String title,

        @Schema(description = "副标题")
        String subtitle,

        @Schema(description = "学科", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "学科不能为空")
        String subject,

        @Schema(description = "年级")
        String grade,

        @Schema(description = "考试时长(分钟)")
        Integer durationMin,

        @Schema(description = "排版配置JSON")
        String layout,

        @Schema(description = "模板ID")
        Long templateId
) {
}
