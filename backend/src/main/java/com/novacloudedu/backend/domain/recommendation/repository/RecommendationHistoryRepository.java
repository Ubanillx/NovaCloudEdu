package com.novacloudedu.backend.domain.recommendation.repository;

import com.novacloudedu.backend.domain.recommendation.entity.RecommendationHistory;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface RecommendationHistoryRepository {

    RecommendationHistory save(RecommendationHistory history);

    Optional<RecommendationHistory> findById(Long id);

    Optional<RecommendationHistory> findByUserIdAndTarget(UserId userId, TargetType targetType, Long targetId);

    List<RecommendationHistory> findByUserId(UserId userId, int page, int size);

    List<RecommendationHistory> findByUserIdAndTargetType(UserId userId, TargetType targetType, int page, int size);

    List<Long> findRecommendedTargetIds(UserId userId, TargetType targetType, LocalDateTime afterTime);

    void deleteByUserId(UserId userId);
}
