package com.novacloudedu.backend.interfaces.rest.feedback.dto.response;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 反馈详情响应（包含回复列表）
 */
public record FeedbackDetailResponse(
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
        LocalDateTime updateTime,
        List<FeedbackReplyResponse> replies
) {
}
