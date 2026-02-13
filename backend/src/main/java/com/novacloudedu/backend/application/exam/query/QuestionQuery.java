package com.novacloudedu.backend.application.exam.query;

/**
 * 题目查询参数
 */
public record QuestionQuery(
        String keyword,
        String type,
        String subject,
        String grade,
        Integer difficulty,
        int pageNum,
        int pageSize
) {
}
