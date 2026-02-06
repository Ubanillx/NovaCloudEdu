package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiChatMessagePO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * AI聊天消息Mapper
 */
@Mapper
public interface AiChatMessageMapper extends BaseMapper<AiChatMessagePO> {

    @Select("SELECT * FROM ai_chat_message WHERE session_id = #{sessionId} AND is_delete = 0 ORDER BY create_time ASC")
    List<AiChatMessagePO> findBySessionId(@Param("sessionId") Long sessionId);

    @Select("SELECT * FROM ai_chat_message WHERE session_id = #{sessionId} AND is_summarized = 0 AND is_delete = 0 ORDER BY create_time ASC")
    List<AiChatMessagePO> findUnsummarizedBySessionId(@Param("sessionId") Long sessionId);

    @Select("SELECT * FROM ai_chat_message WHERE session_id = #{sessionId} AND is_delete = 0 ORDER BY create_time DESC LIMIT #{limit}")
    List<AiChatMessagePO> findRecentBySessionId(@Param("sessionId") Long sessionId, @Param("limit") int limit);

    @Update("<script>UPDATE ai_chat_message SET is_summarized = 1 WHERE id IN " +
            "<foreach collection='ids' item='id' open='(' separator=',' close=')'>#{id}</foreach>" +
            "</script>")
    void markAsSummarized(@Param("ids") List<Long> ids);

    @Update("UPDATE ai_chat_message SET is_delete = 1 WHERE session_id = #{sessionId}")
    void deleteBySessionId(@Param("sessionId") Long sessionId);
}
