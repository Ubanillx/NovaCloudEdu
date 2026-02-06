package com.novacloudedu.backend.interfaces.rest.dailylearning.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "AI 处理结果响应")
public class AiProcessResultResponse {

    @Schema(description = "格式化后的内容（Markdown）")
    private String formattedContent;

    @Schema(description = "AI 生成的摘要")
    private String summary;
}
