package com.novacloudedu.backend.interfaces.rest.post.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 创建评论请求
 */
@Data
public class CreateCommentRequest {

    @NotBlank(message = "评论内容不能为空")
    private String content;
}
