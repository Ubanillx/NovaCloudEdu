package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.valueobject.CourseDifficulty;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;

import java.math.BigDecimal;
import java.util.List;

/**
 * 更新课程命令
 */
public record UpdateCourseCommand(
        Long courseId,
        String title,
        String subtitle,
        String description,
        String coverImage,
        BigDecimal price,
        CourseType courseType,
        CourseDifficulty difficulty,
        List<String> tags
) {}
