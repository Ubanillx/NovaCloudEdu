package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 群加入模式枚举
 */
public enum JoinMode {
    /**
     * 自由加入
     */
    FREE(0),

    /**
     * 需要审批
     */
    APPROVAL(1),

    /**
     * 禁止加入
     */
    FORBIDDEN(2);

    private final int code;

    JoinMode(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static JoinMode fromCode(int code) {
        for (JoinMode mode : values()) {
            if (mode.code == code) {
                return mode;
            }
        }
        throw new IllegalArgumentException("Unknown JoinMode code: " + code);
    }
}
