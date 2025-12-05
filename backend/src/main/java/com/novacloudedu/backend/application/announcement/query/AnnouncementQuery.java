package com.novacloudedu.backend.application.announcement.query;

/**
 * 公告查询参数
 */
public record AnnouncementQuery(
        String title,
        Integer status,
        Long adminId,
        int pageNum,
        int pageSize
) {
}
