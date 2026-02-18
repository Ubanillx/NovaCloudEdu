package com.novacloudedu.backend.application.course.command;

/**
 * 创建章节命令
 */
public record CreateChapterCommand(
        Long courseId,
        String title,
        String description,
        Integer sort
) {}
