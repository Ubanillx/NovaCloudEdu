package com.novacloudedu.backend.interfaces.rest.dailylearning.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
@Schema(description = "添加评论请求")
public class AddCommentRequest {

    @NotBlank(message = "评论内容不能为空")
    @Schema(description = "评论内容")
    private String content;
}
