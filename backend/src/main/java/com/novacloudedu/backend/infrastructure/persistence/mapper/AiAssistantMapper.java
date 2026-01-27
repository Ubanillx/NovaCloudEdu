package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiAssistantPO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * AI助手Mapper
 */
@Mapper
public interface AiAssistantMapper extends BaseMapper<AiAssistantPO> {

    @Select("SELECT * FROM ai_assistant WHERE creator_id = #{creatorId} AND is_delete = 0 ORDER BY sort ASC, create_time DESC LIMIT #{size} OFFSET #{offset}")
    List<AiAssistantPO> findByCreatorId(@Param("creatorId") Long creatorId, 
                                        @Param("offset") int offset, 
                                        @Param("size") int size);

    @Select("SELECT * FROM ai_assistant WHERE status = #{status} AND is_delete = 0 ORDER BY sort ASC, create_time DESC LIMIT #{size} OFFSET #{offset}")
    List<AiAssistantPO> findByStatus(@Param("status") String status, 
                                     @Param("offset") int offset, 
                                     @Param("size") int size);

    @Select("SELECT * FROM ai_assistant WHERE is_public = 1 AND status = 'PUBLISHED' AND is_delete = 0 ORDER BY usage_count DESC, sort ASC LIMIT #{size} OFFSET #{offset}")
    List<AiAssistantPO> findPublicAssistants(@Param("offset") int offset, 
                                             @Param("size") int size);

    @Select("SELECT * FROM ai_assistant WHERE category = #{category} AND is_delete = 0 ORDER BY sort ASC, create_time DESC LIMIT #{size} OFFSET #{offset}")
    List<AiAssistantPO> findByCategory(@Param("category") String category, 
                                       @Param("offset") int offset, 
                                       @Param("size") int size);

    @Select("SELECT * FROM ai_assistant WHERE (name ILIKE CONCAT('%', #{keyword}, '%') OR description ILIKE CONCAT('%', #{keyword}, '%')) AND is_delete = 0 ORDER BY usage_count DESC LIMIT #{size} OFFSET #{offset}")
    List<AiAssistantPO> search(@Param("keyword") String keyword, 
                               @Param("offset") int offset, 
                               @Param("size") int size);

    @Select("SELECT COUNT(*) FROM ai_assistant WHERE creator_id = #{creatorId} AND is_delete = 0")
    long countByCreatorId(@Param("creatorId") Long creatorId);
}
