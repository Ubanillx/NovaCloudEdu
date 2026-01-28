package com.novacloudedu.backend.application.user.command;

/**
 * 手机验证码登录命令
 */
public record PhoneLoginCommand(
        String phone,
        String smsCode
) {
}
