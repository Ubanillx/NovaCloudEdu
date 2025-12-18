package com.novacloudedu.backend.interfaces.rest.feedback.dto.response;

import java.time.LocalDateTime;

/**
 * 反馈响应
 */
public record FeedbackResponse(
        Long id,
        Long userId,
        String feedbackType,
        String title,
        String content,
        String attachment,
        Integer status,
        String statusDesc,
        Long adminId,
        LocalDateTime processTime,
        LocalDateTime createTime,
        LocalDateTime updateTime
) {
}
