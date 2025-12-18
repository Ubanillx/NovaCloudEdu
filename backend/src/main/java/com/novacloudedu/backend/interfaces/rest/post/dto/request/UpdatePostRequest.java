package com.novacloudedu.backend.interfaces.rest.post.dto.request;

import jakarta.validation.constraints.Size;
import lombok.Data;

import java.util.List;

/**
 * 更新帖子请求
 */
@Data
public class UpdatePostRequest {

    @Size(max = 512, message = "标题长度不能超过512个字符")
    private String title;

    private String content;

    private List<String> tags;

    private String postType;
}
