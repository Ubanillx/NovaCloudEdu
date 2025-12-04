package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserAccount;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * 用户仓储实现
 */
@Repository
@RequiredArgsConstructor
public class UserRepositoryImpl implements UserRepository {

    private final UserMapper userMapper;
    private final UserConverter userConverter;

    @Override
    public User save(User user) {
        UserPO po = userConverter.toPO(user);
        if (user.getId() == null) {
            // 新增
            userMapper.insert(po);
            user.assignId(UserId.of(po.getId()));
        } else {
            // 更新
            userMapper.updateById(po);
        }
        return user;
    }

    @Override
    public List<User> saveAll(List<User> users) {
        List<User> result = new ArrayList<>();
        for (User user : users) {
            result.add(save(user));
        }
        return result;
    }

    @Override
    public Optional<User> findById(UserId id) {
        UserPO po = userMapper.selectById(id.value());
        return Optional.ofNullable(userConverter.toDomain(po));
    }

    @Override
    public Optional<User> findByAccount(UserAccount account) {
        LambdaQueryWrapper<UserPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserPO::getUserAccount, account.value());
        UserPO po = userMapper.selectOne(wrapper);
        return Optional.ofNullable(userConverter.toDomain(po));
    }

    @Override
    public boolean existsByAccount(UserAccount account) {
        LambdaQueryWrapper<UserPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserPO::getUserAccount, account.value());
        return userMapper.selectCount(wrapper) > 0;
    }

    @Override
    public UserPage findByCondition(UserQueryCondition condition) {
        LambdaQueryWrapper<UserPO> wrapper = new LambdaQueryWrapper<>();
        
        // 模糊查询条件
        if (StringUtils.hasText(condition.userName())) {
            wrapper.like(UserPO::getUserName, condition.userName());
        }
        if (StringUtils.hasText(condition.userAccount())) {
            wrapper.like(UserPO::getUserAccount, condition.userAccount());
        }
        if (StringUtils.hasText(condition.userPhone())) {
            wrapper.like(UserPO::getUserPhone, condition.userPhone());
        }
        if (StringUtils.hasText(condition.userEmail())) {
            wrapper.like(UserPO::getUserEmail, condition.userEmail());
        }
        if (StringUtils.hasText(condition.role())) {
            wrapper.eq(UserPO::getUserRole, condition.role());
        }
        if (condition.banned() != null) {
            wrapper.eq(UserPO::getIsBan, condition.banned() ? 1 : 0);
        }
        
        wrapper.orderByDesc(UserPO::getCreateTime);
        
        Page<UserPO> page = new Page<>(condition.pageNum(), condition.pageSize());
        Page<UserPO> resultPage = userMapper.selectPage(page, wrapper);
        
        List<User> users = resultPage.getRecords().stream()
                .map(userConverter::toDomain)
                .toList();
        
        return new UserPage(users, resultPage.getTotal(), condition.pageNum(), condition.pageSize());
    }

    @Override
    public List<User> findByIds(List<UserId> ids) {
        if (ids == null || ids.isEmpty()) {
            return List.of();
        }
        List<Long> idValues = ids.stream().map(UserId::value).toList();
        List<UserPO> poList = userMapper.selectBatchIds(idValues);
        return poList.stream()
                .map(userConverter::toDomain)
                .toList();
    }

    @Override
    public void updateBanStatus(List<UserId> ids, boolean banned) {
        if (ids == null || ids.isEmpty()) {
            return;
        }
        List<Long> idValues = ids.stream().map(UserId::value).toList();
        LambdaUpdateWrapper<UserPO> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(UserPO::getId, idValues)
                .set(UserPO::getIsBan, banned ? 1 : 0)
                .set(UserPO::getUpdateTime, LocalDateTime.now());
        userMapper.update(null, wrapper);
    }
}
