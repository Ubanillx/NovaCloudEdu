package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 每日单词分页响应
 */
@Schema(description = "每日单词分页响应")
public record DailyWordPageResponse(
        @Schema(description = "单词列表")
        List<DailyWordResponse> records,

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
