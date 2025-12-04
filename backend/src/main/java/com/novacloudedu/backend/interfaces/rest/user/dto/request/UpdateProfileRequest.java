package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import java.time.LocalDate;

/**
 * 用户更新个人资料请求
 */
public record UpdateProfileRequest(
        String userName,
        String userAvatar,
        String userProfile,
        Integer userGender,
        String userPhone,
        String userEmail,
        String userAddress,
        LocalDate birthday
) {
}
