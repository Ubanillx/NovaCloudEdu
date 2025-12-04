package com.novacloudedu.backend.interfaces.rest.user.dto.response;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户详情响应（管理员视图，包含敏感信息）
 */
public record UserDetailResponse(
        Long id,
        String userAccount,
        String userName,
        String userAvatar,
        String userProfile,
        String role,
        Integer userGender,
        String userPhone,
        String userEmail,
        String userAddress,
        LocalDate birthday,
        Integer level,
        Boolean banned,
        LocalDateTime createTime,
        LocalDateTime updateTime
) {
}
