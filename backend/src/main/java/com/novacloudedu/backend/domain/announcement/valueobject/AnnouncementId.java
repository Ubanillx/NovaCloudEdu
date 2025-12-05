package com.novacloudedu.backend.domain.announcement.valueobject;

/**
 * 公告ID值对象
 */
public record AnnouncementId(Long value) {
    
    public static AnnouncementId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("公告ID不能为空或负数");
        }
        return new AnnouncementId(value);
    }
}
