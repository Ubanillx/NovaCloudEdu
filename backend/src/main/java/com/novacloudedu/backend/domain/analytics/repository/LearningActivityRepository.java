package com.novacloudedu.backend.domain.analytics.repository;

import com.novacloudedu.backend.domain.analytics.entity.LearningActivity;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * 学习活动仓储接口
 */
public interface LearningActivityRepository {

    LearningActivity save(LearningActivity activity);

    /**
     * 按用户和日期范围查询活动列表
     */
    List<LearningActivity> findByUserIdAndDateRange(UserId userId, LocalDate startDate, LocalDate endDate);

    /**
     * 按用户和日期范围统计总时长（秒）
     */
    long sumDurationByUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate);

    /**
     * 按用户和日期范围统计活动次数（按类型分组）
     */
    Map<String, Long> countByTypeAndUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate);

    /**
     * 按日聚合：用户在日期范围内每天的活动次数和总时长
     */
    List<DailyAggregation> aggregateByDay(Long userId, LocalDate startDate, LocalDate endDate);

    /**
     * 按周聚合
     */
    List<DailyAggregation> aggregateByWeek(Long userId, LocalDate startDate, LocalDate endDate);

    /**
     * 按月聚合
     */
    List<DailyAggregation> aggregateByMonth(Long userId, LocalDate startDate, LocalDate endDate);

    /**
     * 按班级和日期范围统计总时长（秒）
     */
    long sumDurationByClassIdAndDateRange(Long classId, LocalDate startDate, LocalDate endDate);

    /**
     * 按班级和日期范围统计活动次数（按类型分组）
     */
    Map<String, Long> countByTypeAndClassIdAndDateRange(Long classId, LocalDate startDate, LocalDate endDate);

    /**
     * 班级成员活动统计（每个成员的总时长和活动次数）
     */
    List<MemberActivitySummary> getMemberActivitySummaries(Long classId, LocalDate startDate, LocalDate endDate);

    /**
     * 班级按日聚合
     */
    List<DailyAggregation> aggregateByDayForClass(Long classId, LocalDate startDate, LocalDate endDate);

    /**
     * 班级按周聚合
     */
    List<DailyAggregation> aggregateByWeekForClass(Long classId, LocalDate startDate, LocalDate endDate);

    /**
     * 班级按月聚合
     */
    List<DailyAggregation> aggregateByMonthForClass(Long classId, LocalDate startDate, LocalDate endDate);

    /**
     * 班级做题得分汇总（每个成员的平均得分率）
     */
    List<MemberScoreSummary> getMemberScoreSummaries(Long classId, LocalDate startDate, LocalDate endDate);

    /**
     * 日/周/月聚合结果
     */
    record DailyAggregation(String period, long activityCount, long totalDurationSec) {}

    /**
     * 班级成员活动汇总
     */
    record MemberActivitySummary(Long userId, long activityCount, long totalDurationSec) {}

    /**
     * 班级成员得分汇总
     */
    record MemberScoreSummary(Long userId, long totalScore, long totalMaxScore, long submitCount) {}
}
