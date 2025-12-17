package com.novacloudedu.backend.domain.course.valueobject;

import java.util.Objects;

public record SectionId(Long value) {

    public SectionId {
        Objects.requireNonNull(value, "小节ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("小节ID必须大于0");
        }
    }

    public static SectionId of(Long value) {
        return new SectionId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
