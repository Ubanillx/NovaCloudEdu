package com.novacloudedu.backend.interfaces.rest.announcement.dto.request;

/**
 * 查询公告请求
 */
public record QueryAnnouncementRequest(
        String title,
        Integer status,
        Long adminId,
        Integer pageNum,
        Integer pageSize
) {
    public int getPageNum() {
        return pageNum != null && pageNum > 0 ? pageNum : 1;
    }
    
    public int getPageSize() {
        return pageSize != null && pageSize > 0 ? Math.min(pageSize, 100) : 10;
    }
}
