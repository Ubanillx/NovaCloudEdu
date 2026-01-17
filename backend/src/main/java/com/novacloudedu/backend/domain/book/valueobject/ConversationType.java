package com.novacloudedu.backend.domain.book.valueobject;

/**
 * 对话类型枚举
 */
public enum ConversationType {
    SUMMARY("章节总结"),
    QA("智能问答"),
    KNOWLEDGE("知识点提取"),
    QUIZ("阅读测试");

    private final String description;

    ConversationType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
