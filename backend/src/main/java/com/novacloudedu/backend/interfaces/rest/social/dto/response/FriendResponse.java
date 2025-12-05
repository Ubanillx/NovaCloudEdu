package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

/**
 * 好友信息响应
 */
@Schema(description = "好友信息响应")
public record FriendResponse(
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

        @Schema(description = "成为好友时间")
        LocalDateTime friendSince
) {
}
