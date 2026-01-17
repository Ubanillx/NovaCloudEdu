package com.novacloudedu.backend.domain.book.valueobject;

public record ReadingPosition(int chapterIndex, int offset) {

    public ReadingPosition {
        if (chapterIndex < 0) {
            throw new IllegalArgumentException("章节序号不能为负数");
        }
        if (offset < 0) {
            throw new IllegalArgumentException("偏移量不能为负数");
        }
    }

    public static ReadingPosition of(int chapterIndex, int offset) {
        return new ReadingPosition(chapterIndex, offset);
    }

    public static ReadingPosition start() {
        return new ReadingPosition(0, 0);
    }

    public boolean isAtStart() {
        return chapterIndex == 0 && offset == 0;
    }

    @Override
    public String toString() {
        return String.format("Chapter %d, Offset %d", chapterIndex, offset);
    }
}
