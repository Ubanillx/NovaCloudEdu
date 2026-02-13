package com.novacloudedu.backend.application.exam.query;

/**
 * 试卷查询参数
 */
public record ExamPaperQuery(
        String keyword,
        String subject,
        String grade,
        String status,
        int pageNum,
        int pageSize
) {
}
