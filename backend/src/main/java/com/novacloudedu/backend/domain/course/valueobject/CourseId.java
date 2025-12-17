package com.novacloudedu.backend.domain.course.valueobject;

import java.util.Objects;

public record CourseId(Long value) {

    public CourseId {
        Objects.requireNonNull(value, "课程ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("课程ID必须大于0");
        }
    }

    public static CourseId of(Long value) {
        return new CourseId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
