package com.novacloudedu.backend.interfaces.rest.banner.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * AI生成轮播图图片响应
 */
@Schema(description = "AI生成轮播图图片响应")
public record GenerateBannerImageResponse(
        @Schema(description = "生成的图片URL")
        String imageUrl,

        @Schema(description = "是否成功")
        boolean success,

        @Schema(description = "错误信息（失败时）")
        String errorMessage
) {
    public static GenerateBannerImageResponse success(String imageUrl) {
        return new GenerateBannerImageResponse(imageUrl, true, null);
    }

    public static GenerateBannerImageResponse failure(String errorMessage) {
        return new GenerateBannerImageResponse(null, false, errorMessage);
    }
}
