package com.novacloudedu.backend.interfaces.rest.announcement.dto.response;

import java.util.List;

/**
 * 公告分页响应（用户）
 */
public record UserAnnouncementPageResponse(
        List<AnnouncementListResponse> records,
        long total,
        int pageNum,
        int pageSize,
        int totalPages,
        long unreadCount
) {
}
