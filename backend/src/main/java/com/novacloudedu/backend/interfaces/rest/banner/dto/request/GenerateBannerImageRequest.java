package com.novacloudedu.backend.interfaces.rest.banner.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * AI生成轮播图图片请求
 */
@Schema(description = "AI生成轮播图图片请求")
public record GenerateBannerImageRequest(
        @Schema(description = "轮播图标题", requiredMode = Schema.RequiredMode.REQUIRED, example = "暑期课程大促")
        @NotBlank(message = "标题不能为空")
        @Size(max = 128, message = "标题不能超过128个字符")
        String title,

        @Schema(description = "图片描述（英文效果更好）", requiredMode = Schema.RequiredMode.REQUIRED, example = "A vibrant summer education promotion banner with books and sunshine")
        @NotBlank(message = "图片描述不能为空")
        @Size(max = 500, message = "图片描述不能超过500个字符")
        String imageDescription
) {
}
