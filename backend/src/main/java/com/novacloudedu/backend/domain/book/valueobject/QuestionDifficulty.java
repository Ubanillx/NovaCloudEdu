package com.novacloudedu.backend.domain.book.valueobject;

/**
 * 题目难度枚举
 */
public enum QuestionDifficulty {
    EASY("简单"),
    MEDIUM("中等"),
    HARD("困难");

    private final String description;

    QuestionDifficulty(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
