package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 消息ID值对象
 */
public record MessageId(Long value) {

    public static MessageId of(Long value) {
        return new MessageId(value);
    }
}
