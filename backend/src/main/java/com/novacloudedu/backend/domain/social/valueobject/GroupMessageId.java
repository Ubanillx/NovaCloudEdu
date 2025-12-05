package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 群消息ID值对象
 */
public record GroupMessageId(Long value) {
    public static GroupMessageId of(Long value) {
        return new GroupMessageId(value);
    }
}
