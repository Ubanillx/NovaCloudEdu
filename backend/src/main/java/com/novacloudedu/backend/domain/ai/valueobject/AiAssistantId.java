package com.novacloudedu.backend.domain.ai.valueobject;

import java.util.Objects;

/**
 * AI助手ID值对象
 */
public record AiAssistantId(Long value) {

    public AiAssistantId {
        Objects.requireNonNull(value, "AI助手ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("AI助手ID必须为正数");
        }
    }

    public static AiAssistantId of(Long value) {
        return new AiAssistantId(value);
    }
}
