package com.novacloudedu.backend.interfaces.rest.post.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 创建回复请求
 */
@Data
public class CreateReplyRequest {

    @NotBlank(message = "回复内容不能为空")
    private String content;
}
