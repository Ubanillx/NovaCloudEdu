package com.novacloudedu.backend.interfaces.rest.admin.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 仪表盘 AI & 系统响应
 */
@Data
@Builder
public class DashboardAiSystemResponse {

    // AI 对话
    private long totalAiSessions;
    private long todayAiSessions;
    private long totalAiMessages;
    private long todayAiMessages;

    // 智能批改
    private long totalSubmissions;
    private long todaySubmissions;
    private List<Map<String, Object>> submissionsByStatus;
    private List<Map<String, Object>> submissionsBySubject;

    // PPT 生成
    private long totalPptSessions;
    private long todayPptSessions;
    private long completedPptSessions;

    // AI 配额
    private List<Map<String, Object>> aiUsageToday;
    private List<Map<String, Object>> aiUsageTotal;

    // 工作流
    private long totalWorkflows;
    private long totalWorkflowExecutions;
    private long completedWorkflowExecutions;
}
