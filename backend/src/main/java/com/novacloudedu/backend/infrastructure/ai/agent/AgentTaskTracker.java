package com.novacloudedu.backend.infrastructure.ai.agent;

import lombok.extern.slf4j.Slf4j;

import java.time.Instant;
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.function.Consumer;

/**
 * Agent 任务跟踪器 — 维护多 Agent 工作流的 TodoList，
 * 跟踪每个 Agent 的任务状态并通过回调实时推送 SSE 事件。
 *
 * 生命周期：每次 PPT 生成创建一个新的 Tracker 实例，
 * 由 PptAgentOrchestrator 在 generateWithReflection 内部创建并传递。
 */
@Slf4j
public class AgentTaskTracker {

    /** 任务状态枚举 */
    public enum TaskStatus {
        PENDING("待执行"),
        IN_PROGRESS("执行中"),
        COMPLETED("已完成"),
        FAILED("失败"),
        SKIPPED("跳过");

        private final String label;
        TaskStatus(String label) { this.label = label; }
        public String label() { return label; }
    }

    /** Agent 角色枚举 */
    public enum AgentRole {
        PLANNER("PlannerAgent", "规划大纲"),
        RESEARCHER("WebSearchTool", "联网搜索"),
        CONTENT("ContentAgent", "内容生成"),
        DESIGN("DesignAgent", "视觉优化"),
        EVALUATOR("EvaluatorAgent", "质量评估"),
        REPAIRER("RepairAgent", "反思修复"),
        ASSEMBLER("Assembler", "PPT组装");

        private final String name;
        private final String description;
        AgentRole(String name, String description) {
            this.name = name;
            this.description = description;
        }
        public String agentName() { return name; }
        public String description() { return description; }
    }

    /** 单个任务 */
    public record AgentTask(
            String id,
            AgentRole agent,
            String description,
            TaskStatus status,
            String detail,
            Instant startedAt,
            Instant completedAt,
            int slideIndex
    ) {
        public Map<String, Object> toMap() {
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("id", id);
            map.put("agent", agent.agentName());
            map.put("agentRole", agent.name());
            map.put("description", description);
            map.put("status", status.name());
            map.put("statusLabel", status.label());
            map.put("detail", detail != null ? detail : "");
            if (slideIndex >= 0) {
                map.put("slideIndex", slideIndex);
            }
            if (startedAt != null) {
                map.put("startedAt", startedAt.toEpochMilli());
            }
            if (completedAt != null) {
                map.put("completedAt", completedAt.toEpochMilli());
                if (startedAt != null) {
                    map.put("durationMs", completedAt.toEpochMilli() - startedAt.toEpochMilli());
                }
            }
            return map;
        }
    }

    private final List<AgentTask> tasks = new CopyOnWriteArrayList<>();
    private final Consumer<Map<String, Object>> sseCallback;
    private int taskCounter = 0;

    /**
     * @param sseCallback 每次任务状态变更时调用，推送 SSE 事件数据
     */
    public AgentTaskTracker(Consumer<Map<String, Object>> sseCallback) {
        this.sseCallback = sseCallback;
    }

    // ==================== 任务管理 ====================

    /**
     * 添加一个待执行任务
     */
    public String addTask(AgentRole agent, String description) {
        return addTask(agent, description, -1);
    }

    /**
     * 添加一个带幻灯片索引的待执行任务
     */
    public String addTask(AgentRole agent, String description, int slideIndex) {
        String id = "task-" + (++taskCounter);
        AgentTask task = new AgentTask(id, agent, description,
                TaskStatus.PENDING, null, null, null, slideIndex);
        tasks.add(task);
        pushUpdate("task_added", task);
        return id;
    }

    /**
     * 标记任务为执行中
     */
    public void startTask(String taskId, String detail) {
        updateTask(taskId, TaskStatus.IN_PROGRESS, detail, false);
    }

    /**
     * 标记任务完成
     */
    public void completeTask(String taskId, String detail) {
        updateTask(taskId, TaskStatus.COMPLETED, detail, true);
    }

    /**
     * 标记任务失败
     */
    public void failTask(String taskId, String detail) {
        updateTask(taskId, TaskStatus.FAILED, detail, true);
    }

