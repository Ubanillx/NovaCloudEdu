package com.novacloudedu.backend.domain.exam.valueobject;

import java.util.Objects;

public record PaperQuestionId(Long value) {

    public PaperQuestionId {
        Objects.requireNonNull(value, "试卷题目关联ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("试卷题目关联ID必须大于0");
        }
    }

    public static PaperQuestionId of(Long value) {
        return new PaperQuestionId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
