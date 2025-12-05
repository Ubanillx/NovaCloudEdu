package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 群成员角色枚举
 */
public enum GroupRole {
    /**
     * 普通成员
     */
    MEMBER(0),

    /**
     * 管理员
     */
    ADMIN(1),

    /**
     * 群主
     */
    OWNER(2);

    private final int code;

    GroupRole(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static GroupRole fromCode(int code) {
        for (GroupRole role : values()) {
            if (role.code == code) {
                return role;
            }
        }
        throw new IllegalArgumentException("Unknown GroupRole code: " + code);
    }
}
