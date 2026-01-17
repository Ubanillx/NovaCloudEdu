package com.novacloudedu.backend.domain.book.valueobject;

import java.util.Objects;

public record BookId(Long value) {

    public BookId {
        Objects.requireNonNull(value, "书籍ID不能为空");
        if (value <= 0) {
            throw new IllegalArgumentException("书籍ID必须大于0");
        }
    }

    public static BookId of(Long value) {
        return new BookId(value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
