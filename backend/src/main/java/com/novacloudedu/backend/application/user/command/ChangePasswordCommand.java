package com.novacloudedu.backend.application.user.command;

/**
 * 用户修改密码命令
 */
public record ChangePasswordCommand(
        String oldPassword,
        String newPassword,
        String confirmPassword
) {
}
