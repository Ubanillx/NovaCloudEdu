package com.novacloudedu.backend.application.exam.command;

/**
 * 更新试卷大题命令
 */
public record UpdatePaperSectionCommand(
        Long id,
        String title,
        String description,
        String questionType,
        Integer sortOrder
) {
}
