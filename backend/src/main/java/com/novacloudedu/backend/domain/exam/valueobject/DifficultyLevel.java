package com.novacloudedu.backend.domain.exam.valueobject;

import lombok.Getter;

@Getter
public enum DifficultyLevel {
    VERY_EASY(1, "很简单"),
    EASY(2, "简单"),
    MEDIUM(3, "中等"),
    HARD(4, "困难"),
    VERY_HARD(5, "很困难");

    private final int level;
    private final String description;

    DifficultyLevel(int level, String description) {
        this.level = level;
        this.description = description;
    }

    public static DifficultyLevel fromLevel(int level) {
        for (DifficultyLevel d : values()) {
            if (d.level == level) {
                return d;
            }
        }
        throw new IllegalArgumentException("未知的难度等级: " + level);
    }
}
