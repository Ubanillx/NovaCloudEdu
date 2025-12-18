package com.novacloudedu.backend.interfaces.rest.feedback.dto.response;

import java.time.LocalDateTime;

/**
 * 反馈回复响应
 */
public record FeedbackReplyResponse(
        Long id,
        Long feedbackId,
        Long senderId,
        Integer senderRole,
        String senderRoleDesc,
        String content,
        String attachment,
        boolean isRead,
        LocalDateTime createTime,
        LocalDateTime updateTime
) {
}
