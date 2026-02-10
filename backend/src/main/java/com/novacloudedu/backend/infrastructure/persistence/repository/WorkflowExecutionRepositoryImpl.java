package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.repository.WorkflowExecutionRepository;
import com.novacloudedu.backend.domain.ai.valueobject.ExecutionStatus;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowExecutionId;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.WorkflowExecutionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowExecutionPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Repository
@RequiredArgsConstructor
public class WorkflowExecutionRepositoryImpl implements WorkflowExecutionRepository {

    private final WorkflowExecutionMapper mapper;
    private final ObjectMapper objectMapper;

    @Override
    public void save(WorkflowExecution execution) {
        WorkflowExecutionPO po = toPO(execution);
        mapper.insert(po);
    }

    @Override
    public void update(WorkflowExecution execution) {
        WorkflowExecutionPO po = toPO(execution);
        mapper.updateById(po);
    }

    @Override
    public Optional<WorkflowExecution> findById(WorkflowExecutionId id) {
        WorkflowExecutionPO po = mapper.selectById(id.value());
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<WorkflowExecution> findByWorkflowId(WorkflowId workflowId, int page, int size) {
        Page<WorkflowExecutionPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<WorkflowExecutionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowExecutionPO::getWorkflowId, workflowId.value())
                .eq(WorkflowExecutionPO::getDeleted, 0)
                .orderByDesc(WorkflowExecutionPO::getCreateTime);
        return mapper.selectPage(pageParam, wrapper).getRecords().stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowExecution> findByUserId(UserId userId, int page, int size) {
        Page<WorkflowExecutionPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<WorkflowExecutionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowExecutionPO::getUserId, userId.value())
                .eq(WorkflowExecutionPO::getDeleted, 0)
                .orderByDesc(WorkflowExecutionPO::getCreateTime);
        return mapper.selectPage(pageParam, wrapper).getRecords().stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowExecution> findByStatus(ExecutionStatus status) {
        LambdaQueryWrapper<WorkflowExecutionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowExecutionPO::getStatus, status.name())
                .eq(WorkflowExecutionPO::getDeleted, 0);
        return mapper.selectList(wrapper).stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<WorkflowExecution> findByTimeRange(LocalDateTime start, LocalDateTime end, int page, int size) {
        Page<WorkflowExecutionPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<WorkflowExecutionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.between(WorkflowExecutionPO::getCreateTime, start, end)
                .eq(WorkflowExecutionPO::getDeleted, 0)
                .orderByDesc(WorkflowExecutionPO::getCreateTime);
        return mapper.selectPage(pageParam, wrapper).getRecords().stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByWorkflowId(WorkflowId workflowId) {
        return mapper.countByWorkflowId(workflowId.value());
    }

    @Override
    public long countByUserId(UserId userId) {
        return mapper.countByUserId(userId.value());
    }

    @Override
    public long countByStatus(ExecutionStatus status) {
        LambdaQueryWrapper<WorkflowExecutionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkflowExecutionPO::getStatus, status.name())
                .eq(WorkflowExecutionPO::getDeleted, 0);
        return mapper.selectCount(wrapper);
    }

    @Override
    public ExecutionStatistics getStatistics(WorkflowId workflowId) {
        List<Map<String, Object>> statusCounts = mapper.countByStatusGrouped(workflowId.value());
        Double avgDuration = mapper.avgDuration(workflowId.value());

        long total = 0, success = 0, failed = 0, cancelled = 0;
        for (Map<String, Object> row : statusCounts) {
            String status = (String) row.get("status");
            long count = ((Number) row.get("count")).longValue();
            total += count;
            if ("COMPLETED".equals(status)) success = count;
            else if ("FAILED".equals(status)) failed = count;
            else if ("CANCELLED".equals(status)) cancelled = count;
        }

        double successRate = total > 0 ? (double) success / total : 0.0;
        return new ExecutionStatistics(total, success, failed, cancelled, 
                avgDuration != null ? avgDuration : 0.0, successRate);
    }

    @Override
    public void delete(WorkflowExecutionId id) {
        WorkflowExecutionPO po = new WorkflowExecutionPO();
        po.setId(id.value());
        po.setDeleted(1);
        mapper.updateById(po);
    }

    @Override
    public int cleanupExpired(LocalDateTime before) {
        LambdaQueryWrapper<WorkflowExecutionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.lt(WorkflowExecutionPO::getCreateTime, before)
                .eq(WorkflowExecutionPO::getDeleted, 0);
        
        WorkflowExecutionPO update = new WorkflowExecutionPO();
        update.setDeleted(1);
        return mapper.update(update, wrapper);
    }

    private WorkflowExecutionPO toPO(WorkflowExecution execution) {
        WorkflowExecutionPO po = new WorkflowExecutionPO();
        po.setId(execution.getId().value());
        po.setWorkflowId(execution.getWorkflowId().value());
        po.setWorkflowName(execution.getWorkflowName());
        po.setWorkflowVersion(execution.getWorkflowVersion());
        po.setStatus(execution.getStatus().name());
        po.setCurrentNodeId(execution.getCurrentNodeId());
        po.setErrorMessage(execution.getErrorMessage());
        po.setUserId(execution.getUserId().value());
        po.setStartTime(execution.getStartTime());
        po.setEndTime(execution.getEndTime());
        po.setDurationMs(execution.getDurationMs());

        try {
            po.setInput(objectMapper.writeValueAsString(execution.getInput()));
            po.setOutput(objectMapper.writeValueAsString(execution.getOutput()));
            po.setVariables(objectMapper.writeValueAsString(execution.getVariables()));
            po.setNodeExecutions(objectMapper.writeValueAsString(execution.getNodeExecutions()));
        } catch (Exception e) {
            log.error("序列化执行数据失败", e);
        }

        LocalDateTime now = LocalDateTime.now();
        if (po.getCreateTime() == null) {
            po.setCreateTime(now);
        }
        po.setUpdateTime(now);

        return po;
    }

    private WorkflowExecution toDomain(WorkflowExecutionPO po) {
        Map<String, Object> input = null, output = null, variables = null;
        List<WorkflowExecution.NodeExecution> nodeExecutions = null;
        try {
            if (po.getInput() != null) {
                input = objectMapper.readValue(po.getInput(), new TypeReference<>() {});
            }
            if (po.getOutput() != null) {
                output = objectMapper.readValue(po.getOutput(), new TypeReference<>() {});
            }
            if (po.getVariables() != null) {
                variables = objectMapper.readValue(po.getVariables(), new TypeReference<>() {});
            }
        } catch (Exception e) {
            log.error("反序列化执行数据失败", e);
        }

        // 反序列化节点执行记录
        try {
            if (po.getNodeExecutions() != null) {
                nodeExecutions = objectMapper.readValue(po.getNodeExecutions(),
                        new TypeReference<List<WorkflowExecution.NodeExecution>>() {});
            }
        } catch (Exception e) {
            log.error("反序列化节点执行记录失败", e);
        }

        return WorkflowExecution.reconstruct(
                WorkflowExecutionId.of(po.getId()),
                WorkflowId.of(po.getWorkflowId()),
                po.getWorkflowName(),
                po.getWorkflowVersion(),
                ExecutionStatus.valueOf(po.getStatus()),
                input,
                output,
                variables,
                po.getCurrentNodeId(),
                po.getErrorMessage(),
                UserId.of(po.getUserId()),
                po.getStartTime(),
                po.getEndTime(),
                po.getDurationMs(),
                nodeExecutions
        );
    }
}
