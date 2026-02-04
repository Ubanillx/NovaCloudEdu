package com.novacloudedu.backend.application.banner.command;

import java.time.LocalDateTime;

/**
 * 创建轮播图命令
 */
public record CreateBannerCommand(
        String title,
        String imageUrl,
        Integer linkType,
        String linkUrl,
        Integer sort,
        LocalDateTime startTime,
        LocalDateTime endTime
) {
}
