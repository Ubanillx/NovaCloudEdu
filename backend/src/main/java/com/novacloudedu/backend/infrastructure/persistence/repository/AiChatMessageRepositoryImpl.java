package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.AiChatMessage;
import com.novacloudedu.backend.domain.ai.repository.AiChatMessageRepository;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatMessageId;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiChatMessageMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiChatMessagePO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * AI聊天消息仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class AiChatMessageRepositoryImpl implements AiChatMessageRepository {

    private final AiChatMessageMapper mapper;
    private final ObjectMapper objectMapper;

    @Override
    public AiChatMessage save(AiChatMessage message) {
        AiChatMessagePO po = toPO(message);

        if (po.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
        } else {
            mapper.updateById(po);
        }

        return toDomain(po);
    }

    @Override
    public List<AiChatMessage> findBySessionId(AiChatSessionId sessionId) {
        List<AiChatMessagePO> pos = mapper.findBySessionId(sessionId.value());
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<AiChatMessage> findUnsummarizedBySessionId(AiChatSessionId sessionId) {
        List<AiChatMessagePO> pos = mapper.findUnsummarizedBySessionId(sessionId.value());
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<AiChatMessage> findRecentBySessionId(AiChatSessionId sessionId, int limit) {
        List<AiChatMessagePO> pos = mapper.findRecentBySessionId(sessionId.value(), limit);
        // findRecent 是 DESC 排序，需要反转为 ASC
        Collections.reverse(pos);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public void markAsSummarized(List<AiChatMessageId> messageIds) {
        if (messageIds == null || messageIds.isEmpty()) {
            return;
        }
        List<Long> ids = messageIds.stream().map(AiChatMessageId::value).collect(Collectors.toList());
        mapper.markAsSummarized(ids);
    }

    @Override
    public void deleteBySessionId(AiChatSessionId sessionId) {
        mapper.deleteBySessionId(sessionId.value());
    }

    private AiChatMessagePO toPO(AiChatMessage message) {
        AiChatMessagePO po = new AiChatMessagePO();
        if (message.getId() != null) {
            po.setId(message.getId().value());
        }
        po.setSessionId(message.getSessionId().value());
        po.setUserId(message.getUserId().value());
        po.setRole(message.getRole());
        po.setContent(message.getContent());
        po.setAttachments(toJson(message.getAttachments()));
        po.setIsSummarized(message.isSummarized() ? 1 : 0);
        return po;
    }

    private AiChatMessage toDomain(AiChatMessagePO po) {
        return AiChatMessage.reconstruct(
                AiChatMessageId.of(po.getId()),
                AiChatSessionId.of(po.getSessionId()),
                UserId.of(po.getUserId()),
                po.getRole(),
                po.getContent(),
                fromJson(po.getAttachments()),
                po.getIsSummarized() != null && po.getIsSummarized() == 1,
                po.getCreateTime()
        );
    }

    private String toJson(List<String> list) {
        if (list == null || list.isEmpty()) {
            return "[]";
        }
        try {
            return objectMapper.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            log.error("JSON序列化失败", e);
            return "[]";
        }
    }

    private List<String> fromJson(String json) {
        if (json == null || json.isEmpty()) {
            return new ArrayList<>();
        }
        try {
            return objectMapper.readValue(json, new TypeReference<List<String>>() {});
        } catch (JsonProcessingException e) {
            log.error("JSON反序列化失败", e);
            return new ArrayList<>();
        }
    }
}
