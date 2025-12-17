package com.novacloudedu.backend.domain.teacher.valueobject;

import java.util.Objects;

public record TeacherId(Long value) {

    public TeacherId {
        Objects.requireNonNull(value, "讲师ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("讲师ID必须大于0");
        }
    }

    public static TeacherId of(Long value) {
        return new TeacherId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
