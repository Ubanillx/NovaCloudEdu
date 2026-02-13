package com.novacloudedu.backend.application.exam.command;

/**
 * 更新试卷命令
 */
public record UpdateExamPaperCommand(
        Long id,
        String title,
        String subtitle,
        String subject,
        String grade,
        Integer durationMin,
        String layout,
        Long templateId
) {
}
