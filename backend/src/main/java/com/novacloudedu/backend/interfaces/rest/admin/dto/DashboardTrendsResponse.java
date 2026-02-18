package com.novacloudedu.backend.interfaces.rest.admin.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 仪表盘趋势数据响应
 */
@Data
@Builder
public class DashboardTrendsResponse {

    private List<Map<String, Object>> userGrowth;
    private List<Map<String, Object>> activeTrend;
    private List<Map<String, Object>> revenueTrend;
}
