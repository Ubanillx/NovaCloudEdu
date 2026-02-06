package com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Schema(description = "文章对话请求")
public class ArticleChatRequest {

    @NotNull(message = "文章ID不能为空")
    @Schema(description = "文章ID")
    private Long articleId;

    @NotBlank(message = "消息内容不能为空")
    @Schema(description = "用户消息")
    private String message;

    @Schema(description = "对话历史")
    private List<Map<String, String>> history;
}
