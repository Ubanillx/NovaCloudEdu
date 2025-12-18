package com.novacloudedu.backend.domain.dailylearning.valueobject;

import java.util.Objects;

public record DailyArticleId(Long value) {

    public DailyArticleId {
        Objects.requireNonNull(value, "每日文章ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("每日文章ID必须大于0");
        }
    }

    public static DailyArticleId of(Long value) {
        return new DailyArticleId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
