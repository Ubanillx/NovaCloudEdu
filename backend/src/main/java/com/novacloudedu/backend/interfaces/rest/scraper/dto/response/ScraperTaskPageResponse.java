package com.novacloudedu.backend.interfaces.rest.scraper.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 抓取任务分页响应
 */
@Schema(description = "抓取任务分页响应")
public record ScraperTaskPageResponse(
        @Schema(description = "任务列表")
        List<ScraperTaskResponse> records,

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
