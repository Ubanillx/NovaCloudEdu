package com.novacloudedu.backend.interfaces.rest.admin.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Map;

/**
 * 仪表盘核心 KPI 卡片响应
 */
@Data
@Builder
public class DashboardOverviewResponse {

    private long totalUsers;
    private Map<String, Long> usersByRole;
    private long todayNewUsers;
    private long yesterdayNewUsers;

    private long totalCourses;
    private Map<Integer, Long> coursesByStatus;

    private long activeMembers;
    private Map<String, Long> membersByPlan;

    private long todayOrders;
    private long yesterdayOrders;
    private double todayRevenue;
    private double yesterdayRevenue;

    private long todayDau;
    private long yesterdayDau;

    private long pendingFeedbacks;

    // 教师专属
    private Long myClassCount;
    private Long myStudentCount;
}
