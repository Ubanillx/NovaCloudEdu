package com.novacloudedu.backend.interfaces.rest.exam.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 查询试卷请求
 */
@Schema(description = "查询试卷请求")
public record QueryExamPaperRequest(
        @Schema(description = "关键词")
        String keyword,

        @Schema(description = "学科")
        String subject,

        @Schema(description = "年级")
        String grade,

        @Schema(description = "状态: DRAFT/PUBLISHED")
        String status,

        @Schema(description = "页码", defaultValue = "1")
        Integer pageNum,

        @Schema(description = "每页数量", defaultValue = "20")
        Integer pageSize
) {
    public int getPageNum() {
        return pageNum != null && pageNum > 0 ? pageNum : 1;
    }

    public int getPageSize() {
        return pageSize != null && pageSize > 0 ? pageSize : 20;
    }
}
