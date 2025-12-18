package com.novacloudedu.backend.interfaces.rest.feedback.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * 创建反馈请求
 */
public record CreateFeedbackRequest(
        @NotBlank(message = "反馈类型不能为空")
        @Size(max = 64, message = "反馈类型长度不能超过64")
        String feedbackType,

        @Size(max = 256, message = "标题长度不能超过256")
        String title,

        @NotBlank(message = "反馈内容不能为空")
        String content,

        @Size(max = 1024, message = "附件URL长度不能超过1024")
        String attachment
) {
}
