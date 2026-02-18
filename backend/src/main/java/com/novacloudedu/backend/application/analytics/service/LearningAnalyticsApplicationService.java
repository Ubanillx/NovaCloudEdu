package com.novacloudedu.backend.application.analytics.service;

import com.novacloudedu.backend.domain.analytics.repository.LearningActivityRepository;
import com.novacloudedu.backend.domain.analytics.repository.LearningActivityRepository.DailyAggregation;
import com.novacloudedu.backend.domain.analytics.repository.LearningActivityRepository.MemberActivitySummary;
import com.novacloudedu.backend.domain.analytics.repository.LearningActivityRepository.MemberScoreSummary;
import com.novacloudedu.backend.domain.checkin.repository.CheckinRepository;
import com.novacloudedu.backend.domain.clazz.entity.ClassInfo;
import com.novacloudedu.backend.domain.clazz.entity.ClassMember;
import com.novacloudedu.backend.domain.clazz.repository.ClassInfoRepository;
import com.novacloudedu.backend.domain.clazz.repository.ClassMemberRepository;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.grading.entity.StudentKnowledgeProfile;
import com.novacloudedu.backend.domain.grading.repository.StudentKnowledgeProfileRepository;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 学情分析聚合应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class LearningAnalyticsApplicationService {

    private final LearningActivityRepository activityRepository;
    private final StudentKnowledgeProfileRepository profileRepository;
    private final CheckinRepository checkinRepository;
    private final ClassInfoRepository classInfoRepository;
    private final ClassMemberRepository classMemberRepository;
    private final UserRepository userRepository;

    // ==================== 个人学情 ====================

    /**
     * 个人学情概览
     */
    public StudentOverview getStudentOverview(Long userId, LocalDate startDate, LocalDate endDate) {
        // 活动统计
        long totalDurationSec = activityRepository.sumDurationByUserIdAndDateRange(userId, startDate, endDate);
        Map<String, Long> typeCounts = activityRepository.countByTypeAndUserIdAndDateRange(userId, startDate, endDate);

        // 做题统计
        long homeworkSubmitCount = typeCounts.getOrDefault("HOMEWORK_SUBMIT", 0L);

        // 知识画像
        List<StudentKnowledgeProfile> allProfiles = profileRepository.findByStudentId(UserId.of(userId));
        Map<String, Double> subjectMastery = allProfiles.stream()
                .collect(Collectors.groupingBy(
                        p -> p.getSubject().getCode(),
                        Collectors.averagingDouble(StudentKnowledgeProfile::getMasteryLevel)
                ));
        long weakPointCount = allProfiles.stream().filter(StudentKnowledgeProfile::isWeakPoint).count();

        // 打卡统计
        var checkinStatsOpt = checkinRepository.findStatsByUserId(UserId.of(userId));
        int totalCheckinDays = checkinStatsOpt.map(s -> s.getTotalCheckinDays()).orElse(0);
        int currentStreak = checkinStatsOpt.map(s -> s.getCurrentStreak()).orElse(0);

        return new StudentOverview(
                totalDurationSec,
                typeCounts.getOrDefault("COURSE_WATCH", 0L),
                typeCounts.getOrDefault("WORD_STUDY", 0L),
                typeCounts.getOrDefault("ARTICLE_READ", 0L),
                homeworkSubmitCount,
                typeCounts.getOrDefault("CHECKIN", 0L),
                totalCheckinDays,
                currentStreak,
                subjectMastery,
                weakPointCount,
                allProfiles.size()
        );
    }

    /**
     * 个人学习趋势
     */
    public List<TrendItem> getStudentTrend(Long userId, String granularity,
                                            LocalDate startDate, LocalDate endDate) {
        List<DailyAggregation> aggregations = switch (granularity.toUpperCase()) {
            case "WEEK" -> activityRepository.aggregateByWeek(userId, startDate, endDate);
            case "MONTH" -> activityRepository.aggregateByMonth(userId, startDate, endDate);
            default -> activityRepository.aggregateByDay(userId, startDate, endDate);
        };
        return aggregations.stream()
                .map(a -> new TrendItem(a.period(), a.activityCount(), a.totalDurationSec()))
                .collect(Collectors.toList());
    }

    /**
     * 个人各学科学情分析
     */
    public List<SubjectAnalytics> getStudentSubjects(Long userId) {
        List<StudentKnowledgeProfile> allProfiles = profileRepository.findByStudentId(UserId.of(userId));
        Map<String, List<StudentKnowledgeProfile>> grouped = allProfiles.stream()
                .collect(Collectors.groupingBy(p -> p.getSubject().getCode(), LinkedHashMap::new, Collectors.toList()));

        return grouped.entrySet().stream().map(e -> {
            String subjectCode = e.getKey();
            List<StudentKnowledgeProfile> profiles = e.getValue();
            double avgMastery = profiles.stream().mapToDouble(StudentKnowledgeProfile::getMasteryLevel).average().orElse(0);
            long weakCount = profiles.stream().filter(StudentKnowledgeProfile::isWeakPoint).count();
            long strongCount = profiles.stream().filter(p -> p.getMasteryLevel() >= 0.8 && p.getTotalAttempts() >= 3).count();
            int totalAttempts = profiles.stream().mapToInt(StudentKnowledgeProfile::getTotalAttempts).sum();
            int totalCorrect = profiles.stream().mapToInt(StudentKnowledgeProfile::getCorrectCount).sum();
            double correctRate = totalAttempts > 0 ? (double) totalCorrect / totalAttempts : 0;

            String subjectName;
            try {
                subjectName = com.novacloudedu.backend.domain.exam.valueobject.Subject.fromCode(subjectCode).getDescription();
            } catch (Exception ex) {
                subjectName = subjectCode;
            }

            return new SubjectAnalytics(subjectCode, subjectName, avgMastery, profiles.size(),
                    weakCount, strongCount, totalAttempts, correctRate);
        }).collect(Collectors.toList());
    }

    // ==================== 班级学情 ====================

    /**
     * 校验班级访问权限：教师只能看自己创建的班级，管理员不受限
     */
    public ClassInfo verifyClassAccess(Long classId, Long currentUserId) {
        ClassInfo classInfo = classInfoRepository.findById(ClassId.of(classId))
                .orElseThrow(() -> new BusinessException(40400, "班级不存在"));

        User currentUser = userRepository.findById(UserId.of(currentUserId))
                .orElseThrow(() -> new BusinessException(40100, "用户不存在"));

        if (currentUser.getRole() != UserRole.ADMIN) {
            if (!String.valueOf(classInfo.getCreatorId().value())
                    .equals(String.valueOf(currentUserId))) {
                throw new BusinessException(40300, "无权查看该班级学情");
            }
        }
        return classInfo;
    }

    /**
     * 班级学情概览
     */
    public ClassOverview getClassOverview(Long classId, LocalDate startDate, LocalDate endDate) {
        List<ClassMember> members = classMemberRepository.findByClassId(ClassId.of(classId));
        int memberCount = members.size();

        long totalDurationSec = activityRepository.sumDurationByClassIdAndDateRange(classId, startDate, endDate);
        Map<String, Long> typeCounts = activityRepository.countByTypeAndClassIdAndDateRange(classId, startDate, endDate);
        long totalActivities = typeCounts.values().stream().mapToLong(Long::longValue).sum();

        // 平均做题得分率
        List<MemberScoreSummary> scoreSummaries = activityRepository.getMemberScoreSummaries(classId, startDate, endDate);
        long classTotalScore = scoreSummaries.stream().mapToLong(MemberScoreSummary::totalScore).sum();
        long classTotalMaxScore = scoreSummaries.stream().mapToLong(MemberScoreSummary::totalMaxScore).sum();
        double avgScoreRate = classTotalMaxScore > 0 ? (double) classTotalScore / classTotalMaxScore : 0;

        return new ClassOverview(
                memberCount,
                totalDurationSec,
                memberCount > 0 ? totalDurationSec / memberCount : 0,
                totalActivities,
                typeCounts,
                avgScoreRate
        );
    }

    /**
     * 班级成员排名
     */
    public List<StudentRanking> getClassRanking(Long classId, LocalDate startDate, LocalDate endDate) {
        List<ClassMember> members = classMemberRepository.findByClassId(ClassId.of(classId));
        List<MemberActivitySummary> activitySummaries = activityRepository.getMemberActivitySummaries(classId, startDate, endDate);
        List<MemberScoreSummary> scoreSummaries = activityRepository.getMemberScoreSummaries(classId, startDate, endDate);

        Map<Long, MemberActivitySummary> activityMap = activitySummaries.stream()
                .collect(Collectors.toMap(MemberActivitySummary::userId, s -> s));
        Map<Long, MemberScoreSummary> scoreMap = scoreSummaries.stream()
                .collect(Collectors.toMap(MemberScoreSummary::userId, s -> s));

        // 找最大值用于归一化
        long maxDuration = activitySummaries.stream().mapToLong(MemberActivitySummary::totalDurationSec).max().orElse(1);
        long maxActivity = activitySummaries.stream().mapToLong(MemberActivitySummary::activityCount).max().orElse(1);

        List<StudentRanking> rankings = new ArrayList<>();
        for (ClassMember member : members) {
            Long uid = member.getUserId().value();
            MemberActivitySummary as = activityMap.getOrDefault(uid, new MemberActivitySummary(uid, 0, 0));
            MemberScoreSummary ss = scoreMap.getOrDefault(uid, new MemberScoreSummary(uid, 0, 0, 0));

            double scoreRate = ss.totalMaxScore() > 0 ? (double) ss.totalScore() / ss.totalMaxScore() : 0;
            double durationScore = maxDuration > 0 ? (double) as.totalDurationSec() / maxDuration : 0;
            double activityScore = maxActivity > 0 ? (double) as.activityCount() / maxActivity : 0;

            // 综合评分: 学习时长30% + 做题得分30% + 活跃度20% + 坚持度20%
            var checkinStatsOpt2 = checkinRepository.findStatsByUserId(UserId.of(uid));
            double checkinScore = checkinStatsOpt2.map(s -> Math.min(1.0, s.getCurrentStreak() / 30.0)).orElse(0.0);
            double compositeScore = durationScore * 0.3 + scoreRate * 0.3 + activityScore * 0.2 + checkinScore * 0.2;

            String userName = userRepository.findById(UserId.of(uid))
                    .map(User::getUserName).orElse("未知用户");

            rankings.add(new StudentRanking(
                    String.valueOf(uid), userName,
                    as.totalDurationSec(), as.activityCount(),
                    scoreRate, compositeScore
            ));
        }

        rankings.sort(Comparator.comparingDouble(StudentRanking::compositeScore).reversed());
        // 分配排名
        List<StudentRanking> ranked = new ArrayList<>();
        for (int i = 0; i < rankings.size(); i++) {
            var r = rankings.get(i);
            ranked.add(new StudentRanking(r.userId(), r.userName(), r.totalDurationSec(),
                    r.activityCount(), r.scoreRate(), r.compositeScore()));
        }
        return ranked;
    }

    /**
     * 班级学习趋势
     */
    public List<TrendItem> getClassTrend(Long classId, String granularity,
                                          LocalDate startDate, LocalDate endDate) {
        List<DailyAggregation> aggregations = switch (granularity.toUpperCase()) {
            case "WEEK" -> activityRepository.aggregateByWeekForClass(classId, startDate, endDate);
            case "MONTH" -> activityRepository.aggregateByMonthForClass(classId, startDate, endDate);
            default -> activityRepository.aggregateByDayForClass(classId, startDate, endDate);
        };
        return aggregations.stream()
                .map(a -> new TrendItem(a.period(), a.activityCount(), a.totalDurationSec()))
                .collect(Collectors.toList());
    }

    /**
     * 班级各学科分析
     */
    public List<SubjectAnalytics> getClassSubjects(Long classId) {
        List<ClassMember> members = classMemberRepository.findByClassId(ClassId.of(classId));
        List<StudentKnowledgeProfile> allProfiles = new ArrayList<>();
        for (ClassMember member : members) {
            allProfiles.addAll(profileRepository.findByStudentId(member.getUserId()));
        }

        Map<String, List<StudentKnowledgeProfile>> grouped = allProfiles.stream()
                .collect(Collectors.groupingBy(p -> p.getSubject().getCode(), LinkedHashMap::new, Collectors.toList()));

        return grouped.entrySet().stream().map(e -> {
            String subjectCode = e.getKey();
            List<StudentKnowledgeProfile> profiles = e.getValue();
            double avgMastery = profiles.stream().mapToDouble(StudentKnowledgeProfile::getMasteryLevel).average().orElse(0);
            long weakCount = profiles.stream().filter(StudentKnowledgeProfile::isWeakPoint).count();
            long strongCount = profiles.stream().filter(p -> p.getMasteryLevel() >= 0.8 && p.getTotalAttempts() >= 3).count();
            int totalAttempts = profiles.stream().mapToInt(StudentKnowledgeProfile::getTotalAttempts).sum();
            int totalCorrect = profiles.stream().mapToInt(StudentKnowledgeProfile::getCorrectCount).sum();
            double correctRate = totalAttempts > 0 ? (double) totalCorrect / totalAttempts : 0;

            String subjectName;
            try {
                subjectName = com.novacloudedu.backend.domain.exam.valueobject.Subject.fromCode(subjectCode).getDescription();
            } catch (Exception ex) {
                subjectName = subjectCode;
            }

            return new SubjectAnalytics(subjectCode, subjectName, avgMastery, profiles.size(),
                    weakCount, strongCount, totalAttempts, correctRate);
        }).collect(Collectors.toList());
    }

    // ==================== 数据记录 ====================

    public record StudentOverview(
            long totalDurationSec,
            long courseWatchCount,
            long wordStudyCount,
            long articleReadCount,
            long homeworkSubmitCount,
            long checkinCount,
            int totalCheckinDays,
            int currentStreak,
            Map<String, Double> subjectMastery,
            long weakPointCount,
            long totalKnowledgePoints
    ) {}

    public record ClassOverview(
            int memberCount,
            long totalDurationSec,
            long avgDurationSecPerMember,
            long totalActivities,
            Map<String, Long> activityTypeCounts,
            double avgScoreRate
    ) {}

    public record TrendItem(String period, long activityCount, long totalDurationSec) {}

    public record SubjectAnalytics(
            String subjectCode, String subjectName,
            double avgMasteryLevel, long totalKnowledgePoints,
            long weakPointCount, long strongPointCount,
            int totalAttempts, double correctRate
    ) {}

    public record StudentRanking(
            String userId, String userName,
            long totalDurationSec, long activityCount,
            double scoreRate, double compositeScore
    ) {}
}
