package com.novacloudedu.backend.application.banner.command;

import java.time.LocalDateTime;

/**
 * 更新轮播图命令
 */
public record UpdateBannerCommand(
        Long id,
        String title,
        String imageUrl,
        Integer linkType,
        String linkUrl,
        Integer sort,
        LocalDateTime startTime,
        LocalDateTime endTime,
        Integer status
) {
}
