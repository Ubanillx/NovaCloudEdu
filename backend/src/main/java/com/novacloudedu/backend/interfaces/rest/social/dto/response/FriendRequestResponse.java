package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

/**
 * 好友申请响应
 */
@Schema(description = "好友申请响应")
public record FriendRequestResponse(
        @Schema(description = "申请ID")
        Long id,

        @Schema(description = "发送者ID")
        Long senderId,

        @Schema(description = "发送者用户名")
        String senderName,

        @Schema(description = "发送者头像")
        String senderAvatar,

        @Schema(description = "接收者ID")
        Long receiverId,

        @Schema(description = "接收者用户名")
        String receiverName,

        @Schema(description = "接收者头像")
        String receiverAvatar,

        @Schema(description = "申请状态：pending/accepted/rejected")
        String status,

        @Schema(description = "申请消息")
        String message,

        @Schema(description = "创建时间")
        LocalDateTime createTime
) {
}
