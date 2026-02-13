package com.novacloudedu.backend.domain.exam.valueobject;

import lombok.Getter;

@Getter
public enum Subject {
    MATH("MATH", "数学"),
    CHINESE("CHINESE", "语文"),
    ENGLISH("ENGLISH", "英语"),
    PHYSICS("PHYSICS", "物理"),
    CHEMISTRY("CHEMISTRY", "化学"),
    BIOLOGY("BIOLOGY", "生物"),
    HISTORY("HISTORY", "历史"),
    GEOGRAPHY("GEOGRAPHY", "地理"),
    POLITICS("POLITICS", "政治");

    private final String code;
    private final String description;

    Subject(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static Subject fromCode(String code) {
        for (Subject subject : values()) {
            if (subject.code.equals(code)) {
                return subject;
            }
        }
        throw new IllegalArgumentException("未知的学科: " + code);
    }
}
