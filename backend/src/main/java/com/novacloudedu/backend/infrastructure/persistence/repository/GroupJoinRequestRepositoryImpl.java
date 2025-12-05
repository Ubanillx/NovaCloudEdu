package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.GroupJoinRequest;
import com.novacloudedu.backend.domain.social.repository.GroupJoinRequestRepository;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.JoinRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.GroupJoinRequestConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.GroupJoinRequestMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupJoinRequestPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 群申请仓储实现
 */
@Repository
@RequiredArgsConstructor
public class GroupJoinRequestRepositoryImpl implements GroupJoinRequestRepository {

    private final GroupJoinRequestMapper requestMapper;
    private final GroupJoinRequestConverter converter;

    @Override
    public GroupJoinRequest save(GroupJoinRequest request) {
        GroupJoinRequestPO po = converter.toPO(request);
        requestMapper.insert(po);
        request.assignId(po.getId());
        return request;
    }

    @Override
    public void update(GroupJoinRequest request) {
        GroupJoinRequestPO po = converter.toPO(request);
        requestMapper.updateById(po);
    }

    @Override
    public Optional<GroupJoinRequest> findById(Long id) {
        GroupJoinRequestPO po = requestMapper.selectById(id);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public Optional<GroupJoinRequest> findPendingRequest(GroupId groupId, UserId userId) {
        LambdaQueryWrapper<GroupJoinRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupJoinRequestPO::getGroupId, groupId.value())
               .eq(GroupJoinRequestPO::getUserId, userId.value())
               .eq(GroupJoinRequestPO::getStatus, JoinRequestStatus.PENDING.getCode());
        GroupJoinRequestPO po = requestMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<GroupJoinRequest> findByGroupIdAndStatus(GroupId groupId, JoinRequestStatus status) {
        LambdaQueryWrapper<GroupJoinRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupJoinRequestPO::getGroupId, groupId.value())
               .eq(GroupJoinRequestPO::getStatus, status.getCode())
               .orderByDesc(GroupJoinRequestPO::getCreateTime);
        return requestMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public RequestPage findByGroupId(GroupId groupId, int pageNum, int pageSize) {
        Page<GroupJoinRequestPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<GroupJoinRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupJoinRequestPO::getGroupId, groupId.value())
               .orderByDesc(GroupJoinRequestPO::getCreateTime);
        Page<GroupJoinRequestPO> result = requestMapper.selectPage(page, wrapper);
        
        List<GroupJoinRequest> requests = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new RequestPage(requests, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public List<GroupJoinRequest> findByUserId(UserId userId) {
        LambdaQueryWrapper<GroupJoinRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupJoinRequestPO::getUserId, userId.value())
               .orderByDesc(GroupJoinRequestPO::getCreateTime);
        return requestMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public boolean existsPendingRequest(GroupId groupId, UserId userId) {
        LambdaQueryWrapper<GroupJoinRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GroupJoinRequestPO::getGroupId, groupId.value())
               .eq(GroupJoinRequestPO::getUserId, userId.value())
               .eq(GroupJoinRequestPO::getStatus, JoinRequestStatus.PENDING.getCode());
        return requestMapper.selectCount(wrapper) > 0;
    }
}
