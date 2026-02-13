package com.novacloudedu.backend.application.exam.command;

/**
 * 添加试卷题目命令
 */
public record AddPaperQuestionCommand(
        Long sectionId,
        Long questionId,
        Integer score,
        Integer sortOrder
) {
}
