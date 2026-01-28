package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowExecutionPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 工作流执行记录Mapper
 */
@Mapper
public interface WorkflowExecutionMapper extends BaseMapper<WorkflowExecutionPO> {

    @Select("SELECT status, COUNT(*) as count FROM workflow_execution " +
            "WHERE workflow_id = #{workflowId} AND deleted = 0 GROUP BY status")
    List<Map<String, Object>> countByStatusGrouped(@Param("workflowId") Long workflowId);

    @Select("SELECT AVG(duration_ms) FROM workflow_execution " +
            "WHERE workflow_id = #{workflowId} AND status = 'COMPLETED' AND deleted = 0")
    Double avgDuration(@Param("workflowId") Long workflowId);

    @Select("SELECT COUNT(*) FROM workflow_execution " +
            "WHERE workflow_id = #{workflowId} AND deleted = 0")
    long countByWorkflowId(@Param("workflowId") Long workflowId);

    @Select("SELECT COUNT(*) FROM workflow_execution " +
            "WHERE user_id = #{userId} AND deleted = 0")
    long countByUserId(@Param("userId") Long userId);
}
