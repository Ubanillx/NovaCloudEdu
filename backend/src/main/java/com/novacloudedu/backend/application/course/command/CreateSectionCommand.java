package com.novacloudedu.backend.application.course.command;

/**
 * 创建小节命令
 */
public record CreateSectionCommand(
        Long courseId,
        Long chapterId,
        String title,
        String description,
        String videoUrl,
        Integer duration,
        Integer sort,
        Boolean isFree,
        String resourceUrl
) {}
