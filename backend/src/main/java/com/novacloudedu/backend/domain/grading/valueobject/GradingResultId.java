package com.novacloudedu.backend.domain.grading.valueobject;

import lombok.EqualsAndHashCode;
import lombok.Getter;

@Getter
@EqualsAndHashCode
public class GradingResultId {
    private final Long value;

    private GradingResultId(Long value) {
        this.value = value;
    }

    public static GradingResultId of(Long value) {
        if (value == null) {
            throw new IllegalArgumentException("GradingResultId不能为空");
        }
        return new GradingResultId(value);
    }
}
