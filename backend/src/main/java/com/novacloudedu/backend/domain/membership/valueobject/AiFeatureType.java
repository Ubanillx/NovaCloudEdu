package com.novacloudedu.backend.domain.membership.valueobject;

import java.util.Arrays;

public enum AiFeatureType {

    AI_CHAT("AI_CHAT", "AI对话"),
    AI_PPT("AI_PPT", "PPT生成"),
    AI_EXAM("AI_EXAM", "AI出题"),
    AI_BOOK("AI_BOOK", "电子书AI"),
    AI_GRADING("AI_GRADING", "智能批改");

    private final String value;
    private final String description;

    AiFeatureType(String value, String description) {
        this.value = value;
        this.description = description;
    }

    public String getValue() {
        return value;
    }

    public String getDescription() {
        return description;
    }

    public static AiFeatureType fromValue(String value) {
        return Arrays.stream(values())
                .filter(type -> type.value.equals(value))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("未知的AI功能类型: " + value));
    }
}
