package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.repository.ChatGroupMemberRepository;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.GroupRole;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ChatGroupMemberConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ChatGroupMemberMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ChatGroupMemberPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 群成员仓储实现
 */
@Repository
@RequiredArgsConstructor
public class ChatGroupMemberRepositoryImpl implements ChatGroupMemberRepository {

    private final ChatGroupMemberMapper memberMapper;
    private final ChatGroupMemberConverter converter;

    @Override
    public ChatGroupMember save(ChatGroupMember member) {
        ChatGroupMemberPO po = converter.toPO(member);
        memberMapper.insert(po);
        member.assignId(po.getId());
        return member;
    }

    @Override
    public void update(ChatGroupMember member) {
        ChatGroupMemberPO po = converter.toPO(member);
        memberMapper.updateById(po);
    }

    @Override
    public Optional<ChatGroupMember> findById(Long id) {
        ChatGroupMemberPO po = memberMapper.selectById(id);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public Optional<ChatGroupMember> findByGroupIdAndUserId(GroupId groupId, UserId userId) {
        LambdaQueryWrapper<ChatGroupMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupMemberPO::getGroupId, groupId.value())
               .eq(ChatGroupMemberPO::getUserId, userId.value());
        ChatGroupMemberPO po = memberMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<ChatGroupMember> findByGroupId(GroupId groupId) {
        LambdaQueryWrapper<ChatGroupMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupMemberPO::getGroupId, groupId.value())
               .orderByAsc(ChatGroupMemberPO::getJoinTime);
        return memberMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public MemberPage findByGroupId(GroupId groupId, int pageNum, int pageSize) {
        Page<ChatGroupMemberPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<ChatGroupMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupMemberPO::getGroupId, groupId.value())
               .orderByAsc(ChatGroupMemberPO::getJoinTime);
        Page<ChatGroupMemberPO> result = memberMapper.selectPage(page, wrapper);
        
        List<ChatGroupMember> members = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new MemberPage(members, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public List<ChatGroupMember> findByUserId(UserId userId) {
        LambdaQueryWrapper<ChatGroupMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupMemberPO::getUserId, userId.value())
               .orderByDesc(ChatGroupMemberPO::getJoinTime);
        return memberMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public boolean isMember(GroupId groupId, UserId userId) {
        LambdaQueryWrapper<ChatGroupMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupMemberPO::getGroupId, groupId.value())
               .eq(ChatGroupMemberPO::getUserId, userId.value());
        return memberMapper.selectCount(wrapper) > 0;
    }

    @Override
    public List<ChatGroupMember> findAdmins(GroupId groupId) {
        LambdaQueryWrapper<ChatGroupMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupMemberPO::getGroupId, groupId.value())
               .in(ChatGroupMemberPO::getRole, GroupRole.ADMIN.getCode(), GroupRole.OWNER.getCode());
        return memberMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public int countByGroupId(GroupId groupId) {
        LambdaQueryWrapper<ChatGroupMemberPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChatGroupMemberPO::getGroupId, groupId.value());
        return Math.toIntExact(memberMapper.selectCount(wrapper));
    }

    @Override
    public void delete(Long id) {
        memberMapper.deleteById(id);
    }

    @Override
    public void deleteByGroupId(GroupId groupId) {
        memberMapper.deleteByGroupId(groupId.value());
    }
}
