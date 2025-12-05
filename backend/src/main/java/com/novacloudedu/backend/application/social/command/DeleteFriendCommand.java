package com.novacloudedu.backend.application.social.command;

/**
 * 删除好友命令
 */
public record DeleteFriendCommand(
        Long friendId
) {
}
