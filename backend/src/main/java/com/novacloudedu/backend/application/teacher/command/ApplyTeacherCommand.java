package com.novacloudedu.backend.application.teacher.command;

import java.util.List;

/**
 * 申请成为讲师命令
 */
public record ApplyTeacherCommand(
        String name,
        String introduction,
        List<String> expertise,
        String certificateUrl
) {}
