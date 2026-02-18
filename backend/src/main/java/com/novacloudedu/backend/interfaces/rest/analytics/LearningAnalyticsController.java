package com.novacloudedu.backend.interfaces.rest.analytics;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.analytics.service.AiLearningAnalysisService;
import com.novacloudedu.backend.application.analytics.service.LearningAnalyticsApplicationService;
import com.novacloudedu.backend.application.analytics.service.LearningAnalyticsApplicationService.*;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.analytics.dto.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * 学情分析控制器
 */
@RestController
@RequestMapping("/api/analytics")
@RequiredArgsConstructor
@Tag(name = "学情分析", description = "个人学情和班级学情分析接口")
public class LearningAnalyticsController {

    private final LearningAnalyticsApplicationService analyticsService;
    private final AiLearningAnalysisService aiAnalysisService;

    // ==================== 个人学情 ====================

    @GetMapping("/student/overview")
    @Operation(summary = "个人学情概览")
    public BaseResponse<StudentAnalyticsResponse> getStudentOverview(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Long userId = getLoginUserId();
        LocalDate[] range = resolveRange(startDate, endDate);

        StudentOverview overview = analyticsService.getStudentOverview(userId, range[0], range[1]);

        StudentAnalyticsResponse resp = new StudentAnalyticsResponse();
        resp.setTotalDurationSec(overview.totalDurationSec());
        resp.setTotalDurationText(formatDuration(overview.totalDurationSec()));
        resp.setCourseWatchCount(overview.courseWatchCount());
        resp.setWordStudyCount(overview.wordStudyCount());
        resp.setArticleReadCount(overview.articleReadCount());
        resp.setHomeworkSubmitCount(overview.homeworkSubmitCount());
        resp.setCheckinCount(overview.checkinCount());
        resp.setTotalCheckinDays(overview.totalCheckinDays());
        resp.setCurrentStreak(overview.currentStreak());
        resp.setSubjectMastery(overview.subjectMastery());
        resp.setWeakPointCount(overview.weakPointCount());
        resp.setTotalKnowledgePoints(overview.totalKnowledgePoints());
        return ResultUtils.success(resp);
    }

    @GetMapping("/student/trend")
    @Operation(summary = "个人学习趋势")
    public BaseResponse<LearningTrendResponse> getStudentTrend(
            @RequestParam(defaultValue = "day") String granularity,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Long userId = getLoginUserId();
        LocalDate[] range = resolveRange(startDate, endDate);

        List<TrendItem> items = analyticsService.getStudentTrend(userId, granularity, range[0], range[1]);
        return ResultUtils.success(buildTrendResponse(granularity, items));
    }

    @GetMapping("/student/subjects")
    @Operation(summary = "个人各学科学情")
    public BaseResponse<List<SubjectAnalyticsItem>> getStudentSubjects() {
        Long userId = getLoginUserId();
        List<SubjectAnalytics> subjects = analyticsService.getStudentSubjects(userId);
        return ResultUtils.success(toSubjectItems(subjects));
    }

    @GetMapping(value = "/student/ai-report", produces = "text/event-stream")
    @Operation(summary = "AI个人学情分析报告（SSE流式）")
    public SseEmitter getStudentAiReport(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Long userId = getLoginUserId();
        LocalDate[] range = resolveRange(startDate, endDate);

        StudentOverview overview = analyticsService.getStudentOverview(userId, range[0], range[1]);
        List<SubjectAnalytics> subjects = analyticsService.getStudentSubjects(userId);
        List<TrendItem> trend = analyticsService.getStudentTrend(userId, "day", range[0], range[1]);

        return aiAnalysisService.analyzeStudent(overview, subjects, trend);
    }

    // ==================== 班级学情（教师/管理员） ====================

    @GetMapping("/class/{classId}/overview")
    @Operation(summary = "班级学情概览")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<ClassAnalyticsResponse> getClassOverview(
            @PathVariable Long classId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Long userId = getLoginUserId();
        analyticsService.verifyClassAccess(classId, userId);
        LocalDate[] range = resolveRange(startDate, endDate);

        ClassOverview overview = analyticsService.getClassOverview(classId, range[0], range[1]);

        ClassAnalyticsResponse resp = new ClassAnalyticsResponse();
        resp.setMemberCount(overview.memberCount());
        resp.setTotalDurationSec(overview.totalDurationSec());
        resp.setTotalDurationText(formatDuration(overview.totalDurationSec()));
        resp.setAvgDurationSecPerMember(overview.avgDurationSecPerMember());
        resp.setAvgDurationText(formatDuration(overview.avgDurationSecPerMember()));
        resp.setTotalActivities(overview.totalActivities());
        resp.setActivityTypeCounts(overview.activityTypeCounts());
        resp.setAvgScoreRate(overview.avgScoreRate());
        return ResultUtils.success(resp);
    }

