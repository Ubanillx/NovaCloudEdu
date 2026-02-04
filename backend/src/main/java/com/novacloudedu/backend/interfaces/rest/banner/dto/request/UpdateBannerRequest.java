package com.novacloudedu.backend.interfaces.rest.banner.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

/**
 * 更新轮播图请求
 */
@Schema(description = "更新轮播图请求")
public record UpdateBannerRequest(
        @Schema(description = "轮播图ID", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "轮播图ID不能为空")
        Long id,

        @Schema(description = "标题", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "标题不能为空")
        @Size(max = 128, message = "标题不能超过128个字符")
        String title,

        @Schema(description = "图片URL", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "图片URL不能为空")
        String imageUrl,

        @Schema(description = "跳转类型: 0-无跳转, 1-内部路由, 2-外部链接")
        Integer linkType,

        @Schema(description = "跳转URL/路由")
        String linkUrl,

        @Schema(description = "排序权重，值越大越靠前")
        Integer sort,

        @Schema(description = "开始展示时间")
        LocalDateTime startTime,

        @Schema(description = "结束展示时间")
        LocalDateTime endTime,

        @Schema(description = "状态: 0-草稿, 1-已发布, 2-已下线")
        Integer status
) {
}
