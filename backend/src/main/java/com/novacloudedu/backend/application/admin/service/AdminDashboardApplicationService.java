package com.novacloudedu.backend.application.admin.service;

import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.persistence.mapper.DashboardStatsMapper;
import com.novacloudedu.backend.interfaces.rest.admin.dto.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理员仪表盘应用服务
 * 管理员：全平台数据
 * 教师：仅本人创建班级范围内的数据
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class AdminDashboardApplicationService {

    private final DashboardStatsMapper statsMapper;
    private final UserRepository userRepository;

    // ==================== Overview ====================

    public DashboardOverviewResponse getOverview(Long currentUserId) {
        User user = getUser(currentUserId);
        boolean isAdmin = user.isAdmin();

        LocalDateTime todayStart = LocalDate.now().atStartOfDay();
        LocalDateTime todayEnd = todayStart.plusDays(1);
        LocalDateTime yesterdayStart = todayStart.minusDays(1);

        DashboardOverviewResponse.DashboardOverviewResponseBuilder builder = DashboardOverviewResponse.builder();

        if (isAdmin) {
            builder.totalUsers(statsMapper.countTotalUsers())
                    .usersByRole(toStringLongMap(statsMapper.countUsersByRole(), "user_role", "cnt"))
                    .todayNewUsers(statsMapper.countNewUsers(todayStart, todayEnd))
                    .yesterdayNewUsers(statsMapper.countNewUsers(yesterdayStart, todayStart))
                    .totalCourses(statsMapper.countTotalCourses())
                    .coursesByStatus(toIntLongMap(statsMapper.countCoursesByStatus(), "status", "cnt"))
                    .activeMembers(statsMapper.countActiveMembers())
                    .membersByPlan(toStringLongMap(statsMapper.countMembersByPlan(), "name", "cnt"))
                    .todayOrders(statsMapper.countOrders(todayStart, todayEnd))
                    .yesterdayOrders(statsMapper.countOrders(yesterdayStart, todayStart))
                    .todayRevenue(statsMapper.sumRevenue(todayStart, todayEnd))
                    .yesterdayRevenue(statsMapper.sumRevenue(yesterdayStart, todayStart))
                    .todayDau(statsMapper.countDau(LocalDate.now()))
                    .yesterdayDau(statsMapper.countDau(LocalDate.now().minusDays(1)))
                    .pendingFeedbacks(statsMapper.countPendingFeedbacks());
        } else {
            // 教师视角：班级范围
            Long teacherId = currentUserId;
            builder.myClassCount(statsMapper.countClassesByTeacher(teacherId))
                    .myStudentCount(statsMapper.countStudentsByTeacher(teacherId))
                    .todayDau(statsMapper.countDauByTeacher(teacherId, LocalDate.now()))
                    .yesterdayDau(statsMapper.countDauByTeacher(teacherId, LocalDate.now().minusDays(1)))
                    .pendingFeedbacks(0L);
        }

        return builder.build();
    }

    // ==================== Trends ====================

    public DashboardTrendsResponse getTrends(Long currentUserId, LocalDate startDate, LocalDate endDate) {
        User user = getUser(currentUserId);
        boolean isAdmin = user.isAdmin();

        if (startDate == null) startDate = LocalDate.now().minusDays(30);
        if (endDate == null) endDate = LocalDate.now();

        LocalDateTime startDt = startDate.atStartOfDay();
        LocalDateTime endDt = endDate.plusDays(1).atStartOfDay();

        DashboardTrendsResponse.DashboardTrendsResponseBuilder builder = DashboardTrendsResponse.builder();

        if (isAdmin) {
            builder.userGrowth(statsMapper.dailyNewUsers(startDt, endDt))
                    .activeTrend(statsMapper.dailyActiveStats(startDate, endDate))
                    .revenueTrend(statsMapper.dailyRevenue(startDt, endDt));
        } else {
            // 教师：只看活跃趋势（班级范围）
            builder.activeTrend(statsMapper.dailyActiveStatsForTeacher(currentUserId, startDate, endDate));
        }

        return builder.build();
    }

    // ==================== Learning ====================

    public DashboardLearningResponse getLearning(Long currentUserId, LocalDate startDate, LocalDate endDate) {
        User user = getUser(currentUserId);
        boolean isAdmin = user.isAdmin();

        if (startDate == null) startDate = LocalDate.now().minusDays(30);
        if (endDate == null) endDate = LocalDate.now();

        DashboardLearningResponse.DashboardLearningResponseBuilder builder = DashboardLearningResponse.builder();

        if (isAdmin) {
            builder.activityDistribution(statsMapper.countActivityByType(startDate, endDate))
                    .totalDurationSec(statsMapper.sumTotalDuration(startDate, endDate))
                    .avgHomeworkScoreRate(statsMapper.avgHomeworkScoreRate(startDate, endDate))
                    .topActiveUsers(statsMapper.topActiveUsers(startDate, endDate))
                    .topActiveClasses(statsMapper.topActiveClasses(startDate, endDate))
                    .dailyActiveTrend(statsMapper.dailyActiveStats(startDate, endDate));
        } else {
            Long teacherId = currentUserId;
            builder.activityDistribution(statsMapper.countActivityByTypeForTeacher(teacherId, startDate, endDate))
                    .avgHomeworkScoreRate(statsMapper.avgHomeworkScoreRateForTeacher(teacherId, startDate, endDate))
                    .topActiveUsers(statsMapper.topActiveUsersForTeacher(teacherId, startDate, endDate))
                    .dailyActiveTrend(statsMapper.dailyActiveStatsForTeacher(teacherId, startDate, endDate));
        }

        return builder.build();
    }

    // ==================== Content ====================

    public DashboardContentResponse getContent(Long currentUserId) {
        // 内容数据对管理员和教师都一样（全平台公共内容）
        LocalDateTime todayStart = LocalDate.now().atStartOfDay();
        LocalDateTime todayEnd = todayStart.plusDays(1);

        return DashboardContentResponse.builder()
                .totalCourses(statsMapper.countTotalCourses())
                .totalCourseStudents(statsMapper.sumCourseStudentCount())
                .avgCourseRating(statsMapper.avgCourseRating())
                .topCourses(statsMapper.topCoursesByStudentCount())
                .totalArticles(statsMapper.countTotalArticles())
                .totalArticleViews(statsMapper.sumArticleViews())
                .totalArticleLikes(statsMapper.sumArticleLikes())
                .topArticles(statsMapper.topArticlesByViews())
                .totalWords(statsMapper.countTotalWords())
                .totalExamPapers(statsMapper.countTotalExamPapers())
                .totalQuestions(statsMapper.countTotalQuestions())
                .examPapersBySubject(statsMapper.countExamPapersBySubject())
                .totalBooks(statsMapper.countTotalBooks())
                .totalPosts(statsMapper.countTotalPosts())
                .todayNewPosts(statsMapper.countNewPosts(todayStart, todayEnd))
                .totalPostLikes(statsMapper.sumPostLikes())
                .totalPostComments(statsMapper.sumPostComments())
                .topPosts(statsMapper.topPostsByLikes())
                .build();
    }

    // ==================== AI System ====================

    public DashboardAiSystemResponse getAiSystem(Long currentUserId) {
        // AI 系统数据只对管理员完整展示，教师可看部分
        LocalDateTime todayStart = LocalDate.now().atStartOfDay();
        LocalDateTime todayEnd = todayStart.plusDays(1);

        return DashboardAiSystemResponse.builder()
                .totalAiSessions(statsMapper.countTotalAiSessions())
                .todayAiSessions(statsMapper.countNewAiSessions(todayStart, todayEnd))
                .totalAiMessages(statsMapper.countTotalAiMessages())
                .todayAiMessages(statsMapper.countNewAiMessages(todayStart, todayEnd))
                .totalSubmissions(statsMapper.countTotalSubmissions())
                .todaySubmissions(statsMapper.countNewSubmissions(todayStart, todayEnd))
                .submissionsByStatus(statsMapper.countSubmissionsByStatus())
                .submissionsBySubject(statsMapper.countSubmissionsBySubject())
                .totalPptSessions(statsMapper.countTotalPptSessions())
                .todayPptSessions(statsMapper.countNewPptSessions(todayStart, todayEnd))
                .completedPptSessions(statsMapper.countCompletedPptSessions())
                .aiUsageToday(statsMapper.aiUsageTodayByFeature(LocalDate.now()))
                .aiUsageTotal(statsMapper.aiUsageTotalByFeature())
                .totalWorkflows(statsMapper.countTotalWorkflows())
                .totalWorkflowExecutions(statsMapper.countTotalWorkflowExecutions())
                .completedWorkflowExecutions(statsMapper.countCompletedWorkflowExecutions())
                .build();
    }

    // ==================== Alerts ====================

    public DashboardAlertsResponse getAlerts(Long currentUserId) {
        LocalDateTime weekAgo = LocalDateTime.now().minusDays(7);

        return DashboardAlertsResponse.builder()
                .pendingFeedbackCount(statsMapper.countPendingFeedbacks())
                .recentPendingFeedbacks(statsMapper.recentPendingFeedbacks())
                .expiringMemberCount(statsMapper.countExpiringMembers(LocalDateTime.now(), LocalDateTime.now().plusDays(7)))
                .failedScraperTaskCount(statsMapper.countFailedScraperTasks(weekAgo))
                .todayCheckinCount(statsMapper.countTodayCheckins(LocalDate.now()))
                .totalUserCount(statsMapper.countTotalUsers())
                .build();
    }

    // ==================== Full ====================

    public DashboardFullResponse getFull(Long currentUserId, LocalDate startDate, LocalDate endDate) {
        return DashboardFullResponse.builder()
                .overview(getOverview(currentUserId))
                .trends(getTrends(currentUserId, startDate, endDate))
                .learning(getLearning(currentUserId, startDate, endDate))
                .content(getContent(currentUserId))
                .aiSystem(getAiSystem(currentUserId))
                .alerts(getAlerts(currentUserId))
                .build();
    }

    // ==================== Helpers ====================

    private User getUser(Long userId) {
        return userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(40100, "用户不存在"));
    }

    private Map<String, Long> toStringLongMap(List<Map<String, Object>> rows, String keyCol, String valCol) {
        Map<String, Long> result = new HashMap<>();
        if (rows != null) {
            for (Map<String, Object> row : rows) {
                String key = String.valueOf(row.get(keyCol));
                Long val = ((Number) row.get(valCol)).longValue();
                result.put(key, val);
            }
        }
        return result;
    }

    private Map<Integer, Long> toIntLongMap(List<Map<String, Object>> rows, String keyCol, String valCol) {
        Map<Integer, Long> result = new HashMap<>();
        if (rows != null) {
            for (Map<String, Object> row : rows) {
                Integer key = ((Number) row.get(keyCol)).intValue();
                Long val = ((Number) row.get(valCol)).longValue();
                result.put(key, val);
            }
        }
        return result;
    }
}
