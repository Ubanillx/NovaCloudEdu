package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.AiChatSession;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * AI聊天会话仓储接口
 */
public interface AiChatSessionRepository {

    AiChatSession save(AiChatSession session);

    Optional<AiChatSession> findById(AiChatSessionId id);

    List<AiChatSession> findByUserId(UserId userId, int page, int size);

    long countByUserId(UserId userId);

    void delete(AiChatSessionId id);
}
