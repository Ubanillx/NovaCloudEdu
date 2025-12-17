package com.novacloudedu.backend.domain.course.valueobject;

import lombok.Getter;

@Getter
public enum CourseType {
    FREE(0, "公开课"),
    PAID(1, "付费课"),
    MEMBER(2, "会员课");

    private final int code;
    private final String description;

    CourseType(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static CourseType fromCode(int code) {
        for (CourseType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("未知的课程类型码: " + code);
    }
}
