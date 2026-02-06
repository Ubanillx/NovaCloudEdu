package com.novacloudedu.backend.interfaces.rest.dailylearning.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "批量 AI 处理文章请求")
public class BatchAiProcessRequest {

    @NotEmpty(message = "文章ID列表不能为空")
    @Schema(description = "文章ID列表")
    private List<Long> articleIds;

    @Schema(description = "是否格式化内容为 Markdown", defaultValue = "true")
    private Boolean formatContent = true;

    @Schema(description = "是否生成摘要", defaultValue = "true")
    private Boolean generateSummary = true;
}
