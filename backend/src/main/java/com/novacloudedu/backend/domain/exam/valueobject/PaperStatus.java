package com.novacloudedu.backend.domain.exam.valueobject;

import lombok.Getter;

@Getter
public enum PaperStatus {
    DRAFT("DRAFT", "草稿"),
    PUBLISHED("PUBLISHED", "已发布");

    private final String code;
    private final String description;

    PaperStatus(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static PaperStatus fromCode(String code) {
        for (PaperStatus status : values()) {
            if (status.code.equals(code)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的试卷状态: " + code);
    }
}
