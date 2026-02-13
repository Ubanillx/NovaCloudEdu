package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.List;

/**
 * 创建题目请求
 */
@Schema(description = "创建题目请求")
public record CreateQuestionRequest(
        @Schema(description = "题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "题型不能为空")
        String type,

        @Schema(description = "学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "学科不能为空")
        String subject,

        @Schema(description = "年级")
        String grade,

        @Schema(description = "难度: 1-5", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "难度不能为空")
        Integer difficulty,

        @Schema(description = "题干内容(支持KaTeX公式)", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "题干内容不能为空")
        String content,

        @Schema(description = "选项JSON字符串")
        String options,

        @Schema(description = "标准答案", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "答案不能为空")
        String answer,

        @Schema(description = "解析")
        String explanation,

        @Schema(description = "知识点标签")
        List<String> knowledgeTags,

        @Schema(description = "题目图片URL")
        String imageUrl,

        @Schema(description = "来源: MANUAL/AI/IMPORT")
        String source
) {
}
