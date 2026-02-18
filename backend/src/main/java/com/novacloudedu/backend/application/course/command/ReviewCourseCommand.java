package com.novacloudedu.backend.application.course.command;

/**
 * 评价课程命令
 */
public record ReviewCourseCommand(
        Long courseId,
        Integer rating
) {}
