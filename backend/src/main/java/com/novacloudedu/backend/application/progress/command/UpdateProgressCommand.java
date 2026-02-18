package com.novacloudedu.backend.application.progress.command;

/**
 * 更新进度命令
 */
public record UpdateProgressCommand(
        Long courseId,
        Long sectionId,
        Integer lastPosition,
        Integer watchDuration,
        Integer progress
) {}
