package com.novacloudedu.backend.domain.post.valueobject;

/**
 * 帖子类型枚举
 */
public enum PostType {
    STUDY("study", "学习"),
    LIFE("life", "生活"),
    SKILL("skill", "技巧"),
    OTHER("other", "其他");

    private final String code;
    private final String description;

    PostType(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    public static PostType fromCode(String code) {
        if (code == null) {
            return OTHER;
        }
        for (PostType type : values()) {
            if (type.code.equals(code)) {
                return type;
            }
        }
        return OTHER;
    }
}
