package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.analytics.entity.LearningActivity;
import com.novacloudedu.backend.domain.analytics.valueobject.ActivityType;
import com.novacloudedu.backend.domain.analytics.valueobject.LearningActivityId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.LearningActivityPO;

/**
 * 学习活动 PO ↔ Domain 转换器
 */
public class LearningActivityConverter {

    private LearningActivityConverter() {}

    public static LearningActivityPO toPO(LearningActivity entity) {
        LearningActivityPO po = new LearningActivityPO();
        if (entity.getId() != null) {
            po.setId(entity.getId().getValue());
        }
        po.setUserId(entity.getUserId().value());
        po.setActivityType(entity.getActivityType().getCode());
        po.setReferenceId(entity.getReferenceId());
        po.setSubject(entity.getSubject());
        po.setClassId(entity.getClassId());
        po.setDurationSec(entity.getDurationSec());
        po.setScore(entity.getScore());
        po.setMaxScore(entity.getMaxScore());
        po.setDetail(entity.getDetail());
        po.setActivityDate(entity.getActivityDate());
        po.setCreateTime(entity.getCreateTime());
        return po;
    }

    public static LearningActivity toDomain(LearningActivityPO po) {
        if (po == null) return null;
        return LearningActivity.reconstruct(
                LearningActivityId.of(po.getId()),
                UserId.of(po.getUserId()),
                ActivityType.fromCode(po.getActivityType()),
                po.getReferenceId(),
                po.getSubject(),
                po.getClassId(),
                po.getDurationSec() != null ? po.getDurationSec() : 0,
                po.getScore(),
                po.getMaxScore(),
                po.getDetail(),
                po.getActivityDate(),
                po.getCreateTime()
        );
    }
}
