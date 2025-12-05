package com.novacloudedu.backend.interfaces.rest.announcement.dto.response;

import java.time.LocalDateTime;

/**
 * 公告响应（管理员视图）
 */
public record AnnouncementResponse(
        Long id,
        String title,
        String content,
        Integer sort,
        Integer status,
        String statusDesc,
        LocalDateTime startTime,
        LocalDateTime endTime,
        String coverImage,
        Long adminId,
        Integer viewCount,
        Long readCount,
        LocalDateTime createTime,
        LocalDateTime updateTime
) {
}
