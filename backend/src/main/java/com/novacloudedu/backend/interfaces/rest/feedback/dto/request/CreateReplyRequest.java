package com.novacloudedu.backend.interfaces.rest.feedback.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 * 创建回复请求
 */
public record CreateReplyRequest(
        @NotNull(message = "反馈ID不能为空")
        Long feedbackId,

        @NotBlank(message = "回复内容不能为空")
        @Size(max = 1000, message = "回复内容长度不能超过1000")
        String content,

        @Size(max = 1024, message = "附件URL长度不能超过1024")
        String attachment
) {
}
