package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowPO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 工作流Mapper
 */
@Mapper
public interface WorkflowMapper extends BaseMapper<WorkflowPO> {

    @Select("SELECT * FROM ai_workflow WHERE creator_id = #{creatorId} AND is_delete = 0 ORDER BY update_time DESC LIMIT #{size} OFFSET #{offset}")
    List<WorkflowPO> findByCreatorId(@Param("creatorId") Long creatorId, 
                                      @Param("offset") int offset, 
                                      @Param("size") int size);

    @Select("SELECT * FROM ai_workflow WHERE status = #{status} AND is_delete = 0 ORDER BY update_time DESC LIMIT #{size} OFFSET #{offset}")
    List<WorkflowPO> findByStatus(@Param("status") String status, 
                                   @Param("offset") int offset, 
                                   @Param("size") int size);

    @Select("SELECT * FROM ai_workflow WHERE is_public = 1 AND status = 'PUBLISHED' AND is_delete = 0 ORDER BY update_time DESC LIMIT #{size} OFFSET #{offset}")
    List<WorkflowPO> findPublicWorkflows(@Param("offset") int offset, @Param("size") int size);

    @Select("SELECT COUNT(*) FROM ai_workflow WHERE creator_id = #{creatorId} AND is_delete = 0")
    long countByCreatorId(@Param("creatorId") Long creatorId);

    @Update("UPDATE ai_workflow SET is_delete = 1, update_time = NOW() WHERE id = #{id}")
    void softDelete(@Param("id") Long id);
}
