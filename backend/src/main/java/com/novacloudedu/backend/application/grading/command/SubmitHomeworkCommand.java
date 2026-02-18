package com.novacloudedu.backend.application.grading.command;

import java.util.List;

/**
 * 提交作业命令
 */
public record SubmitHomeworkCommand(
        String gradingMode,
        String title,
        String subject,
        String grade,
        List<String> imageUrls,
        Long classId,
        Long examPaperId
) {}
