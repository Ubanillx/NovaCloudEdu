package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiChatSessionPO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * AI聊天会话Mapper
 */
@Mapper
public interface AiChatSessionMapper extends BaseMapper<AiChatSessionPO> {

    @Select("SELECT * FROM ai_chat_session WHERE user_id = #{userId} AND is_delete = 0 ORDER BY update_time DESC LIMIT #{size} OFFSET #{offset}")
    List<AiChatSessionPO> findByUserId(@Param("userId") Long userId,
                                        @Param("offset") int offset,
                                        @Param("size") int size);

    @Select("SELECT COUNT(*) FROM ai_chat_session WHERE user_id = #{userId} AND is_delete = 0")
    long countByUserId(@Param("userId") Long userId);
}
