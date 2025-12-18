package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.recommendation.entity.UserBehaviorLog;
import com.novacloudedu.backend.domain.recommendation.valueobject.BehaviorType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserBehaviorLogPO;
import org.springframework.stereotype.Component;

@Component
public class UserBehaviorLogConverter {

    public UserBehaviorLogPO toPO(UserBehaviorLog log) {
        UserBehaviorLogPO po = new UserBehaviorLogPO();
        if (log.getId() != null) {
            po.setId(log.getId());
        }
        po.setUserId(log.getUserId().value());
        po.setBehaviorType(log.getBehaviorType().getCode());
        po.setTargetType(log.getTargetType().getCode());
        po.setTargetId(log.getTargetId());
        po.setBehaviorData(log.getBehaviorData());
        po.setDuration(log.getDuration());
        po.setCreateTime(log.getCreateTime());
        return po;
    }

    public UserBehaviorLog toDomain(UserBehaviorLogPO po) {
        return UserBehaviorLog.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                BehaviorType.fromCode(po.getBehaviorType()),
                TargetType.fromCode(po.getTargetType()),
                po.getTargetId(),
                po.getBehaviorData(),
                po.getDuration(),
                po.getCreateTime()
        );
    }
}
