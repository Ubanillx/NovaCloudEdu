package com.novacloudedu.backend.application.social.command;

/**
 * 发送好友申请命令
 */
public record SendFriendRequestCommand(
        Long receiverId,
        String message
) {
}
