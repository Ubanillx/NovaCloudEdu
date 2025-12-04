package com.novacloudedu.backend.application.user.command;

import java.time.LocalDate;

/**
 * 管理员更新用户命令
 */
public record UpdateUserCommand(
        Long id,
        String userName,
        String userAvatar,
        String userProfile,
        String role,
        Integer userGender,
        String userPhone,
        String userEmail,
        String userAddress,
        LocalDate birthday,
        Integer level
) {
}
