package com.novacloudedu.backend.interfaces.rest.exam.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 题目分页响应
 */
@Schema(description = "题目分页响应")
public record QuestionPageResponse(
        @Schema(description = "题目列表")
        List<QuestionResponse> records,

        @Schema(description = "总数")
        long total,

        @Schema(description = "当前页")
        int pageNum,

        @Schema(description = "每页数量")
        int pageSize,

        @Schema(description = "总页数")
        int totalPages
) {
}
