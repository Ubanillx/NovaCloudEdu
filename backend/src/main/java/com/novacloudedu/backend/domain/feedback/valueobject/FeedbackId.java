package com.novacloudedu.backend.domain.feedback.valueobject;

/**
 * 反馈ID值对象
 */
public record FeedbackId(Long value) {

    public static FeedbackId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("反馈ID不能为空或小于等于0");
        }
        return new FeedbackId(value);
    }
}
