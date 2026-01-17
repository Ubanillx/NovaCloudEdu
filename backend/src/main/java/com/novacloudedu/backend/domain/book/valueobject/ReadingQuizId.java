package com.novacloudedu.backend.domain.book.valueobject;

import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReadingQuizId {
    private Long value;

    private ReadingQuizId(Long value) {
        this.value = value;
    }

    public static ReadingQuizId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("阅读测试ID必须大于0");
        }
        return new ReadingQuizId(value);
    }
}
