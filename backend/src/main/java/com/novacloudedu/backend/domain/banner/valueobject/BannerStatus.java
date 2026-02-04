package com.novacloudedu.backend.domain.banner.valueobject;

import lombok.Getter;

/**
 * 轮播图状态枚举
 */
@Getter
public enum BannerStatus {
    DRAFT(0, "草稿"),
    PUBLISHED(1, "已发布"),
    OFFLINE(2, "已下线");

    private final int code;
    private final String description;

    BannerStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static BannerStatus fromCode(int code) {
        for (BannerStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("无效的轮播图状态码: " + code);
    }
}
