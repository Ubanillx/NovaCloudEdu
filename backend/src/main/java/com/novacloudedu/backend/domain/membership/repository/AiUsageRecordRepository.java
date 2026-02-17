package com.novacloudedu.backend.domain.membership.repository;

import com.novacloudedu.backend.domain.membership.entity.AiUsageRecord;
import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface AiUsageRecordRepository {

    AiUsageRecord save(AiUsageRecord record);

    Optional<AiUsageRecord> findByUserIdAndFeatureTypeAndDate(UserId userId, AiFeatureType featureType, LocalDate date);

    /**
     * 查询用户某功能在指定月份的使用总次数
     */
    int sumMonthlyUsage(UserId userId, AiFeatureType featureType, int year, int month);

    /**
     * 批量查询用户指定日期所有功能的使用记录
     */
    List<AiUsageRecord> findByUserIdAndDate(UserId userId, LocalDate date);

    /**
     * 批量查询用户指定月份所有功能的使用汇总 (featureType -> totalCount)
     */
    Map<String, Integer> sumAllMonthlyUsage(UserId userId, int year, int month);

    /**
     * 原子性地增加使用计数（upsert）
     */
    void incrementUsage(UserId userId, AiFeatureType featureType, LocalDate date);
}
