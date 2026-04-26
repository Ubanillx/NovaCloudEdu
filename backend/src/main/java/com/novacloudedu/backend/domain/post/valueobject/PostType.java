package com.novacloudedu.backend.domain.post.valueobject;

/**
 * 帖子类型枚举
 */
public enum PostType {
    DISCUSSION("discussion", "讨论交流"),
    QUESTION("question", "提问求助"),
    SHARE("share", "资料分享"),
    EXPERIENCE("experience", "学习心得"),
    HOMEWORK("homework", "作业答疑"),
    EXAM("exam", "考试升学"),
    COURSE("course", "课程讨论"),
    ANNOUNCEMENT("announcement", "活动公告"),
    LIFE("life", "闲聊生活"),
    TOOL("tool", "工具技巧"),
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
        if (code == null || code.isBlank()) {
            return OTHER;
        }
        String normalizedCode = code.trim().toLowerCase();
        for (PostType type : values()) {
            if (type.code.equals(normalizedCode)) {
                return type;
            }
        }
        return OTHER;
    }
}
