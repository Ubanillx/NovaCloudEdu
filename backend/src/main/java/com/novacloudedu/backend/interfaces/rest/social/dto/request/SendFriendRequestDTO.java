package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;

/**
 * 发送好友申请请求
 */
@Schema(description = "发送好友申请请求")
public record SendFriendRequestDTO(
        @Schema(description = "接收者用户ID", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "接收者ID不能为空")
        Long receiverId,

        @Schema(description = "申请消息")
        String message
) {
}
