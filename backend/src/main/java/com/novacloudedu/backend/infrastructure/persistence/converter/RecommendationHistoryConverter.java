package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.recommendation.entity.RecommendationHistory;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.RecommendationHistoryPO;
import org.springframework.stereotype.Component;

@Component
public class RecommendationHistoryConverter {

    public RecommendationHistoryPO toPO(RecommendationHistory history) {
        RecommendationHistoryPO po = new RecommendationHistoryPO();
        if (history.getId() != null) {
            po.setId(history.getId());
        }
        po.setUserId(history.getUserId().value());
        po.setTargetType(history.getTargetType().getCode());
        po.setTargetId(history.getTargetId());
        po.setRecommendationScore(history.getRecommendationScore());
        po.setRecommendationReason(history.getRecommendationReason());
        po.setIsClicked(history.isClicked() ? 1 : 0);
        po.setIsInteracted(history.isInteracted() ? 1 : 0);
        po.setCreateTime(history.getCreateTime());
        po.setUpdateTime(history.getUpdateTime());
        return po;
    }

    public RecommendationHistory toDomain(RecommendationHistoryPO po) {
        return RecommendationHistory.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                TargetType.fromCode(po.getTargetType()),
                po.getTargetId(),
                po.getRecommendationScore(),
                po.getRecommendationReason(),
                po.getIsClicked() == 1,
                po.getIsInteracted() == 1,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
