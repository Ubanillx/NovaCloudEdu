package com.novacloudedu.backend.domain.schedule.valueobject;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ScheduleWeekType {
    ALL(0, "每周"),
    ODD(1, "单周"),
    EVEN(2, "双周");

    private final int code;
    private final String description;

    public static ScheduleWeekType fromCode(int code) {
        for (ScheduleWeekType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid ScheduleWeekType code: " + code);
    }
}
