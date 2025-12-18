package com.novacloudedu.backend.application.feedback.query;

/**
 * 反馈查询条件
 */
public record FeedbackQuery(
        Long userId,
        String feedbackType,
        Integer status,
        int pageNum,
        int pageSize
) {
}
