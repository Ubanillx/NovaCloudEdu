package com.novacloudedu.backend.domain.exam.valueobject;

import java.util.Objects;

public record QuestionId(Long value) {

    public QuestionId {
        Objects.requireNonNull(value, "题目ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("题目ID必须大于0");
        }
    }

    public static QuestionId of(Long value) {
        return new QuestionId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
