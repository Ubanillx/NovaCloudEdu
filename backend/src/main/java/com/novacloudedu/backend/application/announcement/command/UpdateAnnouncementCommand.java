package com.novacloudedu.backend.application.announcement.command;

import java.time.LocalDateTime;

/**
 * 更新公告命令
 */
public record UpdateAnnouncementCommand(
        Long id,
        String title,
        String content,
        Integer sort,
        Integer status,
        LocalDateTime startTime,
        LocalDateTime endTime,
        String coverImage
) {
}
