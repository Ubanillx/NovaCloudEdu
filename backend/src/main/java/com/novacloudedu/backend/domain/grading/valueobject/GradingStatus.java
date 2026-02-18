package com.novacloudedu.backend.domain.grading.valueobject;

import lombok.Getter;

@Getter
public enum GradingStatus {
    PENDING("PENDING", "待处理"),
    OCR_PROCESSING("OCR_PROCESSING", "OCR识别中"),
    GRADING("GRADING", "批改中"),
    COMPLETED("COMPLETED", "已完成"),
    FAILED("FAILED", "失败");

    private final String code;
    private final String description;

    GradingStatus(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static GradingStatus fromCode(String code) {
        for (GradingStatus status : values()) {
            if (status.code.equals(code)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的批改状态: " + code);
    }
}
