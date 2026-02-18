package com.novacloudedu.backend.interfaces.rest.admin.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 仪表盘待办预警响应
 */
@Data
@Builder
public class DashboardAlertsResponse {

    private long pendingFeedbackCount;
    private List<Map<String, Object>> recentPendingFeedbacks;

    private long expiringMemberCount;

    private long failedScraperTaskCount;

    private long todayCheckinCount;
    private long totalUserCount;
}
