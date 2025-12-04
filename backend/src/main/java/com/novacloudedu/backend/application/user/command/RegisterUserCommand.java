package com.novacloudedu.backend.application.user.command;

/**
 * 用户注册命令
 */
public record RegisterUserCommand(
        String userAccount,
        String userPassword,
        String checkPassword,
        String phone,
        String smsCode
) {
}
