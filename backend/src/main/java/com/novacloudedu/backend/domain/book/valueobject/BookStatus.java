package com.novacloudedu.backend.domain.book.valueobject;

import lombok.Getter;

@Getter
public enum BookStatus {
    UPLOADED(0, "已上传"),
    PROCESSING(1, "解析中"),
    READY(2, "就绪"),
    FAILED(3, "解析失败");

    private final int code;
    private final String description;

    BookStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static BookStatus fromCode(int code) {
        for (BookStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的书籍状态码: " + code);
    }
}
