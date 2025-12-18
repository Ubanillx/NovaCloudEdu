package com.novacloudedu.backend.interfaces.rest.post.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.util.List;

/**
 * 创建帖子请求
 */
@Data
public class CreatePostRequest {

    @NotBlank(message = "标题不能为空")
    @Size(max = 512, message = "标题长度不能超过512个字符")
    private String title;

    @NotBlank(message = "内容不能为空")
    private String content;

    private List<String> tags;

    @NotBlank(message = "帖子类型不能为空")
    private String postType;
}
