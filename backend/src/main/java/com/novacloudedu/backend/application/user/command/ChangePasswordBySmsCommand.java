package com.novacloudedu.backend.application.user.command;

/**
 * 用户通过短信验证码修改密码命令
 */
public record ChangePasswordBySmsCommand(
        String smsCode,
        String newPassword,
        String confirmPassword
) {
}
