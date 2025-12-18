package com.novacloudedu.backend.domain.feedback.valueobject;

import lombok.Getter;

/**
 * 反馈状态枚举
 */
@Getter
public enum FeedbackStatus {

    PENDING(0, "待处理"),
    PROCESSING(1, "处理中"),
    PROCESSED(2, "已处理");

    private final int code;
    private final String description;

    FeedbackStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static FeedbackStatus fromCode(int code) {
        for (FeedbackStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("无效的反馈状态码: " + code);
    }
}
