package com.novacloudedu.backend.interfaces.rest.banner.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 查询轮播图请求
 */
@Schema(description = "查询轮播图请求")
public record QueryBannerRequest(
        @Schema(description = "标题关键词")
        String title,

        @Schema(description = "状态: 0-草稿, 1-已发布, 2-已下线")
        Integer status,

        @Schema(description = "创建者ID")
        Long adminId,

        @Schema(description = "页码")
        Integer pageNum,

        @Schema(description = "每页数量")
        Integer pageSize
) {
    public int getPageNum() {
        return pageNum != null && pageNum > 0 ? pageNum : 1;
    }

    public int getPageSize() {
        return pageSize != null && pageSize > 0 ? Math.min(pageSize, 100) : 10;
    }
}
