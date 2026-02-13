package com.novacloudedu.backend.interfaces.rest.exam.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

/**
 * 试卷响应
 */
@Schema(description = "试卷响应")
public record ExamPaperResponse(
        @Schema(description = "试卷ID")
        Long id,

        @Schema(description = "标题")
        String title,

        @Schema(description = "副标题")
        String subtitle,

        @Schema(description = "学科")
        String subject,

        @Schema(description = "学科描述")
        String subjectDesc,

        @Schema(description = "年级")
        String grade,

        @Schema(description = "总分")
        Integer totalScore,

        @Schema(description = "考试时长(分钟)")
        Integer durationMin,

        @Schema(description = "排版配置JSON")
        String layout,

        @Schema(description = "状态")
        String status,

        @Schema(description = "状态描述")
        String statusDesc,

        @Schema(description = "模板ID")
        Long templateId,

        @Schema(description = "创建者ID")
        Long creatorId,

        @Schema(description = "创建时间")
        LocalDateTime createTime,

        @Schema(description = "更新时间")
        LocalDateTime updateTime
) {
}
