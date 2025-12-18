package com.novacloudedu.backend.domain.dailylearning.valueobject;

import lombok.Getter;

@Getter
public enum LearningStatus {
    NOT_LEARNED(0, "未学习"),
    LEARNED(1, "已学习"),
    MASTERED(2, "已掌握");

    private final int code;
    private final String description;

    LearningStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static LearningStatus fromCode(int code) {
        for (LearningStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("无效的学习状态: " + code);
    }
}
