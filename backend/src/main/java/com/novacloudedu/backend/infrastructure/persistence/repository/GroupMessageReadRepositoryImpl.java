package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.social.entity.GroupMessageRead;
import com.novacloudedu.backend.domain.social.repository.GroupMessageReadRepository;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.GroupMessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.GroupMessageReadConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.GroupMessageReadMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupMessageReadPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 群消息已读记录仓储实现
 */
@Repository
@RequiredArgsConstructor
public class GroupMessageReadRepositoryImpl implements GroupMessageReadRepository {

    private final GroupMessageReadMapper readMapper;
    private final GroupMessageReadConverter converter;

    @Override
    public GroupMessageRead save(GroupMessageRead read) {
        GroupMessageReadPO po = converter.toPO(read);
        readMapper.insert(po);
        read.assignId(po.getId());
        return read;
    }

    @Override
    public void saveAll(List<GroupMessageRead> reads) {
        for (GroupMessageRead read : reads) {
            save(read);
        }
    }

    @Override
    public Optional<GroupMessageRead> findByMessageIdAndUserId(GroupMessageId messageId, UserId userId) {
        LambdaQueryWrapper<GroupMessageReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupMessageReadPO::getMessageId, messageId.value())
               .eq(GroupMessageReadPO::getUserId, userId.value());
        GroupMessageReadPO po = readMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public boolean hasRead(GroupMessageId messageId, UserId userId) {
        LambdaQueryWrapper<GroupMessageReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupMessageReadPO::getMessageId, messageId.value())
               .eq(GroupMessageReadPO::getUserId, userId.value());
        return readMapper.selectCount(wrapper) > 0;
    }

    @Override
    public List<GroupMessageRead> findByMessageId(GroupMessageId messageId) {
        LambdaQueryWrapper<GroupMessageReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupMessageReadPO::getMessageId, messageId.value());
        return readMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public int countByMessageId(GroupMessageId messageId) {
        LambdaQueryWrapper<GroupMessageReadPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupMessageReadPO::getMessageId, messageId.value());
        return Math.toIntExact(readMapper.selectCount(wrapper));
    }

    @Override
    public int countUnreadMessages(GroupId groupId, UserId userId) {
        return readMapper.countUnreadMessages(groupId.value(), userId.value());
    }

    @Override
    public void markAllAsRead(GroupId groupId, UserId userId, GroupMessageId upToMessageId) {
        readMapper.markAllAsRead(groupId.value(), userId.value(), upToMessageId.value());
    }
}
