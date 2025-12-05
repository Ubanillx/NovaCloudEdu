package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 搜索用户响应
 */
@Schema(description = "搜索用户响应")
public record SearchUserResponse(
        @Schema(description = "用户ID")
        Long userId,

        @Schema(description = "用户账号")
        String userAccount,

        @Schema(description = "用户名")
        String userName,

        @Schema(description = "用户头像")
        String userAvatar,

        @Schema(description = "个人简介")
        String userProfile,

        @Schema(description = "是否已是好友")
        Boolean isFriend,

        @Schema(description = "是否有待处理的申请")
        Boolean hasPendingRequest
) {
}
