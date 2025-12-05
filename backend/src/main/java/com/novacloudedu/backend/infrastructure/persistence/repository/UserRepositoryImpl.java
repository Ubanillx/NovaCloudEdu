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
        
        // 用户名和账号相同时，使用 OR 关系搜索（关键词搜索场景）
        boolean hasUserName = StringUtils.hasText(condition.userName());
        boolean hasUserAccount = StringUtils.hasText(condition.userAccount());
        
        if (hasUserName && hasUserAccount && condition.userName().equals(condition.userAccount())) {
            // 关键词搜索：用户名 OR 账号
            String keyword = condition.userName();
            wrapper.and(w -> w.like(UserPO::getUserName, keyword)
                    .or()
                    .like(UserPO::getUserAccount, keyword));
        } else {
            // 分别搜索（管理后台精确筛选场景）
            if (hasUserName) {
                wrapper.like(UserPO::getUserName, condition.userName());
            }
            if (hasUserAccount) {
                wrapper.like(UserPO::getUserAccount, condition.userAccount());
            }
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
