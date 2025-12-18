package com.novacloudedu.backend.interfaces.rest.feedback.dto.request;

/**
 * 查询反馈请求
 */
public record QueryFeedbackRequest(
        Long userId,
        String feedbackType,
        Integer status,
        Integer pageNum,
        Integer pageSize
) {
    public int getPageNum() {
        return pageNum != null ? pageNum : 1;
    }

    public int getPageSize() {
        return pageSize != null ? pageSize : 10;
    }
}
