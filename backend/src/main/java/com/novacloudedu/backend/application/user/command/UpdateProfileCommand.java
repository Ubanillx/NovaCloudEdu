package com.novacloudedu.backend.application.user.command;

import java.time.LocalDate;

/**
 * 用户更新个人资料命令
 */
public record UpdateProfileCommand(
        String userName,
        String userAvatar,
        String userProfile,
        Integer userGender,
        String userPhone,
        String phoneSmsCode,  // 修改手机号时需要的验证码
        String userEmail,
        String userAddress,
        LocalDate birthday
) {
}
