package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 会话ID值对象
 */
public record SessionId(Long value) {

    public static SessionId of(Long value) {
        return new SessionId(value);
    }
}
