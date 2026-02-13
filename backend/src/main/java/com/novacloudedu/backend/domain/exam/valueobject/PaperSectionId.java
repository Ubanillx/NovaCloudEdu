package com.novacloudedu.backend.domain.exam.valueobject;

import java.util.Objects;

public record PaperSectionId(Long value) {

    public PaperSectionId {
        Objects.requireNonNull(value, "大题ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("大题ID必须大于0");
        }
    }

    public static PaperSectionId of(Long value) {
        return new PaperSectionId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
