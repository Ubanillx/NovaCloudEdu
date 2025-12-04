package com.novacloudedu.backend.application.user.command;

/**
 * 用户登录命令
 */
public record LoginUserCommand(
        String userAccount,
        String userPassword
) {
}
