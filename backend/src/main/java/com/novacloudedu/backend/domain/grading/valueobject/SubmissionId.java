package com.novacloudedu.backend.domain.grading.valueobject;

import lombok.EqualsAndHashCode;
import lombok.Getter;

@Getter
@EqualsAndHashCode
public class SubmissionId {
    private final Long value;

    private SubmissionId(Long value) {
        this.value = value;
    }

    public static SubmissionId of(Long value) {
        if (value == null) {
            throw new IllegalArgumentException("SubmissionId不能为空");
        }
        return new SubmissionId(value);
    }
}
