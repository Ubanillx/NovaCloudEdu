package com.novacloudedu.backend.domain.recommendation.repository;

import com.novacloudedu.backend.domain.recommendation.entity.UserBehaviorLog;
import com.novacloudedu.backend.domain.recommendation.valueobject.BehaviorType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDateTime;
import java.util.List;

public interface UserBehaviorLogRepository {

    UserBehaviorLog save(UserBehaviorLog log);

    List<UserBehaviorLog> findByUserId(UserId userId, int page, int size);

    List<UserBehaviorLog> findByUserIdAndTargetType(UserId userId, TargetType targetType, int page, int size);

    List<UserBehaviorLog> findByUserIdAndBehaviorType(UserId userId, BehaviorType behaviorType, int page, int size);

    List<UserBehaviorLog> findByUserIdAfterTime(UserId userId, LocalDateTime afterTime);

    long countByUserId(UserId userId);
}
