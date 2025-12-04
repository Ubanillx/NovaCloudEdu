package com.novacloudedu.backend.application.user.command;

import java.time.LocalDate;

/**
 * 管理员创建用户命令
 */
public record CreateUserCommand(
        String userAccount,
        String userPassword,
        String userName,
        String role,
        Integer userGender,
        String userPhone,
        String userEmail,
        String userAddress,
        LocalDate birthday
) {
}
