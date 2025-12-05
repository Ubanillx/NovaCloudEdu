package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 群邀请模式枚举
 */
public enum InviteMode {
    /**
     * 所有人可邀请
     */
    ALL(0),

    /**
     * 仅管理员可邀请
     */
    ADMIN_ONLY(1);

    private final int code;

    InviteMode(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static InviteMode fromCode(int code) {
        for (InviteMode mode : values()) {
            if (mode.code == code) {
                return mode;
            }
        }
        throw new IllegalArgumentException("Unknown InviteMode code: " + code);
    }
}
