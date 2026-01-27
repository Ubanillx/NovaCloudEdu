package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgeBasePO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 知识库Mapper
 */
@Mapper
public interface KnowledgeBaseMapper extends BaseMapper<KnowledgeBasePO> {

    @Select("SELECT * FROM knowledge_base WHERE creator_id = #{creatorId} AND is_delete = 0 ORDER BY create_time DESC LIMIT #{size} OFFSET #{offset}")
    List<KnowledgeBasePO> findByCreatorId(@Param("creatorId") Long creatorId, 
                                          @Param("offset") int offset, 
                                          @Param("size") int size);

    @Select("SELECT * FROM knowledge_base WHERE creator_id = #{creatorId} AND status = 'ACTIVE' AND is_delete = 0 ORDER BY create_time DESC LIMIT #{size} OFFSET #{offset}")
    List<KnowledgeBasePO> findActiveByCreatorId(@Param("creatorId") Long creatorId, 
                                                @Param("offset") int offset, 
                                                @Param("size") int size);

    @Select("SELECT * FROM knowledge_base WHERE creator_id = #{creatorId} AND (name ILIKE CONCAT('%', #{keyword}, '%') OR description ILIKE CONCAT('%', #{keyword}, '%')) AND is_delete = 0 ORDER BY create_time DESC LIMIT #{size} OFFSET #{offset}")
    List<KnowledgeBasePO> search(@Param("keyword") String keyword, 
                                 @Param("creatorId") Long creatorId,
                                 @Param("offset") int offset, 
                                 @Param("size") int size);

    @Select("SELECT COUNT(*) FROM knowledge_base WHERE creator_id = #{creatorId} AND is_delete = 0")
    long countByCreatorId(@Param("creatorId") Long creatorId);

    @Update("UPDATE knowledge_base SET chunk_count = #{chunkCount}, update_time = NOW() WHERE id = #{id}")
    void updateChunkCount(@Param("id") Long id, @Param("chunkCount") int chunkCount);
}
