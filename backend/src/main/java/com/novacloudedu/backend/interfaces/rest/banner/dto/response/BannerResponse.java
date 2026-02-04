package com.novacloudedu.backend.interfaces.rest.banner.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

/**
 * 轮播图响应（管理员）
 */
@Schema(description = "轮播图响应")
public record BannerResponse(
        @Schema(description = "轮播图ID")
        Long id,

        @Schema(description = "标题")
        String title,

        @Schema(description = "图片URL")
        String imageUrl,

        @Schema(description = "跳转类型: 0-无跳转, 1-内部路由, 2-外部链接")
        Integer linkType,

        @Schema(description = "跳转类型描述")
        String linkTypeDesc,

        @Schema(description = "跳转URL/路由")
        String linkUrl,

        @Schema(description = "排序权重")
        Integer sort,

        @Schema(description = "状态: 0-草稿, 1-已发布, 2-已下线")
        Integer status,

        @Schema(description = "状态描述")
        String statusDesc,

        @Schema(description = "开始展示时间")
        LocalDateTime startTime,

        @Schema(description = "结束展示时间")
        LocalDateTime endTime,

        @Schema(description = "创建者ID")
        Long adminId,

        @Schema(description = "创建时间")
        LocalDateTime createTime,

        @Schema(description = "更新时间")
        LocalDateTime updateTime
) {
}
