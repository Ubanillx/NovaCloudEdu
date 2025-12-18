package com.novacloudedu.backend.domain.dailylearning.valueobject;

import lombok.Getter;

@Getter
public enum Difficulty {
    EASY(1, "简单"),
    MEDIUM(2, "中等"),
    HARD(3, "困难");

    private final int code;
    private final String description;

    Difficulty(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static Difficulty fromCode(int code) {
        for (Difficulty difficulty : values()) {
            if (difficulty.code == code) {
                return difficulty;
            }
        }
        throw new IllegalArgumentException("无效的难度等级: " + code);
    }
}
