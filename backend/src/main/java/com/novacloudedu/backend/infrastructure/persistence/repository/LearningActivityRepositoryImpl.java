package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.analytics.entity.LearningActivity;
import com.novacloudedu.backend.domain.analytics.repository.LearningActivityRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.LearningActivityConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.LearningActivityMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.LearningActivityPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 学习活动仓储实现
 */
@Repository
@RequiredArgsConstructor
public class LearningActivityRepositoryImpl implements LearningActivityRepository {

    private final LearningActivityMapper mapper;

    @Override
    public LearningActivity save(LearningActivity activity) {
        LearningActivityPO po = LearningActivityConverter.toPO(activity);
        mapper.insert(po);
        activity.assignId(com.novacloudedu.backend.domain.analytics.valueobject.LearningActivityId.of(po.getId()));
        return activity;
    }

    @Override
    public List<LearningActivity> findByUserIdAndDateRange(UserId userId, LocalDate startDate, LocalDate endDate) {
        return mapper.selectByUserIdAndDateRange(userId.value(), startDate, endDate)
                .stream().map(LearningActivityConverter::toDomain).collect(Collectors.toList());
    }

    @Override
    public long sumDurationByUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate) {
        return mapper.sumDurationByUserIdAndDateRange(userId, startDate, endDate);
    }

    @Override
    public Map<String, Long> countByTypeAndUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate) {
        return toTypeCounts(mapper.countByTypeAndUserIdAndDateRange(userId, startDate, endDate));
    }

    @Override
    public List<DailyAggregation> aggregateByDay(Long userId, LocalDate startDate, LocalDate endDate) {
        return toAggregations(mapper.aggregateByDay(userId, startDate, endDate));
    }

    @Override
    public List<DailyAggregation> aggregateByWeek(Long userId, LocalDate startDate, LocalDate endDate) {
        return toAggregations(mapper.aggregateByWeek(userId, startDate, endDate));
    }

    @Override
    public List<DailyAggregation> aggregateByMonth(Long userId, LocalDate startDate, LocalDate endDate) {
        return toAggregations(mapper.aggregateByMonth(userId, startDate, endDate));
    }

    @Override
    public long sumDurationByClassIdAndDateRange(Long classId, LocalDate startDate, LocalDate endDate) {
        return mapper.sumDurationByClassIdAndDateRange(classId, startDate, endDate);
    }

    @Override
    public Map<String, Long> countByTypeAndClassIdAndDateRange(Long classId, LocalDate startDate, LocalDate endDate) {
        return toTypeCounts(mapper.countByTypeAndClassIdAndDateRange(classId, startDate, endDate));
    }

    @Override
    public List<MemberActivitySummary> getMemberActivitySummaries(Long classId, LocalDate startDate, LocalDate endDate) {
        return mapper.getMemberActivitySummaries(classId, startDate, endDate).stream()
                .map(m -> new MemberActivitySummary(
                        toLong(m.get("user_id")),
                        toLong(m.get("activity_count")),
                        toLong(m.get("total_duration_sec"))
                )).collect(Collectors.toList());
    }

    @Override
    public List<DailyAggregation> aggregateByDayForClass(Long classId, LocalDate startDate, LocalDate endDate) {
        return toAggregations(mapper.aggregateByDayForClass(classId, startDate, endDate));
    }

    @Override
    public List<DailyAggregation> aggregateByWeekForClass(Long classId, LocalDate startDate, LocalDate endDate) {
        return toAggregations(mapper.aggregateByWeekForClass(classId, startDate, endDate));
    }

    @Override
    public List<DailyAggregation> aggregateByMonthForClass(Long classId, LocalDate startDate, LocalDate endDate) {
        return toAggregations(mapper.aggregateByMonthForClass(classId, startDate, endDate));
    }

    @Override
    public List<MemberScoreSummary> getMemberScoreSummaries(Long classId, LocalDate startDate, LocalDate endDate) {
        return mapper.getMemberScoreSummaries(classId, startDate, endDate).stream()
                .map(m -> new MemberScoreSummary(
                        toLong(m.get("user_id")),
                        toLong(m.get("total_score")),
                        toLong(m.get("total_max_score")),
                        toLong(m.get("submit_count"))
                )).collect(Collectors.toList());
    }

    // ==================== 私有工具方法 ====================

    private Map<String, Long> toTypeCounts(List<Map<String, Object>> rows) {
        Map<String, Long> result = new LinkedHashMap<>();
        for (Map<String, Object> row : rows) {
            result.put(String.valueOf(row.get("activity_type")), toLong(row.get("cnt")));
        }
        return result;
    }

    private List<DailyAggregation> toAggregations(List<Map<String, Object>> rows) {
        return rows.stream().map(m -> new DailyAggregation(
                String.valueOf(m.get("period")),
                toLong(m.get("activity_count")),
                toLong(m.get("total_duration_sec"))
        )).collect(Collectors.toList());
    }

    private long toLong(Object obj) {
        if (obj == null) return 0L;
        if (obj instanceof Number) return ((Number) obj).longValue();
        return Long.parseLong(String.valueOf(obj));
    }
}
