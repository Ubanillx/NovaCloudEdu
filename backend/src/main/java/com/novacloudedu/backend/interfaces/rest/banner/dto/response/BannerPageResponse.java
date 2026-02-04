package com.novacloudedu.backend.interfaces.rest.banner.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

/**
 * 轮播图分页响应（管理员）
 */
@Schema(description = "轮播图分页响应")
public record BannerPageResponse(
        @Schema(description = "轮播图列表")
        List<BannerResponse> records,

        @Schema(description = "总数")
        long total,

        @Schema(description = "当前页码")
        int pageNum,

        @Schema(description = "每页数量")
        int pageSize,

        @Schema(description = "总页数")
        int totalPages
) {
}
