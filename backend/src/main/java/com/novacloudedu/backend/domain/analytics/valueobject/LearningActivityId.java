package com.novacloudedu.backend.domain.analytics.valueobject;

import lombok.Value;

/**
 * 学习活动ID值对象
 */
@Value(staticConstructor = "of")
public class LearningActivityId {
    Long value;
}
