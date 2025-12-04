package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;

/**
 * 更新用户请求
 */
public record UpdateUserRequest(
        @NotNull(message = "用户ID不能为空")
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
