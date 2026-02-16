package com.novacloudedu.backend.application.banner.command;

/**
 * AI生成轮播图图片命令
 */
public record GenerateBannerImageCommand(
        String title,
        String imageDescription
) {
}
