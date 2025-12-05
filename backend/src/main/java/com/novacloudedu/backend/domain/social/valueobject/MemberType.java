package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 群成员类型枚举
 */
public enum MemberType {
    /**
     * 普通用户
     */
    USER(0),

    /**
     * AI角色
     */
    AI_ROLE(1);

    private final int code;

    MemberType(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static MemberType fromCode(int code) {
        for (MemberType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown MemberType code: " + code);
    }
}
