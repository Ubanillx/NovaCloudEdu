package com.novacloudedu.backend.application.social.command;

/**
 * 处理好友申请命令
 */
public record HandleFriendRequestCommand(
        Long requestId,
        boolean accept
) {
}
