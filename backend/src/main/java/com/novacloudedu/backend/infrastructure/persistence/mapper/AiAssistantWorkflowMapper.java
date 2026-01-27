package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantWorkflowPO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * AI助手工作流关联Mapper
 */
@Mapper
public interface AiAssistantWorkflowMapper extends BaseMapper<AiAssistantWorkflowPO> {

    @Select("SELECT * FROM ai_assistant_workflow WHERE assistant_id = #{assistantId}")
    List<AiAssistantWorkflowPO> findByAssistantId(@Param("assistantId") Long assistantId);

    @Select("SELECT * FROM ai_assistant_workflow WHERE workflow_id = #{workflowId}")
    List<AiAssistantWorkflowPO> findByWorkflowId(@Param("workflowId") Long workflowId);

    @Select("SELECT workflow_id FROM ai_assistant_workflow WHERE assistant_id = #{assistantId}")
    List<Long> findWorkflowIdsByAssistantId(@Param("assistantId") Long assistantId);

    @Select("SELECT assistant_id FROM ai_assistant_workflow WHERE workflow_id = #{workflowId}")
    List<Long> findAssistantIdsByWorkflowId(@Param("workflowId") Long workflowId);

    @Delete("DELETE FROM ai_assistant_workflow WHERE assistant_id = #{assistantId}")
    void deleteByAssistantId(@Param("assistantId") Long assistantId);

    @Delete("DELETE FROM ai_assistant_workflow WHERE workflow_id = #{workflowId}")
    void deleteByWorkflowId(@Param("workflowId") Long workflowId);

    @Delete("DELETE FROM ai_assistant_workflow WHERE assistant_id = #{assistantId} AND workflow_id = #{workflowId}")
    void deleteByAssistantIdAndWorkflowId(@Param("assistantId") Long assistantId, @Param("workflowId") Long workflowId);

    @Select("SELECT COUNT(*) > 0 FROM ai_assistant_workflow WHERE assistant_id = #{assistantId} AND workflow_id = #{workflowId}")
    boolean existsByAssistantIdAndWorkflowId(@Param("assistantId") Long assistantId, @Param("workflowId") Long workflowId);
}
