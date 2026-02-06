package com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
@Schema(description = "预览 AI 处理结果请求")
public class PreviewAiProcessRequest {

    @NotBlank(message = "文章内容不能为空")
    @Schema(description = "文章内容")
    private String content;

    @Schema(description = "文章标题（可选，用于上下文）")
    private String title;
}
