package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 每日文章分页响应
 */
@Schema(description = "每日文章分页响应")
public record DailyArticlePageResponse(
        @Schema(description = "文章列表")
        List<DailyArticleResponse> records,

        @Schema(description = "总记录数")
        long total,

        @Schema(description = "当前页码")
        int pageNum,

        @Schema(description = "每页大小")
        int pageSize,

        @Schema(description = "总页数")
        int totalPages
) {
}
