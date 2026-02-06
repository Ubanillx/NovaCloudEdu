package com.novacloudedu.backend.domain.ai.valueobject;

import java.util.Objects;

/**
 * AI聊天会话ID值对象
 */
public record AiChatSessionId(Long value) {

    public AiChatSessionId {
        Objects.requireNonNull(value, "AI聊天会话ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("AI聊天会话ID必须为正数");
        }
    }

    public static AiChatSessionId of(Long value) {
        return new AiChatSessionId(value);
    }
}
