package com.novacloudedu.backend.domain.book.valueobject;

import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AiConversationId {
    private Long value;

    private AiConversationId(Long value) {
        this.value = value;
    }

    public static AiConversationId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("AI对话ID必须大于0");
        }
        return new AiConversationId(value);
    }
}
