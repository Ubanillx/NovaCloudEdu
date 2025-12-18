package com.novacloudedu.backend.domain.recommendation.entity;

import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class RecommendationHistory {

    private Long id;
    private UserId userId;
    private TargetType targetType;
    private Long targetId;
    private BigDecimal recommendationScore;
    private String recommendationReason;
    private boolean clicked;
    private boolean interacted;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static RecommendationHistory create(UserId userId, TargetType targetType, Long targetId,
                                               BigDecimal recommendationScore, String recommendationReason) {
        RecommendationHistory history = new RecommendationHistory();
        history.userId = userId;
        history.targetType = targetType;
        history.targetId = targetId;
        history.recommendationScore = recommendationScore;
        history.recommendationReason = recommendationReason;
        history.clicked = false;
        history.interacted = false;
        history.createTime = LocalDateTime.now();
        history.updateTime = LocalDateTime.now();
        return history;
    }

    public static RecommendationHistory reconstruct(Long id, UserId userId, TargetType targetType,
                                                    Long targetId, BigDecimal recommendationScore,
                                                    String recommendationReason, boolean clicked,
                                                    boolean interacted, LocalDateTime createTime,
                                                    LocalDateTime updateTime) {
        RecommendationHistory history = new RecommendationHistory();
        history.id = id;
        history.userId = userId;
        history.targetType = targetType;
        history.targetId = targetId;
        history.recommendationScore = recommendationScore;
        history.recommendationReason = recommendationReason;
        history.clicked = clicked;
        history.interacted = interacted;
        history.createTime = createTime;
        history.updateTime = updateTime;
        return history;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void markAsClicked() {
        this.clicked = true;
        this.updateTime = LocalDateTime.now();
    }

    public void markAsInteracted() {
        this.interacted = true;
        this.updateTime = LocalDateTime.now();
    }
}
