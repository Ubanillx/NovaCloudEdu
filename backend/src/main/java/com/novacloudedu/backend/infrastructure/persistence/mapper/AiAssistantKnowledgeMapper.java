package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantKnowledgePO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * AI助手与知识库关联Mapper
 */
@Mapper
public interface AiAssistantKnowledgeMapper extends BaseMapper<AiAssistantKnowledgePO> {

    @Select("SELECT knowledge_base_id FROM ai_assistant_knowledge WHERE assistant_id = #{assistantId}")
    List<Long> findKnowledgeBaseIds(@Param("assistantId") Long assistantId);

    @Delete("DELETE FROM ai_assistant_knowledge WHERE assistant_id = #{assistantId} AND knowledge_base_id = #{knowledgeBaseId}")
    void deleteByAssistantAndKnowledge(@Param("assistantId") Long assistantId, 
                                       @Param("knowledgeBaseId") Long knowledgeBaseId);

    @Delete("DELETE FROM ai_assistant_knowledge WHERE assistant_id = #{assistantId}")
    void deleteByAssistantId(@Param("assistantId") Long assistantId);
}
