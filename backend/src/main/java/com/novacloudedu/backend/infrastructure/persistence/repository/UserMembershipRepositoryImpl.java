package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.membership.repository.UserMembershipRepository;
import com.novacloudedu.backend.domain.membership.valueobject.MembershipStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserMembershipConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserMembershipMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserMembershipPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserMembershipRepositoryImpl implements UserMembershipRepository {

    private final UserMembershipMapper userMembershipMapper;
    private final UserMembershipConverter userMembershipConverter;

    @Override
    public UserMembership save(UserMembership membership) {
        UserMembershipPO po = userMembershipConverter.toPO(membership);
        if (po.getId() == null) {
            userMembershipMapper.insert(po);
            membership.assignId(po.getId());
        } else {
            userMembershipMapper.updateById(po);
        }
        return membership;
    }

    @Override
    public Optional<UserMembership> findById(Long id) {
        UserMembershipPO po = userMembershipMapper.selectById(id);
        return Optional.ofNullable(po).map(userMembershipConverter::toDomain);
    }

    @Override
    public Optional<UserMembership> findByOrderNo(String orderNo) {
        LambdaQueryWrapper<UserMembershipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserMembershipPO::getOrderNo, orderNo);
        UserMembershipPO po = userMembershipMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userMembershipConverter::toDomain);
    }

    @Override
    public Optional<UserMembership> findActiveByUserId(UserId userId) {
        LambdaQueryWrapper<UserMembershipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserMembershipPO::getUserId, userId.value())
                .eq(UserMembershipPO::getStatus, MembershipStatus.ACTIVE.getCode())
                .and(w -> w.isNull(UserMembershipPO::getExpireTime)
                        .or()
                        .gt(UserMembershipPO::getExpireTime, LocalDateTime.now()))
                .orderByDesc(UserMembershipPO::getCreateTime)
                .last("LIMIT 1");
        UserMembershipPO po = userMembershipMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userMembershipConverter::toDomain);
    }

    @Override
    public Optional<UserMembership> findLatestByUserId(UserId userId) {
        LambdaQueryWrapper<UserMembershipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserMembershipPO::getUserId, userId.value())
                .orderByAsc(UserMembershipPO::getStatus)
                .orderByDesc(UserMembershipPO::getCreateTime)
                .last("LIMIT 1");
        UserMembershipPO po = userMembershipMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userMembershipConverter::toDomain);
    }

    @Override
    public List<UserMembership> findByUserId(UserId userId) {
        LambdaQueryWrapper<UserMembershipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserMembershipPO::getUserId, userId.value())
                .orderByDesc(UserMembershipPO::getCreateTime);
        return userMembershipMapper.selectList(wrapper).stream()
                .map(userMembershipConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserMembership> findByStatus(MembershipStatus status, int page, int size) {
        Page<UserMembershipPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserMembershipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserMembershipPO::getStatus, status.getCode())
                .orderByDesc(UserMembershipPO::getCreateTime);
        Page<UserMembershipPO> result = userMembershipMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userMembershipConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByStatus(MembershipStatus status) {
        LambdaQueryWrapper<UserMembershipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserMembershipPO::getStatus, status.getCode());
        return userMembershipMapper.selectCount(wrapper);
    }

    @Override
    public List<UserMembership> findExpiredActive() {
        LambdaQueryWrapper<UserMembershipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserMembershipPO::getStatus, MembershipStatus.ACTIVE.getCode())
                .isNotNull(UserMembershipPO::getExpireTime)
                .lt(UserMembershipPO::getExpireTime, LocalDateTime.now());
        return userMembershipMapper.selectList(wrapper).stream()
                .map(userMembershipConverter::toDomain)
                .collect(Collectors.toList());
    }
}
