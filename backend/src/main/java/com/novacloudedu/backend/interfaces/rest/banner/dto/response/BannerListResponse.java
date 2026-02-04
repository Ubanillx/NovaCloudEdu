package com.novacloudedu.backend.interfaces.rest.banner.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 轮播图列表响应（用户端）
 */
@Schema(description = "轮播图列表响应")
public record BannerListResponse(
        @Schema(description = "轮播图ID")
        Long id,

        @Schema(description = "标题")
        String title,

        @Schema(description = "图片URL")
        String imageUrl,

        @Schema(description = "跳转类型: 0-无跳转, 1-内部路由, 2-外部链接")
        Integer linkType,

        @Schema(description = "跳转URL/路由")
        String linkUrl
) {
}
