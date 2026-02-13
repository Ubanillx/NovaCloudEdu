package com.novacloudedu.backend.interfaces.rest.exam.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

/**
 * 试卷大题响应
 */
@Schema(description = "试卷大题响应")
public record PaperSectionResponse(
        @Schema(description = "大题ID")
        Long id,

        @Schema(description = "试卷ID")
        Long paperId,

        @Schema(description = "标题")
        String title,

        @Schema(description = "描述")
        String description,

        @Schema(description = "题型")
        String questionType,

        @Schema(description = "题型描述")
        String questionTypeDesc,

        @Schema(description = "排序")
        Integer sortOrder,

        @Schema(description = "创建时间")
        LocalDateTime createTime,

        @Schema(description = "更新时间")
        LocalDateTime updateTime
) {
}
