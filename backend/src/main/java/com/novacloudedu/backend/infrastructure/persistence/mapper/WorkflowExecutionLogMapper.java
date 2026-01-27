package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowExecutionLogPO;
import org.apache.ibatis.annotations.*;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 工作流执行日志Mapper
 */
@Mapper
public interface WorkflowExecutionLogMapper extends BaseMapper<WorkflowExecutionLogPO> {

    @Select("SELECT * FROM ai_workflow_execution_log WHERE execution_id = #{executionId} ORDER BY timestamp ASC")
    List<WorkflowExecutionLogPO> findByExecutionId(@Param("executionId") String executionId);

    @Select("SELECT * FROM ai_workflow_execution_log WHERE workflow_id = #{workflowId} AND timestamp >= #{startTime} AND timestamp <= #{endTime} ORDER BY timestamp DESC LIMIT #{size} OFFSET #{offset}")
    List<WorkflowExecutionLogPO> findByWorkflowId(@Param("workflowId") Long workflowId,
                                                   @Param("startTime") LocalDateTime startTime,
                                                   @Param("endTime") LocalDateTime endTime,
                                                   @Param("offset") int offset,
                                                   @Param("size") int size);

    @Select("SELECT * FROM ai_workflow_execution_log WHERE execution_id = #{executionId} AND level = #{level} ORDER BY timestamp ASC")
    List<WorkflowExecutionLogPO> findByLevel(@Param("executionId") String executionId, 
                                              @Param("level") String level);

    @Delete("DELETE FROM ai_workflow_execution_log WHERE execution_id = #{executionId}")
    void deleteByExecutionId(@Param("executionId") String executionId);

    @Delete("DELETE FROM ai_workflow_execution_log WHERE timestamp < #{time}")
    void deleteOlderThan(@Param("time") LocalDateTime time);
}
