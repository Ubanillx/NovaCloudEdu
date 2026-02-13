package com.novacloudedu.backend.domain.exam.valueobject;

import java.util.Objects;

public record ExamPaperId(Long value) {

    public ExamPaperId {
        Objects.requireNonNull(value, "试卷ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("试卷ID必须大于0");
        }
    }

    public static ExamPaperId of(Long value) {
        return new ExamPaperId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
