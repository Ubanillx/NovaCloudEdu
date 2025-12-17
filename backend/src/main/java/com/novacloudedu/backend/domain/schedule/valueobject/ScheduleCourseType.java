package com.novacloudedu.backend.domain.schedule.valueobject;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ScheduleCourseType {
    CUSTOM(1, "现实课程"),
    PLATFORM(2, "虚拟课程");

    private final int code;
    private final String description;

    public static ScheduleCourseType fromCode(int code) {
        for (ScheduleCourseType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid ScheduleCourseType code: " + code);
    }
}
