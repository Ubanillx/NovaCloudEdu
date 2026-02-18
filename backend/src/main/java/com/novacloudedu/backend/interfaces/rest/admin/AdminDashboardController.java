package com.novacloudedu.backend.interfaces.rest.admin;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.admin.service.AdminDashboardApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.interfaces.rest.admin.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

/**
 * 管理员/教师仪表盘 API
 * 管理员：全平台数据
 * 教师：仅本人创建班级范围内的数据
 */
@RestController
@RequestMapping("/api/admin/dashboard")
@RequiredArgsConstructor
public class AdminDashboardController {

    private final AdminDashboardApplicationService dashboardService;

    /**
     * 核心 KPI 卡片
     */
    @GetMapping("/overview")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<DashboardOverviewResponse> getOverview() {
        return ResultUtils.success(dashboardService.getOverview(getCurrentUserId()));
    }

    /**
     * 趋势数据（用户增长/活跃/收入）
     */
    @GetMapping("/trends")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<DashboardTrendsResponse> getTrends(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return ResultUtils.success(dashboardService.getTrends(getCurrentUserId(), startDate, endDate));
    }

    /**
     * 学情概览（活动分布/时长/得分率/排名）
     */
    @GetMapping("/learning")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<DashboardLearningResponse> getLearning(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return ResultUtils.success(dashboardService.getLearning(getCurrentUserId(), startDate, endDate));
    }

    /**
     * 内容运营数据
     */
    @GetMapping("/content")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<DashboardContentResponse> getContent() {
        return ResultUtils.success(dashboardService.getContent(getCurrentUserId()));
    }

    /**
     * AI & 系统监控数据
     */
    @GetMapping("/ai-system")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<DashboardAiSystemResponse> getAiSystem() {
        return ResultUtils.success(dashboardService.getAiSystem(getCurrentUserId()));
    }

    /**
     * 待办 & 预警
     */
    @GetMapping("/alerts")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<DashboardAlertsResponse> getAlerts() {
        return ResultUtils.success(dashboardService.getAlerts(getCurrentUserId()));
    }

    /**
     * 全量聚合（首屏加载用）
     */
    @GetMapping("/full")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<DashboardFullResponse> getFull(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return ResultUtils.success(dashboardService.getFull(getCurrentUserId(), startDate, endDate));
    }

    private Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof Long userId) {
            return userId;
        }
        throw new RuntimeException("未登录");
    }
}
