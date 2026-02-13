package com.novacloudedu.backend.domain.exam.valueobject;

import lombok.Getter;

@Getter
public enum QuestionType {
    SINGLE_CHOICE("SINGLE_CHOICE", "单选题"),
    MULTI_CHOICE("MULTI_CHOICE", "多选题"),
    FILL_BLANK("FILL_BLANK", "填空题"),
    TRUE_FALSE("TRUE_FALSE", "判断题"),
    SHORT_ANSWER("SHORT_ANSWER", "简答题"),
    CALCULATION("CALCULATION", "计算题"),
    ESSAY("ESSAY", "论述题");

    private final String code;
    private final String description;

    QuestionType(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static QuestionType fromCode(String code) {
        for (QuestionType type : values()) {
            if (type.code.equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("未知的题型: " + code);
    }
}
