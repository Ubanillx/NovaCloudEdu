package com.novacloudedu.backend.interfaces.rest.feedback.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

/**
 * 更新反馈状态请求
 */
public record UpdateFeedbackStatusRequest(
        @NotNull(message = "反馈ID不能为空")
        Long feedbackId,

        @NotNull(message = "状态不能为空")
        @Min(value = 0, message = "状态值无效")
        @Max(value = 2, message = "状态值无效")
        Integer status
) {
}
