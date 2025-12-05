package com.novacloudedu.backend.interfaces.rest.announcement.dto.response;

import java.time.LocalDateTime;

/**
 * 公告详情响应（用户视图）
 */
public record AnnouncementDetailResponse(
        Long id,
        String title,
        String content,
        String coverImage,
        Integer viewCount,
        Boolean isRead,
        LocalDateTime createTime
) {
}
