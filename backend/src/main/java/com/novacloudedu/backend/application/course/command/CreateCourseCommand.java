package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.valueobject.CourseDifficulty;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;

import java.math.BigDecimal;
import java.util.List;

/**
 * 创建课程命令
 */
public record CreateCourseCommand(
        String title,
        String subtitle,
        String description,
        String coverImage,
        BigDecimal price,
        CourseType courseType,
        CourseDifficulty difficulty,
        Long teacherId,
        List<String> tags
) {}
