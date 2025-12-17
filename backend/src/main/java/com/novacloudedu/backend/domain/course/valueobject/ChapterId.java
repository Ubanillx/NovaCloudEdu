package com.novacloudedu.backend.domain.course.valueobject;

import java.util.Objects;

public record ChapterId(Long value) {

    public ChapterId {
        Objects.requireNonNull(value, "章节ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("章节ID必须大于0");
        }
    }

    public static ChapterId of(Long value) {
        return new ChapterId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
