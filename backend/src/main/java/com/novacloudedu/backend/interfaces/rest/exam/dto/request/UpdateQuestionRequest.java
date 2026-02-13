package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.List;

/**
 * 更新题目请求
 */
@Schema(description = "更新题目请求")
public record UpdateQuestionRequest(
        @Schema(description = "题目ID", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "题目ID不能为空")
        Long id,

        @Schema(description = "题型", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "题型不能为空")
        String type,

        @Schema(description = "学科", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "学科不能为空")
        String subject,

        @Schema(description = "年级")
        String grade,

        @Schema(description = "难度: 1-5", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "难度不能为空")
        Integer difficulty,

        @Schema(description = "题干内容", requiredMode = Schema.RequiredMode.REQUIRED)
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
        String imageUrl
) {
}
