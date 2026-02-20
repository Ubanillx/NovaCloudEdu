package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.ai.entity.AiChatSession;
import com.novacloudedu.backend.domain.ai.repository.AiChatSessionRepository;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiChatSessionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiChatSessionPO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * AI聊天会话仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class AiChatSessionRepositoryImpl implements AiChatSessionRepository {

    private final AiChatSessionMapper mapper;

    @Override
    public AiChatSession save(AiChatSession session) {
        AiChatSessionPO po = toPO(session);

        if (po.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setUpdateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
        } else {
            po.setUpdateTime(LocalDateTime.now());
            mapper.updateById(po);
        }

        return toDomain(po);
    }

    @Override
    public Optional<AiChatSession> findById(AiChatSessionId id) {
        AiChatSessionPO po = mapper.selectById(id.value());
        if (po == null || po.getIsDelete() == 1) {
            return Optional.empty();
        }
        return Optional.of(toDomain(po));
    }

    @Override
    public List<AiChatSession> findByUserId(UserId userId, int page, int size) {
        int offset = page * size;
        List<AiChatSessionPO> pos = mapper.findByUserId(userId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        return mapper.countByUserId(userId.value());
    }

    @Override
    public void delete(AiChatSessionId id) {
        mapper.deleteById(id.value());
    }

    private AiChatSessionPO toPO(AiChatSession session) {
        AiChatSessionPO po = new AiChatSessionPO();
        if (session.getId() != null) {
            po.setId(session.getId().value());
        }
        po.setUserId(session.getUserId().value());
        po.setAssistantId(session.getAssistantId());
        po.setTitle(session.getTitle());
        po.setMemorySummary(session.getMemorySummary());
        po.setMessageCount(session.getMessageCount());
        return po;
    }

    private AiChatSession toDomain(AiChatSessionPO po) {
        return AiChatSession.reconstruct(
                AiChatSessionId.of(po.getId()),
                UserId.of(po.getUserId()),
                po.getAssistantId(),
                po.getTitle(),
                po.getMemorySummary(),
                po.getMessageCount() != null ? po.getMessageCount() : 0,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
