package com.novacloudedu.backend.infrastructure.workflow;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.entity.WorkflowTrigger;
import com.novacloudedu.backend.domain.ai.repository.WorkflowRepository;
import com.novacloudedu.backend.domain.ai.repository.WorkflowTriggerRepository;
import com.novacloudedu.backend.domain.ai.service.WorkflowEngine;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import java.util.Map;
import java.util.TimeZone;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;

/**
 * 工作流定时调度服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class WorkflowSchedulerService {

    private final TaskScheduler taskScheduler;
    private final WorkflowTriggerRepository triggerRepository;
    private final WorkflowRepository workflowRepository;
    private final WorkflowEngine workflowEngine;

    private final Map<Long, ScheduledFuture<?>> scheduledTasks = new ConcurrentHashMap<>();

    @PostConstruct
    public void init() {
        loadAndScheduleAllTriggers();
        log.info("工作流调度服务初始化完成");
    }

    @PreDestroy
    public void destroy() {
        scheduledTasks.values().forEach(future -> future.cancel(false));
        scheduledTasks.clear();
        log.info("工作流调度服务已停止");
    }

    /**
     * 加载并调度所有启用的定时触发器
     */
    public void loadAndScheduleAllTriggers() {
        triggerRepository.findEnabledScheduleTriggers().forEach(this::scheduleTrigger);
    }

    /**
     * 调度单个触发器
     */
    public void scheduleTrigger(WorkflowTrigger trigger) {
        if (trigger.getType() != WorkflowTrigger.TriggerType.SCHEDULE) {
            return;
        }

        String cronExpression = trigger.getCronExpression();
        if (cronExpression == null || cronExpression.isBlank()) {
            log.warn("触发器缺少cron表达式: triggerId={}", trigger.getId());
            return;
        }

        // 取消已存在的调度
        cancelTrigger(trigger.getId());

        try {
            String timezone = (String) trigger.getConfig().getOrDefault("timezone", "Asia/Shanghai");
            CronTrigger cronTrigger = new CronTrigger(cronExpression, TimeZone.getTimeZone(timezone));

            ScheduledFuture<?> future = taskScheduler.schedule(
                    () -> executeWorkflow(trigger),
                    cronTrigger
            );

            scheduledTasks.put(trigger.getId(), future);
            log.info("已调度工作流触发器: triggerId={}, cron={}", trigger.getId(), cronExpression);

        } catch (Exception e) {
            log.error("调度触发器失败: triggerId={}, error={}", trigger.getId(), e.getMessage(), e);
        }
    }

    /**
     * 取消触发器调度
     */
    public void cancelTrigger(Long triggerId) {
        ScheduledFuture<?> future = scheduledTasks.remove(triggerId);
        if (future != null) {
            future.cancel(false);
            log.info("已取消工作流触发器: triggerId={}", triggerId);
        }
    }

    /**
     * 执行工作流
     */
    private void executeWorkflow(WorkflowTrigger trigger) {
        try {
            log.info("定时触发工作流: triggerId={}, workflowId={}", 
                    trigger.getId(), trigger.getWorkflowId());

            // 获取工作流
            Workflow workflow = workflowRepository.findById(trigger.getWorkflowId())
                    .orElseThrow(() -> new IllegalStateException("工作流不存在: " + trigger.getWorkflowId()));

            if (!workflow.canExecute()) {
                log.warn("工作流未发布，跳过执行: workflowId={}", trigger.getWorkflowId());
                return;
            }

            // 构建输入参数
            Map<String, Object> input = Map.of(
                    "_triggerType", "SCHEDULE",
                    "_triggerId", trigger.getId(),
                    "_triggerTime", java.time.LocalDateTime.now().toString()
            );

            // 异步执行工作流
            workflowEngine.executeAsync(workflow, input, UserId.of(workflow.getCreatorId().value()));

            // 记录触发
            trigger.recordTrigger();
            triggerRepository.update(trigger);

        } catch (Exception e) {
            log.error("定时执行工作流失败: triggerId={}, error={}", trigger.getId(), e.getMessage(), e);
        }
    }

    /**
     * 启用触发器
     */
    public void enableTrigger(Long triggerId) {
        triggerRepository.findById(triggerId).ifPresent(trigger -> {
            trigger.enable();
            triggerRepository.update(trigger);
            scheduleTrigger(trigger);
        });
    }

    /**
     * 禁用触发器
     */
    public void disableTrigger(Long triggerId) {
        triggerRepository.findById(triggerId).ifPresent(trigger -> {
            trigger.disable();
            triggerRepository.update(trigger);
            cancelTrigger(triggerId);
        });
    }
}
