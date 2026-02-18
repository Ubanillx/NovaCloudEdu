package com.novacloudedu.backend.application.teacher.command;

/**
 * 拒绝讲师申请命令
 */
public record RejectTeacherApplicationCommand(
        Long applicationId,
        String reason
) {}
