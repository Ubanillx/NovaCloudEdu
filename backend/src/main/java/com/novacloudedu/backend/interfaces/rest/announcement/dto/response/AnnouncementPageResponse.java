package com.novacloudedu.backend.interfaces.rest.announcement.dto.response;

import java.util.List;

/**
 * 公告分页响应（管理员）
 */
public record AnnouncementPageResponse(
        List<AnnouncementResponse> records,
        long total,
        int pageNum,
        int pageSize,
        int totalPages
) {
}
