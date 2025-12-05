package com.novacloudedu.backend.application.announcement.command;

import java.time.LocalDateTime;

/**
 * 创建公告命令
 */
public record CreateAnnouncementCommand(
        String title,
        String content,
        Integer sort,
        LocalDateTime startTime,
        LocalDateTime endTime,
        String coverImage
) {
}
