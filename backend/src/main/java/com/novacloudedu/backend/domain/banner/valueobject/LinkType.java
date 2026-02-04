package com.novacloudedu.backend.domain.banner.valueobject;

import lombok.Getter;

/**
 * 跳转类型枚举
 */
@Getter
public enum LinkType {
    NONE(0, "无跳转"),
    INTERNAL(1, "内部路由"),
    EXTERNAL(2, "外部链接");

    private final int code;
    private final String description;

    LinkType(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static LinkType fromCode(int code) {
        for (LinkType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("无效的跳转类型码: " + code);
    }
}
