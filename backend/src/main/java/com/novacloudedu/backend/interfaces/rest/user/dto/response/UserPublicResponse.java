package com.novacloudedu.backend.interfaces.rest.user.dto.response;

/**
 * 用户公开信息响应（普通用户视图，不包含敏感信息）
 */
public record UserPublicResponse(
        Long id,
        String userName,
        String userAvatar,
        String userProfile,
        String role,
        Integer userGender,
        Integer level
) {
}
