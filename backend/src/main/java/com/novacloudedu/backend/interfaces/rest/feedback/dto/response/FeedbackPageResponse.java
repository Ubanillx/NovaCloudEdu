package com.novacloudedu.backend.interfaces.rest.feedback.dto.response;

import java.util.List;

/**
 * 反馈分页响应
 */
public record FeedbackPageResponse(
        List<FeedbackResponse> list,
        long total,
        int pageNum,
        int pageSize,
        int totalPages
) {
}
