package com.novacloudedu.backend.application.teacher.command;

import java.util.List;

/**
 * 更新讲师信息命令
 */
public record UpdateTeacherCommand(
        Long teacherId,
        String name,
        String introduction,
        List<String> expertise
) {}
