package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.repository.GroupMessageRepository;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.GroupMessageId;
import com.novacloudedu.backend.infrastructure.persistence.converter.GroupMessageConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.GroupMessageMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupMessagePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 群消息仓储实现
 */
@Repository
@RequiredArgsConstructor
public class GroupMessageRepositoryImpl implements GroupMessageRepository {

    private final GroupMessageMapper messageMapper;
    private final GroupMessageConverter converter;

    @Override
    public GroupMessage save(GroupMessage message) {
        GroupMessagePO po = converter.toPO(message);
        messageMapper.insert(po);
        message.assignId(GroupMessageId.of(po.getId()));
        return message;
    }

    @Override
    public Optional<GroupMessage> findById(GroupMessageId id) {
        GroupMessagePO po = messageMapper.selectById(id.value());
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public MessagePage findByGroupId(GroupId groupId, int pageNum, int pageSize) {
        Page<GroupMessagePO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<GroupMessagePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupMessagePO::getGroupId, groupId.value())
               .orderByDesc(GroupMessagePO::getId);
        Page<GroupMessagePO> result = messageMapper.selectPage(page, wrapper);

        List<GroupMessage> messages = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new MessagePage(messages, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public List<GroupMessage> findByGroupIdBeforeMessage(GroupId groupId, GroupMessageId beforeId, int limit) {
        return messageMapper.findBeforeMessage(groupId.value(), beforeId.value(), limit).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public List<GroupMessage> findLatestByGroupId(GroupId groupId, int limit) {
        LambdaQueryWrapper<GroupMessagePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupMessagePO::getGroupId, groupId.value())
               .orderByDesc(GroupMessagePO::getId)
               .last("LIMIT " + limit);
        return messageMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public void delete(GroupMessageId id) {
        messageMapper.deleteById(id.value());
    }
}
