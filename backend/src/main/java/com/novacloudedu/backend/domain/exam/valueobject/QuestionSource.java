package com.novacloudedu.backend.domain.exam.valueobject;

import lombok.Getter;

@Getter
public enum QuestionSource {
    MANUAL("MANUAL", "手动创建"),
    AI("AI", "AI生成"),
    IMPORT("IMPORT", "导入");

    private final String code;
    private final String description;

    QuestionSource(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static QuestionSource fromCode(String code) {
        for (QuestionSource source : values()) {
            if (source.code.equals(code)) {
                return source;
            }
        }
        throw new IllegalArgumentException("未知的来源: " + code);
    }
}
