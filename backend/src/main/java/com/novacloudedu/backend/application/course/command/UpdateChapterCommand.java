package com.novacloudedu.backend.application.course.command;

/**
 * 更新章节命令
 */
public record UpdateChapterCommand(
        Long chapterId,
        String title,
        String description,
        Integer sort
) {}
