package com.novacloudedu.backend.domain.recommendation.entity;

import com.novacloudedu.backend.domain.recommendation.valueobject.PreferenceType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserPreference {

    private Long id;
    private UserId userId;
    private PreferenceType preferenceType;
    private String preferenceKey;
    private BigDecimal preferenceValue;
    private Integer interactionCount;
    private LocalDateTime lastInteractionTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static UserPreference create(UserId userId, PreferenceType preferenceType, String preferenceKey) {
        UserPreference preference = new UserPreference();
        preference.userId = userId;
        preference.preferenceType = preferenceType;
        preference.preferenceKey = preferenceKey;
        preference.preferenceValue = BigDecimal.ZERO;
        preference.interactionCount = 0;
        preference.createTime = LocalDateTime.now();
        preference.updateTime = LocalDateTime.now();
        return preference;
    }

    public static UserPreference reconstruct(Long id, UserId userId, PreferenceType preferenceType,
                                             String preferenceKey, BigDecimal preferenceValue,
                                             Integer interactionCount, LocalDateTime lastInteractionTime,
                                             LocalDateTime createTime, LocalDateTime updateTime) {
        UserPreference preference = new UserPreference();
        preference.id = id;
        preference.userId = userId;
        preference.preferenceType = preferenceType;
        preference.preferenceKey = preferenceKey;
        preference.preferenceValue = preferenceValue;
        preference.interactionCount = interactionCount;
        preference.lastInteractionTime = lastInteractionTime;
        preference.createTime = createTime;
        preference.updateTime = updateTime;
        return preference;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void incrementInteraction(double behaviorWeight) {
        this.interactionCount++;
        this.lastInteractionTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
        recalculatePreferenceValue(behaviorWeight);
    }

    private void recalculatePreferenceValue(double behaviorWeight) {
        double baseScore = this.interactionCount * behaviorWeight;
        double timeDecay = calculateTimeDecay();
        double newValue = Math.min(100.0, baseScore * timeDecay);
        this.preferenceValue = BigDecimal.valueOf(newValue);
    }

    private double calculateTimeDecay() {
        if (lastInteractionTime == null) {
            return 1.0;
        }
        long daysSinceLastInteraction = java.time.Duration.between(lastInteractionTime, LocalDateTime.now()).toDays();
        return Math.max(0.5, 1.0 - (daysSinceLastInteraction * 0.01));
    }

    public void updatePreferenceValue(BigDecimal value) {
        this.preferenceValue = value;
        this.updateTime = LocalDateTime.now();
    }
}
