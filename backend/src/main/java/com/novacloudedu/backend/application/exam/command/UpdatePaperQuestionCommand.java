package com.novacloudedu.backend.application.exam.command;

/**
 * 更新试卷题目命令
 */
public record UpdatePaperQuestionCommand(
        Long id,
        Integer score,
        Integer sortOrder
) {
}
