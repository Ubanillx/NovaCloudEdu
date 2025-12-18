package com.novacloudedu.backend.domain.recommendation.entity;

import com.novacloudedu.backend.domain.recommendation.valueobject.BehaviorType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserBehaviorLog {

    private Long id;
    private UserId userId;
    private BehaviorType behaviorType;
    private TargetType targetType;
    private Long targetId;
    private String behaviorData;
    private Integer duration;
    private LocalDateTime createTime;

    public static UserBehaviorLog create(UserId userId, BehaviorType behaviorType,
                                         TargetType targetType, Long targetId,
                                         String behaviorData, Integer duration) {
        UserBehaviorLog log = new UserBehaviorLog();
        log.userId = userId;
        log.behaviorType = behaviorType;
        log.targetType = targetType;
        log.targetId = targetId;
        log.behaviorData = behaviorData;
        log.duration = duration != null ? duration : 0;
        log.createTime = LocalDateTime.now();
        return log;
    }

    public static UserBehaviorLog reconstruct(Long id, UserId userId, BehaviorType behaviorType,
                                              TargetType targetType, Long targetId,
                                              String behaviorData, Integer duration,
                                              LocalDateTime createTime) {
        UserBehaviorLog log = new UserBehaviorLog();
        log.id = id;
        log.userId = userId;
        log.behaviorType = behaviorType;
        log.targetType = targetType;
        log.targetId = targetId;
        log.behaviorData = behaviorData;
        log.duration = duration;
        log.createTime = createTime;
        return log;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("ID已分配，不可重复分配");
        }
        this.id = id;
    }
}
