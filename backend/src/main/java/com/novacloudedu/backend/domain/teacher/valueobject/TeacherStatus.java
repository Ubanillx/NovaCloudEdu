package com.novacloudedu.backend.domain.teacher.valueobject;

import lombok.Getter;

@Getter
public enum TeacherStatus {
    PENDING(0, "待审核"),
    APPROVED(1, "已通过"),
    REJECTED(2, "已拒绝");

    private final int code;
    private final String description;

    TeacherStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static TeacherStatus fromCode(int code) {
        for (TeacherStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的讲师状态码: " + code);
    }
}
