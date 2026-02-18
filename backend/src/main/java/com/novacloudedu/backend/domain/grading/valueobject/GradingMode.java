package com.novacloudedu.backend.domain.grading.valueobject;

import lombok.Getter;

@Getter
public enum GradingMode {
    EXAM_PAPER("EXAM_PAPER", "试卷批改"),
    GENERAL("GENERAL", "通用作业助手");

    private final String code;
    private final String description;

    GradingMode(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static GradingMode fromCode(String code) {
        if (code == null || code.isBlank()) return GENERAL;
        for (GradingMode mode : values()) {
            if (mode.code.equals(code)) return mode;
        }
        return GENERAL;
    }
}
