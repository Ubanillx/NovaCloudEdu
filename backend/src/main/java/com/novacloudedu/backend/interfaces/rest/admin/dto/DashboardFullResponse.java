package com.novacloudedu.backend.interfaces.rest.admin.dto;

import lombok.Builder;
import lombok.Data;

/**
 * 仪表盘全量聚合响应（首屏加载用）
 */
@Data
@Builder
public class DashboardFullResponse {

    private DashboardOverviewResponse overview;
    private DashboardTrendsResponse trends;
    private DashboardLearningResponse learning;
    private DashboardContentResponse content;
    private DashboardAiSystemResponse aiSystem;
    private DashboardAlertsResponse alerts;
}
