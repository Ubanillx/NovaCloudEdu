package com.novacloudedu.backend.interfaces.rest.exam.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

/**
 * 试卷题目关联响应
 */
@Schema(description = "试卷题目关联响应")
public record PaperQuestionResponse(
        @Schema(description = "关联ID")
        Long id,

        @Schema(description = "大题ID")
        Long sectionId,

        @Schema(description = "题目ID")
        Long questionId,

        @Schema(description = "分值")
        Integer score,

        @Schema(description = "排序")
        Integer sortOrder,

        @Schema(description = "创建时间")
        LocalDateTime createTime,

        @Schema(description = "更新时间")
        LocalDateTime updateTime
) {
}
