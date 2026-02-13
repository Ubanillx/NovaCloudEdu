package com.novacloudedu.backend.interfaces.rest.exam.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 试卷分页响应
 */
@Schema(description = "试卷分页响应")
public record ExamPaperPageResponse(
        @Schema(description = "试卷列表")
        List<ExamPaperResponse> records,

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
