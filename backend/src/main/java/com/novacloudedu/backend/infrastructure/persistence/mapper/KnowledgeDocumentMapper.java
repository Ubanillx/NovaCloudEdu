package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgeDocumentPO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 知识库文档Mapper
 */
@Mapper
public interface KnowledgeDocumentMapper extends BaseMapper<KnowledgeDocumentPO> {

    @Select("SELECT * FROM knowledge_document WHERE knowledge_base_id = #{knowledgeBaseId} AND is_delete = 0 ORDER BY create_time DESC LIMIT #{size} OFFSET #{offset}")
    List<KnowledgeDocumentPO> findByKnowledgeBaseId(@Param("knowledgeBaseId") Long knowledgeBaseId, 
                                                    @Param("offset") int offset, 
                                                    @Param("size") int size);

    @Select("SELECT * FROM knowledge_document WHERE status = #{status} AND is_delete = 0 ORDER BY create_time ASC LIMIT #{size} OFFSET #{offset}")
    List<KnowledgeDocumentPO> findByStatus(@Param("status") String status, 
                                           @Param("offset") int offset, 
                                           @Param("size") int size);

    @Select("SELECT * FROM knowledge_document WHERE status = 'PENDING' AND is_delete = 0 ORDER BY create_time ASC LIMIT #{limit}")
    List<KnowledgeDocumentPO> findPendingDocuments(@Param("limit") int limit);

    @Select("SELECT * FROM knowledge_document WHERE knowledge_base_id = #{knowledgeBaseId} AND status = 'PENDING' AND is_delete = 0 ORDER BY create_time ASC")
    List<KnowledgeDocumentPO> findPendingByKnowledgeBaseId(@Param("knowledgeBaseId") Long knowledgeBaseId);

    @Select("SELECT COUNT(*) FROM knowledge_document WHERE knowledge_base_id = #{knowledgeBaseId} AND is_delete = 0")
    long countByKnowledgeBaseId(@Param("knowledgeBaseId") Long knowledgeBaseId);

    @Select("SELECT status, COUNT(*) AS cnt FROM knowledge_document WHERE knowledge_base_id = #{knowledgeBaseId} AND is_delete = 0 GROUP BY status")
    List<java.util.Map<String, Object>> countByKnowledgeBaseIdGroupByStatus(@Param("knowledgeBaseId") Long knowledgeBaseId);

    @Update("UPDATE knowledge_document SET is_delete = 1, update_time = NOW() WHERE knowledge_base_id = #{knowledgeBaseId}")
    void deleteByKnowledgeBaseId(@Param("knowledgeBaseId") Long knowledgeBaseId);
}
