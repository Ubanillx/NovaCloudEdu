package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.repository.ChatGroupRepository;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ChatGroupConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ChatGroupMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ChatGroupPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 群聊仓储实现
 */
@Repository
@RequiredArgsConstructor
public class ChatGroupRepositoryImpl implements ChatGroupRepository {

    private final ChatGroupMapper chatGroupMapper;
    private final ChatGroupConverter converter;

    @Override
    public ChatGroup save(ChatGroup group) {
        ChatGroupPO po = converter.toPO(group);
        chatGroupMapper.insert(po);
        group.assignId(GroupId.of(po.getId()));
        return group;
    }

    @Override
    public void update(ChatGroup group) {
        ChatGroupPO po = converter.toPO(group);
        chatGroupMapper.updateById(po);
    }

    @Override
    public Optional<ChatGroup> findById(GroupId id) {
        ChatGroupPO po = chatGroupMapper.selectById(id.value());
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<ChatGroup> findByOwnerId(UserId ownerId) {
        LambdaQueryWrapper<ChatGroupPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupPO::getOwnerId, ownerId.value())
               .orderByDesc(ChatGroupPO::getCreateTime);
        return chatGroupMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public GroupPage findAll(int pageNum, int pageSize) {
        Page<ChatGroupPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<ChatGroupPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(ChatGroupPO::getCreateTime);
        Page<ChatGroupPO> result = chatGroupMapper.selectPage(page, wrapper);
        
        List<ChatGroup> groups = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new GroupPage(groups, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public GroupPage searchByName(String keyword, int pageNum, int pageSize) {
        Page<ChatGroupPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<ChatGroupPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(ChatGroupPO::getGroupName, keyword)
               .orderByDesc(ChatGroupPO::getCreateTime);
        Page<ChatGroupPO> result = chatGroupMapper.selectPage(page, wrapper);
        
        List<ChatGroup> groups = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new GroupPage(groups, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public void delete(GroupId id) {
        chatGroupMapper.deleteById(id.value());
    }
}
