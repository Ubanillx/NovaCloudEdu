package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

/**
 * AI 生成题目请求
 */
@Schema(description = "AI 生成题目请求")
public record AiGenerateQuestionsRequest(

        @Schema(description = "学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "学科不能为空")
        String subject,

        @Schema(description = "题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "题型不能为空")
        String type,

        @Schema(description = "难度: 1-5", requiredMode = Schema.RequiredMode.REQUIRED)
        @Min(1) @Max(5)
        Integer difficulty,

        @Schema(description = "年级")
        String grade,

        @Schema(description = "生成数量", requiredMode = Schema.RequiredMode.REQUIRED)
        @Min(1) @Max(20)
        Integer count,

        @Schema(description = "知识点/主题描述")
        String topic,

        @Schema(description = "是否生成几何图形（Typst cetz 渲染）")
        Boolean withDiagram,

        @Schema(description = "是否生成配图（文生图）")
        Boolean withImage,

        @Schema(description = "是否启用联网搜索热点出题")
        Boolean enableWebSearch,

        @Schema(description = "AI 模型ID（可选，如 dashscope/qwen-max）")
        String modelId,

        @Schema(description = "用户自定义补充要求（如出题风格、特殊限制、场景描述等）")
        String userInput
) {
}
