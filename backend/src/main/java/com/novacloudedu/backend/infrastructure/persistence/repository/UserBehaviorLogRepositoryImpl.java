package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.recommendation.entity.UserBehaviorLog;
import com.novacloudedu.backend.domain.recommendation.repository.UserBehaviorLogRepository;
import com.novacloudedu.backend.domain.recommendation.valueobject.BehaviorType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserBehaviorLogConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserBehaviorLogMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserBehaviorLogPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserBehaviorLogRepositoryImpl implements UserBehaviorLogRepository {

    private final UserBehaviorLogMapper userBehaviorLogMapper;
    private final UserBehaviorLogConverter userBehaviorLogConverter;

    @Override
    public UserBehaviorLog save(UserBehaviorLog log) {
        UserBehaviorLogPO po = userBehaviorLogConverter.toPO(log);
        userBehaviorLogMapper.insert(po);
        log.assignId(po.getId());
        return log;
    }

    @Override
    public List<UserBehaviorLog> findByUserId(UserId userId, int page, int size) {
        Page<UserBehaviorLogPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserBehaviorLogPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBehaviorLogPO::getUserId, userId.value())
                .orderByDesc(UserBehaviorLogPO::getCreateTime);
        Page<UserBehaviorLogPO> result = userBehaviorLogMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userBehaviorLogConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserBehaviorLog> findByUserIdAndTargetType(UserId userId, TargetType targetType, int page, int size) {
        Page<UserBehaviorLogPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserBehaviorLogPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBehaviorLogPO::getUserId, userId.value())
                .eq(UserBehaviorLogPO::getTargetType, targetType.getCode())
                .orderByDesc(UserBehaviorLogPO::getCreateTime);
        Page<UserBehaviorLogPO> result = userBehaviorLogMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userBehaviorLogConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserBehaviorLog> findByUserIdAndBehaviorType(UserId userId, BehaviorType behaviorType, int page, int size) {
        Page<UserBehaviorLogPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserBehaviorLogPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBehaviorLogPO::getUserId, userId.value())
                .eq(UserBehaviorLogPO::getBehaviorType, behaviorType.getCode())
                .orderByDesc(UserBehaviorLogPO::getCreateTime);
        Page<UserBehaviorLogPO> result = userBehaviorLogMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userBehaviorLogConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserBehaviorLog> findByUserIdAfterTime(UserId userId, LocalDateTime afterTime) {
        LambdaQueryWrapper<UserBehaviorLogPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBehaviorLogPO::getUserId, userId.value())
                .ge(UserBehaviorLogPO::getCreateTime, afterTime)
                .orderByDesc(UserBehaviorLogPO::getCreateTime);
        return userBehaviorLogMapper.selectList(wrapper).stream()
                .map(userBehaviorLogConverter::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<UserBehaviorLogPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserBehaviorLogPO::getUserId, userId.value());
        return userBehaviorLogMapper.selectCount(wrapper);
    }
}
