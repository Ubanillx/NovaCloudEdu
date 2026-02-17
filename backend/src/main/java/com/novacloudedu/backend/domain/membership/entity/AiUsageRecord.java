package com.novacloudedu.backend.domain.membership.entity;

import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * AI使用记录实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AiUsageRecord {

    private Long id;
    private UserId userId;
    private AiFeatureType featureType;
    private LocalDate usageDate;
    private Integer usageCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static AiUsageRecord create(UserId userId, AiFeatureType featureType, LocalDate usageDate) {
        AiUsageRecord record = new AiUsageRecord();
        record.userId = userId;
        record.featureType = featureType;
        record.usageDate = usageDate;
        record.usageCount = 0;
        record.createTime = LocalDateTime.now();
        record.updateTime = LocalDateTime.now();
        return record;
    }

    public static AiUsageRecord reconstruct(Long id, UserId userId, AiFeatureType featureType,
                                             LocalDate usageDate, Integer usageCount,
                                             LocalDateTime createTime, LocalDateTime updateTime) {
        AiUsageRecord record = new AiUsageRecord();
        record.id = id;
        record.userId = userId;
        record.featureType = featureType;
        record.usageDate = usageDate;
        record.usageCount = usageCount;
        record.createTime = createTime;
        record.updateTime = updateTime;
        return record;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("记录ID已分配");
        }
        this.id = id;
    }

    public void incrementUsage() {
        this.usageCount++;
        this.updateTime = LocalDateTime.now();
    }
}
