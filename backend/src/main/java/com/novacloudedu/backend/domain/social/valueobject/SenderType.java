package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 发送者类型枚举
 */
public enum SenderType {
    /**
     * 普通用户
     */
    USER(0),

    /**
     * AI角色
     */
    AI_ROLE(1);

    private final int code;

    SenderType(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static SenderType fromCode(int code) {
        for (SenderType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown SenderType code: " + code);
    }
}
