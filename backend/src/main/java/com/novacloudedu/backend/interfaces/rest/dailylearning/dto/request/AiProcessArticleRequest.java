package com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "AI 处理文章请求")
public class AiProcessArticleRequest {

    @NotNull(message = "文章ID不能为空")
    @Schema(description = "文章ID")
    private Long articleId;

    @Schema(description = "是否格式化内容为 Markdown", defaultValue = "true")
    private Boolean formatContent = true;

    @Schema(description = "是否生成摘要", defaultValue = "true")
    private Boolean generateSummary = true;

    @Schema(description = "摘要最大长度", defaultValue = "150")
    private Integer summaryMaxLength = 150;
}
