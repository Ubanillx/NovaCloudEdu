package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.book.entity.AiConversation;
import com.novacloudedu.backend.domain.book.repository.AiConversationRepository;
import com.novacloudedu.backend.domain.book.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.AiConversationMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiConversationPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * AI对话仓储实现
 */
@Repository
@RequiredArgsConstructor
public class AiConversationRepositoryImpl implements AiConversationRepository {

    private final AiConversationMapper mapper;

    @Override
    public AiConversation save(AiConversation conversation) {
        AiConversationPO po = toPO(conversation);
        
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
    public Optional<AiConversation> findById(AiConversationId id) {
        AiConversationPO po = mapper.selectById(id.getValue());
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<AiConversation> findByUserId(UserId userId, int page, int size) {
        int offset = page * size;
        List<AiConversationPO> pos = mapper.findByUserId(userId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<AiConversation> findByUserIdAndBookId(UserId userId, BookId bookId, int page, int size) {
        int offset = page * size;
        List<AiConversationPO> pos = mapper.findByUserIdAndBookId(
                userId.value(), bookId.value(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<AiConversation> findByUserIdAndType(UserId userId, ConversationType type, int page, int size) {
        int offset = page * size;
        List<AiConversationPO> pos = mapper.findByUserIdAndType(
                userId.value(), type.name(), offset, size);
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public void delete(AiConversationId id) {
        mapper.deleteById(id.getValue());
    }

    private AiConversationPO toPO(AiConversation conversation) {
        AiConversationPO po = new AiConversationPO();
        if (conversation.getId() != null) {
            po.setId(conversation.getId().getValue());
        }
        po.setUserId(conversation.getUserId().value());
        po.setBookId(conversation.getBookId().value());
        if (conversation.getChapterId() != null) {
            po.setChapterId(conversation.getChapterId().value());
        }
        po.setConversationType(conversation.getConversationType().name());
        
        // 转换消息列表
        List<Map<String, String>> messages = conversation.getMessages().stream()
                .map(msg -> Map.of(
                        "role", msg.getRole(),
                        "content", msg.getContent(),
                        "timestamp", msg.getTimestamp().toString()
                ))
                .collect(Collectors.toList());
        po.setMessages(messages);
        
        return po;
    }

    private AiConversation toDomain(AiConversationPO po) {
        // 转换消息列表
        List<AiConversation.ConversationMessage> messages = po.getMessages().stream()
                .map(msg -> {
                    AiConversation.ConversationMessage message = AiConversation.ConversationMessage.create(
                            msg.get("role"),
                            msg.get("content")
                    );
                    return message;
                })
                .collect(Collectors.toList());

        return AiConversation.reconstruct(
                AiConversationId.of(po.getId()),
                UserId.of(po.getUserId()),
                BookId.of(po.getBookId()),
                po.getChapterId() != null ? ChapterId.of(po.getChapterId()) : null,
                ConversationType.valueOf(po.getConversationType()),
                messages,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
