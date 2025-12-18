package com.novacloudedu.backend.domain.dailylearning.valueobject;

import java.util.Objects;

public record DailyWordId(Long value) {

    public DailyWordId {
        Objects.requireNonNull(value, "每日单词ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("每日单词ID必须大于0");
        }
    }

    public static DailyWordId of(Long value) {
        return new DailyWordId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
