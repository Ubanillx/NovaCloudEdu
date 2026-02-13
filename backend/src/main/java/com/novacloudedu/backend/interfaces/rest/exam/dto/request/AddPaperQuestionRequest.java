package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;

/**
 * 添加试卷题目请求
 */
@Schema(description = "添加试卷题目请求")
public record AddPaperQuestionRequest(
        @Schema(description = "题目ID", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "题目ID不能为空")
        Long questionId,

        @Schema(description = "分值", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "分值不能为空")
        Integer score,

        @Schema(description = "排序")
        Integer sortOrder
) {
}
