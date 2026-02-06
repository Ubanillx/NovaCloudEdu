package com.novacloudedu.backend.domain.ai.valueobject;

import java.util.Objects;

/**
 * AI聊天消息ID值对象
 */
public record AiChatMessageId(Long value) {

    public AiChatMessageId {
        Objects.requireNonNull(value, "AI聊天消息ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("AI聊天消息ID必须为正数");
        }
    }

    public static AiChatMessageId of(Long value) {
        return new AiChatMessageId(value);
    }
}
