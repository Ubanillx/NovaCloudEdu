package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 群ID值对象
 */
public record GroupId(Long value) {
    public static GroupId of(Long value) {
        return new GroupId(value);
    }
}
