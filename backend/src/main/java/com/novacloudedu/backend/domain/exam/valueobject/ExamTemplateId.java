package com.novacloudedu.backend.domain.exam.valueobject;

import java.util.Objects;

public record ExamTemplateId(Long value) {

    public ExamTemplateId {
        Objects.requireNonNull(value, "模板ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("模板ID必须大于0");
        }
    }

    public static ExamTemplateId of(Long value) {
        return new ExamTemplateId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
