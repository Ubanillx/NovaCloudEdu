package com.novacloudedu.backend.domain.feedback.valueobject;

import lombok.Getter;

/**
 * 发送者角色枚举
 */
@Getter
public enum SenderRole {

    USER(0, "用户"),
    ADMIN(1, "管理员");

    private final int code;
    private final String description;

    SenderRole(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static SenderRole fromCode(int code) {
        for (SenderRole role : values()) {
            if (role.code == code) {
                return role;
            }
        }
        throw new IllegalArgumentException("无效的发送者角色码: " + code);
    }
}
