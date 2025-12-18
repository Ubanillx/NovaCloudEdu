package com.novacloudedu.backend.domain.dailylearning.valueobject;

import lombok.Getter;

@Getter
public enum MasteryLevel {
    UNKNOWN(0, "未知"),
    NEW_WORD(1, "生词"),
    FAMILIAR(2, "熟悉"),
    MASTERED(3, "掌握");

    private final int code;
    private final String description;

    MasteryLevel(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static MasteryLevel fromCode(int code) {
        for (MasteryLevel level : values()) {
            if (level.code == code) {
                return level;
            }
        }
        throw new IllegalArgumentException("无效的掌握程度: " + code);
    }
}
