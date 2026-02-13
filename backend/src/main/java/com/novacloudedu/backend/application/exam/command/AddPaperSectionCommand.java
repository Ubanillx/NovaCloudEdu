package com.novacloudedu.backend.application.exam.command;

/**
 * 添加试卷大题命令
 */
public record AddPaperSectionCommand(
        Long paperId,
        String title,
        String description,
        String questionType,
        Integer sortOrder
) {
}
