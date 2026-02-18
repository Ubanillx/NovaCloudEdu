package com.novacloudedu.backend.application.course.command;

/**
 * 更新小节命令
 */
public record UpdateSectionCommand(
        Long sectionId,
        String title,
        String description,
        String videoUrl,
        Integer duration,
        Integer sort,
        Boolean isFree,
        String resourceUrl
) {}