    @GetMapping("/class/{classId}/ranking")
    @Operation(summary = "班级成员排名")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<List<StudentRankingItem>> getClassRanking(
            @PathVariable Long classId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Long userId = getLoginUserId();
        analyticsService.verifyClassAccess(classId, userId);
        LocalDate[] range = resolveRange(startDate, endDate);

        List<StudentRanking> rankings = analyticsService.getClassRanking(classId, range[0], range[1]);

        List<StudentRankingItem> items = new ArrayList<>();
        for (int i = 0; i < rankings.size(); i++) {
            StudentRanking r = rankings.get(i);
            StudentRankingItem item = new StudentRankingItem();
            item.setRank(i + 1);
            item.setUserId(r.userId());
            item.setUserName(r.userName());
            item.setTotalDurationSec(r.totalDurationSec());
            item.setDurationText(formatDuration(r.totalDurationSec()));
            item.setActivityCount(r.activityCount());
            item.setScoreRate(r.scoreRate());
            item.setCompositeScore(r.compositeScore());
            items.add(item);
        }
        return ResultUtils.success(items);
    }

    @GetMapping("/class/{classId}/trend")
    @Operation(summary = "班级学习趋势")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<LearningTrendResponse> getClassTrend(
            @PathVariable Long classId,
            @RequestParam(defaultValue = "day") String granularity,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Long userId = getLoginUserId();
        analyticsService.verifyClassAccess(classId, userId);
        LocalDate[] range = resolveRange(startDate, endDate);

        List<TrendItem> items = analyticsService.getClassTrend(classId, granularity, range[0], range[1]);
        return ResultUtils.success(buildTrendResponse(granularity, items));
    }

    @GetMapping("/class/{classId}/subjects")
    @Operation(summary = "班级各学科分析")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<List<SubjectAnalyticsItem>> getClassSubjects(@PathVariable Long classId) {
        Long userId = getLoginUserId();
        analyticsService.verifyClassAccess(classId, userId);

        List<SubjectAnalytics> subjects = analyticsService.getClassSubjects(classId);
        return ResultUtils.success(toSubjectItems(subjects));
    }

    @GetMapping(value = "/class/{classId}/ai-report", produces = "text/event-stream")
    @Operation(summary = "AI班级学情分析报告（SSE流式）")
    @AuthCheck(mustRole = "teacher")
    public SseEmitter getClassAiReport(
            @PathVariable Long classId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Long userId = getLoginUserId();
        analyticsService.verifyClassAccess(classId, userId);
        LocalDate[] range = resolveRange(startDate, endDate);

        ClassOverview overview = analyticsService.getClassOverview(classId, range[0], range[1]);
        List<SubjectAnalytics> subjects = analyticsService.getClassSubjects(classId);
        List<TrendItem> trend = analyticsService.getClassTrend(classId, "day", range[0], range[1]);
        List<StudentRanking> rankings = analyticsService.getClassRanking(classId, range[0], range[1]);

        return aiAnalysisService.analyzeClass(overview, subjects, trend, rankings);
    }

    // ==================== 工具方法 ====================

    private Long getLoginUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }
        return Long.parseLong(authentication.getName());
    }

    private LocalDate[] resolveRange(LocalDate startDate, LocalDate endDate) {
        if (endDate == null) endDate = LocalDate.now();
        if (startDate == null) startDate = endDate.minusDays(30);
        return new LocalDate[]{startDate, endDate};
    }

    private String formatDuration(long totalSec) {
        if (totalSec < 60) return totalSec + "秒";
        if (totalSec < 3600) return (totalSec / 60) + "分钟";
        return String.format("%d小时%d分钟", totalSec / 3600, (totalSec % 3600) / 60);
    }

    private LearningTrendResponse buildTrendResponse(String granularity, List<TrendItem> items) {
        LearningTrendResponse resp = new LearningTrendResponse();
        resp.setGranularity(granularity);
        List<LearningTrendResponse.TrendItem> trendItems = new ArrayList<>();
        for (TrendItem t : items) {
            LearningTrendResponse.TrendItem item = new LearningTrendResponse.TrendItem();
            item.setPeriod(t.period());
            item.setActivityCount(t.activityCount());
            item.setTotalDurationSec(t.totalDurationSec());
            item.setDurationText(formatDuration(t.totalDurationSec()));
            trendItems.add(item);
        }
        resp.setItems(trendItems);
        return resp;
    }

    private List<SubjectAnalyticsItem> toSubjectItems(List<SubjectAnalytics> subjects) {
        List<SubjectAnalyticsItem> items = new ArrayList<>();
        for (SubjectAnalytics s : subjects) {
            SubjectAnalyticsItem item = new SubjectAnalyticsItem();
            item.setSubjectCode(s.subjectCode());
            item.setSubjectName(s.subjectName());
            item.setAvgMasteryLevel(s.avgMasteryLevel());
            item.setTotalKnowledgePoints(s.totalKnowledgePoints());
            item.setWeakPointCount(s.weakPointCount());
            item.setStrongPointCount(s.strongPointCount());
            item.setTotalAttempts(s.totalAttempts());
            item.setCorrectRate(s.correctRate());
            items.add(item);
        }
        return items;
    }
}
