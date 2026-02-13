package com.novacloudedu.backend.interfaces.rest.exam.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 题目响应
 */
@Schema(description = "题目响应")
public record QuestionResponse(
        @Schema(description = "题目ID")
        Long id,

        @Schema(description = "题型")
        String type,

        @Schema(description = "题型描述")
        String typeDesc,

        @Schema(description = "学科")
        String subject,

        @Schema(description = "学科描述")
        String subjectDesc,

        @Schema(description = "年级")
        String grade,

        @Schema(description = "难度")
        Integer difficulty,

        @Schema(description = "难度描述")
        String difficultyDesc,

        @Schema(description = "题干内容")
        String content,

        @Schema(description = "选项JSON")
        String options,

        @Schema(description = "标准答案")
        String answer,

        @Schema(description = "解析")
        String explanation,

        @Schema(description = "知识点标签")
        List<String> knowledgeTags,

        @Schema(description = "题目图片URL")
        String imageUrl,

        @Schema(description = "来源")
        String source,

        @Schema(description = "创建者ID")
        Long creatorId,

        @Schema(description = "创建时间")
        LocalDateTime createTime,

        @Schema(description = "更新时间")
        LocalDateTime updateTime
) {
}
