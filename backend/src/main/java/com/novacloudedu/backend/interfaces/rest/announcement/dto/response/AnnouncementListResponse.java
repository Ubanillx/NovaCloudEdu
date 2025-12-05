package com.novacloudedu.backend.interfaces.rest.announcement.dto.response;

import java.time.LocalDateTime;

/**
 * 公告列表项响应（用户视图）
 */
public record AnnouncementListResponse(
        Long id,
        String title,
        String coverImage,
        Integer viewCount,
        Boolean isRead,
        LocalDateTime createTime
) {
}
