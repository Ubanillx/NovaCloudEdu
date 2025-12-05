package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.repository.PrivateMessageRepository;
import com.novacloudedu.backend.domain.social.valueobject.MessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PrivateMessageConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PrivateMessageMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PrivateMessagePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 私聊消息仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PrivateMessageRepositoryImpl implements PrivateMessageRepository {

    private final PrivateMessageMapper privateMessageMapper;
    private final PrivateMessageConverter privateMessageConverter;

    @Override
    public PrivateMessage save(PrivateMessage message) {
        PrivateMessagePO po = privateMessageConverter.toPO(message);
        privateMessageMapper.insert(po);
        message.assignId(MessageId.of(po.getId()));
        return message;
    }

    @Override
    public Optional<PrivateMessage> findById(MessageId id) {
        PrivateMessagePO po = privateMessageMapper.selectById(id.value());
        if (po == null || po.getIsDelete() == 1) {
            return Optional.empty();
        }
        return Optional.of(privateMessageConverter.toDomain(po));
    }

    @Override
    public MessagePage findBetweenUsers(UserId userId1, UserId userId2, int page, int size) {
        LambdaQueryWrapper<PrivateMessagePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w
                .and(inner -> inner
                        .eq(PrivateMessagePO::getSenderId, userId1.value())
                        .eq(PrivateMessagePO::getReceiverId, userId2.value()))
                .or(inner -> inner
                        .eq(PrivateMessagePO::getSenderId, userId2.value())
                        .eq(PrivateMessagePO::getReceiverId, userId1.value()))
        );
        wrapper.eq(PrivateMessagePO::getIsDelete, 0);
        wrapper.orderByDesc(PrivateMessagePO::getCreateTime);

        Page<PrivateMessagePO> pageResult = privateMessageMapper.selectPage(new Page<>(page, size), wrapper);
        List<PrivateMessage> messages = pageResult.getRecords().stream()
                .map(privateMessageConverter::toDomain)
                .toList();

        return new MessagePage(messages, pageResult.getTotal(), page, size);
    }

    @Override
    public List<PrivateMessage> findBetweenUsersBefore(UserId userId1, UserId userId2, MessageId beforeId, int limit) {
        LambdaQueryWrapper<PrivateMessagePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w
                .and(inner -> inner
                        .eq(PrivateMessagePO::getSenderId, userId1.value())
                        .eq(PrivateMessagePO::getReceiverId, userId2.value()))
                .or(inner -> inner
                        .eq(PrivateMessagePO::getSenderId, userId2.value())
                        .eq(PrivateMessagePO::getReceiverId, userId1.value()))
        );
        wrapper.eq(PrivateMessagePO::getIsDelete, 0);
        if (beforeId != null) {
            wrapper.lt(PrivateMessagePO::getId, beforeId.value());
        }
        wrapper.orderByDesc(PrivateMessagePO::getCreateTime);
        wrapper.last("LIMIT " + limit);

        return privateMessageMapper.selectList(wrapper).stream()
                .map(privateMessageConverter::toDomain)
                .toList();
    }

    @Override
    public void markAsRead(List<MessageId> messageIds) {
        if (messageIds.isEmpty()) {
            return;
        }
        List<Long> ids = messageIds.stream().map(MessageId::value).toList();
        privateMessageMapper.markAsRead(ids);
    }

    @Override
    public void markAllAsReadBetweenUsers(UserId senderId, UserId receiverId) {
        privateMessageMapper.markAllAsReadBetweenUsers(senderId.value(), receiverId.value());
    }

    @Override
    public int countUnreadMessages(UserId receiverId, UserId senderId) {
        LambdaQueryWrapper<PrivateMessagePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PrivateMessagePO::getReceiverId, receiverId.value())
                .eq(PrivateMessagePO::getSenderId, senderId.value())
                .eq(PrivateMessagePO::getIsRead, 0)
                .eq(PrivateMessagePO::getIsDelete, 0);
        return Math.toIntExact(privateMessageMapper.selectCount(wrapper));
    }
}
