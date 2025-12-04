package com.novacloudedu.backend.application.user.command;

/**
 * 管理员重置用户密码命令
 */
public record ResetPasswordCommand(
        Long userId,
        String newPassword
) {
}
