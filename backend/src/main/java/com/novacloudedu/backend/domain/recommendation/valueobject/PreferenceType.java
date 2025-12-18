package com.novacloudedu.backend.domain.recommendation.valueobject;

import lombok.Getter;

@Getter
public enum PreferenceType {
    WORD_CATEGORY("WORD_CATEGORY", "单词分类偏好"),
    WORD_DIFFICULTY("WORD_DIFFICULTY", "单词难度偏好"),
    ARTICLE_CATEGORY("ARTICLE_CATEGORY", "文章分类偏好"),
    ARTICLE_DIFFICULTY("ARTICLE_DIFFICULTY", "文章难度偏好"),
    ARTICLE_TAG("ARTICLE_TAG", "文章标签偏好");

    private final String code;
    private final String description;

    PreferenceType(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static PreferenceType fromCode(String code) {
        for (PreferenceType type : values()) {
            if (type.code.equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("无效的喜好类型: " + code);
    }
}
