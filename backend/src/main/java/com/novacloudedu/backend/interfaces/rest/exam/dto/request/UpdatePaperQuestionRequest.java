package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 更新试卷题目请求
 */
@Schema(description = "更新试卷题目请求")
public record UpdatePaperQuestionRequest(
        @Schema(description = "分值")
        Integer score,

        @Schema(description = "排序")
        Integer sortOrder
) {
}
