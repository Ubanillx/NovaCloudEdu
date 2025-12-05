package com.novacloudedu.backend.domain.announcement.valueobject;

/**
 * 公告状态值对象
 */
public enum AnnouncementStatus {
    DRAFT(0, "草稿"),
    PUBLISHED(1, "已发布"),
    OFFLINE(2, "已下线");

    private final int code;
    private final String description;

    AnnouncementStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    public static AnnouncementStatus fromCode(int code) {
        for (AnnouncementStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("无效的公告状态码: " + code);
    }
}
