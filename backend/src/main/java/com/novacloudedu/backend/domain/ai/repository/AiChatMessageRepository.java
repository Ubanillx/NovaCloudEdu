package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.AiChatMessage;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatMessageId;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;

import java.util.List;

/**
 * AI聊天消息仓储接口
 */
public interface AiChatMessageRepository {

    AiChatMessage save(AiChatMessage message);

    List<AiChatMessage> findBySessionId(AiChatSessionId sessionId);

    /**
     * 获取会话中未被摘要的消息（按时间正序）
     */
    List<AiChatMessage> findUnsummarizedBySessionId(AiChatSessionId sessionId);

    /**
     * 获取会话中最近的N条消息（按时间正序）
     */
    List<AiChatMessage> findRecentBySessionId(AiChatSessionId sessionId, int limit);

    /**
     * 批量标记消息为已摘要
     */
    void markAsSummarized(List<AiChatMessageId> messageIds);

    void deleteBySessionId(AiChatSessionId sessionId);
}
