package com.novacloudedu.backend.domain.book.valueobject;

import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ChapterSummaryId {
    private Long value;

    private ChapterSummaryId(Long value) {
        this.value = value;
    }

    public static ChapterSummaryId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("章节总结ID必须大于0");
        }
        return new ChapterSummaryId(value);
    }
}