    /**
     * 标记任务跳过
     */
    public void skipTask(String taskId, String detail) {
        updateTask(taskId, TaskStatus.SKIPPED, detail, true);
    }

    /**
     * 更新任务详情（不改变状态）
     */
    public void updateDetail(String taskId, String detail) {
        for (int i = 0; i < tasks.size(); i++) {
            AgentTask old = tasks.get(i);
            if (old.id().equals(taskId)) {
                AgentTask updated = new AgentTask(old.id(), old.agent(), old.description(),
                        old.status(), detail, old.startedAt(), old.completedAt(), old.slideIndex());
                tasks.set(i, updated);
                pushUpdate("task_updated", updated);
                return;
            }
        }
    }

    /**
     * 按角色查找第一个匹配的任务ID
     */
    public String findTaskIdByRole(AgentRole role) {
        for (AgentTask task : tasks) {
            if (task.agent() == role) {
                return task.id();
            }
        }
        return null;
    }

    // ==================== 快捷方法（一步创建+开始） ====================

    /**
     * 创建并立即开始一个任务
     */
    public String startNewTask(AgentRole agent, String description, String detail) {
        String id = addTask(agent, description);
        startTask(id, detail);
        return id;
    }

    /**
     * 创建并立即开始一个带幻灯片索引的任务
     */
    public String startNewTask(AgentRole agent, String description, String detail, int slideIndex) {
        String id = addTask(agent, description, slideIndex);
        startTask(id, detail);
        return id;
    }

    // ==================== 查询 ====================

    /**
     * 获取完整的任务列表快照
     */
    public List<Map<String, Object>> getTaskListSnapshot() {
        List<Map<String, Object>> snapshot = new ArrayList<>();
        for (AgentTask task : tasks) {
            snapshot.add(task.toMap());
        }
        return snapshot;
    }

    /**
     * 获取任务摘要统计
     */
    public Map<String, Object> getSummary() {
        int total = tasks.size();
        int completed = 0, inProgress = 0, failed = 0, pending = 0;
        for (AgentTask task : tasks) {
            switch (task.status()) {
                case COMPLETED -> completed++;
                case IN_PROGRESS -> inProgress++;
                case FAILED -> failed++;
                case PENDING -> pending++;
                default -> {}
            }
        }
        return Map.of(
                "total", total,
                "completed", completed,
                "inProgress", inProgress,
                "failed", failed,
                "pending", pending,
                "progress", total > 0 ? (completed * 100 / total) : 0
        );
    }

    // ==================== 推送完整列表 ====================

    /**
     * 推送当前完整任务列表到前端（用于阶段切换时刷新整个列表）
     */
    public void pushFullList() {
        if (sseCallback != null) {
            Map<String, Object> event = new LinkedHashMap<>();
            event.put("type", "full_list");
            event.put("tasks", getTaskListSnapshot());
            event.put("summary", getSummary());
            sseCallback.accept(event);
        }
    }

    // ==================== 内部方法 ====================

    private void updateTask(String taskId, TaskStatus newStatus, String detail, boolean isTerminal) {
        for (int i = 0; i < tasks.size(); i++) {
            AgentTask old = tasks.get(i);
            if (old.id().equals(taskId)) {
                Instant started = old.startedAt();
                Instant completed = old.completedAt();

                if (newStatus == TaskStatus.IN_PROGRESS && started == null) {
                    started = Instant.now();
                }
                if (isTerminal) {
                    completed = Instant.now();
                }

                AgentTask updated = new AgentTask(old.id(), old.agent(), old.description(),
                        newStatus, detail, started, completed, old.slideIndex());
                tasks.set(i, updated);
                pushUpdate("task_status_changed", updated);
                return;
            }
        }
        log.warn("任务不存在: {}", taskId);
    }

    private void pushUpdate(String eventType, AgentTask task) {
        if (sseCallback != null) {
            Map<String, Object> event = new LinkedHashMap<>();
            event.put("type", eventType);
            event.put("task", task.toMap());
            event.put("summary", getSummary());
            sseCallback.accept(event);
        }
    }
}
