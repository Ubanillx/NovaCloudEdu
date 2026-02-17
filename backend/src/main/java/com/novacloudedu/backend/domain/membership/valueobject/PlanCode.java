package com.novacloudedu.backend.domain.membership.valueobject;

import java.util.Arrays;

public enum PlanCode {

    FREE("FREE", "免费版"),
    BASIC("BASIC", "基础版"),
    PRO("PRO", "专业版"),
    TEACHER("TEACHER", "教师版");

    private final String value;
    private final String description;

    PlanCode(String value, String description) {
        this.value = value;
        this.description = description;
    }

    public String getValue() {
        return value;
    }

    public String getDescription() {
        return description;
    }

    public static PlanCode fromValue(String value) {
        return Arrays.stream(values())
                .filter(code -> code.value.equals(value))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("未知的计划编码: " + value));
    }
}
