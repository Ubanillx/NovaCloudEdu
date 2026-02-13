package com.novacloudedu.backend.application.exam.command;

/**
 * 创建试卷命令
 */
public record CreateExamPaperCommand(
        String title,
        String subtitle,
        String subject,
        String grade,
        Integer durationMin,
        String layout,
        Long templateId
) {
}
