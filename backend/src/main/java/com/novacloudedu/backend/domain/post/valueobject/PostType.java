package com.novacloudedu.backend.domain.post.valueobject;

/**
 * 帖子类型枚举
 */
public enum PostType {
    DISCUSSION("discussion", "讨论"),
    QUESTION("question", "提问"),
    SHARE("share", "分享"),
    ANNOUNCEMENT("announcement", "公告"),
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
