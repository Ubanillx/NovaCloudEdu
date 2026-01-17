package com.novacloudedu.backend.domain.book.valueobject;

/**
 * 题目类型枚举
 */
public enum QuestionType {
    CHOICE("选择题"),
    FILL("填空题"),
    TRUE_FALSE("判断题"),
    SHORT_ANSWER("简答题");

    private final String description;

    QuestionType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
