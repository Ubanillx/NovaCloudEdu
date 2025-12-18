package com.novacloudedu.backend.domain.feedback.valueobject;

/**
 * 反馈回复ID值对象
 */
public record FeedbackReplyId(Long value) {

    public static FeedbackReplyId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("反馈回复ID不能为空或小于等于0");
        }
        return new FeedbackReplyId(value);
    }
}
