package com.novacloudedu.backend.domain.recommendation.valueobject;

import lombok.Getter;

@Getter
public enum TargetType {
    WORD("WORD", "单词"),
    ARTICLE("ARTICLE", "文章");

    private final String code;
    private final String description;

    TargetType(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static TargetType fromCode(String code) {
        for (TargetType type : values()) {
            if (type.code.equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("无效的目标类型: " + code);
    }
}
