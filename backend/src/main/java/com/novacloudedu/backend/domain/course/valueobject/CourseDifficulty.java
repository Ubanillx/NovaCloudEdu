package com.novacloudedu.backend.domain.course.valueobject;

import lombok.Getter;

@Getter
public enum CourseDifficulty {
    BEGINNER(1, "入门"),
    ELEMENTARY(2, "初级"),
    INTERMEDIATE(3, "中级"),
    ADVANCED(4, "高级"),
    EXPERT(5, "专家");

    private final int code;
    private final String description;

    CourseDifficulty(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static CourseDifficulty fromCode(int code) {
        for (CourseDifficulty difficulty : values()) {
            if (difficulty.code == code) {
                return difficulty;
            }
        }
        throw new IllegalArgumentException("未知的难度等级码: " + code);
    }
}
