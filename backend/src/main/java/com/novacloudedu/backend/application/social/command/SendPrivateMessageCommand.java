package com.novacloudedu.backend.application.social.command;

import com.novacloudedu.backend.domain.social.valueobject.MessageType;

/**
 * 发送私聊消息命令
 */
public record SendPrivateMessageCommand(
        Long senderId,
        Long receiverId,
        String content,
        MessageType type
) {
}
