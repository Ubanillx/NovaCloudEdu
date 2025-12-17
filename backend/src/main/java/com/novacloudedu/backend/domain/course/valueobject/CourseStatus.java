package com.novacloudedu.backend.domain.course.valueobject;

import lombok.Getter;

@Getter
public enum CourseStatus {
    UNPUBLISHED(0, "未发布"),
    PUBLISHED(1, "已发布"),
    OFFLINE(2, "已下架");

    private final int code;
    private final String description;

    CourseStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static CourseStatus fromCode(int code) {
        for (CourseStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的课程状态码: " + code);
    }
}
