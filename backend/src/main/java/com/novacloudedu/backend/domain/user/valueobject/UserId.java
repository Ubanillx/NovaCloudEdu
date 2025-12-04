package com.novacloudedu.backend.domain.user.valueobject;

import java.util.Objects;

/**
 * 用户ID值对象
 */
public record UserId(Long value) {

    public UserId {
        Objects.requireNonNull(value, "用户ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("用户ID必须大于0");
        }
    }

    public static UserId of(Long value) {
        return new UserId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
