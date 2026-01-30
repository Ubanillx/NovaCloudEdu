package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.UserFollow;
import com.novacloudedu.backend.domain.social.repository.UserFollowRepository;
import com.novacloudedu.backend.domain.social.valueobject.UserFollowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserFollowConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserFollowMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserFollowPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 用户关注仓储实现
 */
@Repository
@RequiredArgsConstructor
public class UserFollowRepositoryImpl implements UserFollowRepository {

    private final UserFollowMapper userFollowMapper;
    private final UserFollowConverter userFollowConverter;

    @Override
    public UserFollow save(UserFollow follow) {
        UserFollowPO po = userFollowConverter.toPO(follow);
        if (follow.getId() == null) {
            userFollowMapper.insert(po);
            follow.assignId(new UserFollowId(po.getId()));
        } else {
            userFollowMapper.updateById(po);
        }
        return follow;
    }

    @Override
    public Optional<UserFollow> findById(UserFollowId id) {
        UserFollowPO po = userFollowMapper.selectById(id.value());
        return Optional.ofNullable(userFollowConverter.toDomain(po));
    }

    @Override
    public Optional<UserFollow> findByFollowerAndFollowing(UserId followerId, UserId followingId) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowerId, followerId.value())
                .eq(UserFollowPO::getFollowingId, followingId.value());
        UserFollowPO po = userFollowMapper.selectOne(wrapper);
        return Optional.ofNullable(userFollowConverter.toDomain(po));
    }

    @Override
    public boolean isFollowing(UserId followerId, UserId followingId) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowerId, followerId.value())
                .eq(UserFollowPO::getFollowingId, followingId.value());
        return userFollowMapper.selectCount(wrapper) > 0;
    }

    @Override
    public List<UserFollow> findFollowingsByUserId(UserId userId) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowerId, userId.value())
                .orderByDesc(UserFollowPO::getCreateTime);
        List<UserFollowPO> poList = userFollowMapper.selectList(wrapper);
        return poList.stream().map(userFollowConverter::toDomain).toList();
    }

    @Override
    public FollowPage findFollowingsByUserId(UserId userId, int pageNum, int pageSize) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowerId, userId.value())
                .orderByDesc(UserFollowPO::getCreateTime);

        Page<UserFollowPO> page = new Page<>(pageNum, pageSize);
        Page<UserFollowPO> resultPage = userFollowMapper.selectPage(page, wrapper);

        List<UserFollow> follows = resultPage.getRecords().stream()
                .map(userFollowConverter::toDomain)
                .toList();

        return new FollowPage(follows, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public List<UserFollow> findFollowersByUserId(UserId userId) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowingId, userId.value())
                .orderByDesc(UserFollowPO::getCreateTime);
        List<UserFollowPO> poList = userFollowMapper.selectList(wrapper);
        return poList.stream().map(userFollowConverter::toDomain).toList();
    }

    @Override
    public FollowPage findFollowersByUserId(UserId userId, int pageNum, int pageSize) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowingId, userId.value())
                .orderByDesc(UserFollowPO::getCreateTime);

        Page<UserFollowPO> page = new Page<>(pageNum, pageSize);
        Page<UserFollowPO> resultPage = userFollowMapper.selectPage(page, wrapper);

        List<UserFollow> follows = resultPage.getRecords().stream()
                .map(userFollowConverter::toDomain)
                .toList();

        return new FollowPage(follows, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public List<UserId> findFollowingUserIds(UserId userId) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowerId, userId.value())
                .select(UserFollowPO::getFollowingId);
        List<UserFollowPO> poList = userFollowMapper.selectList(wrapper);
        return poList.stream().map(po -> new UserId(po.getFollowingId())).toList();
    }

    @Override
    public void delete(UserFollow follow) {
        if (follow.getId() != null) {
            userFollowMapper.deleteById(follow.getId().value());
        }
    }

    @Override
    public long countFollowings(UserId userId) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowerId, userId.value());
        return userFollowMapper.selectCount(wrapper);
    }

    @Override
    public long countFollowers(UserId userId) {
        LambdaQueryWrapper<UserFollowPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFollowPO::getFollowingId, userId.value());
        return userFollowMapper.selectCount(wrapper);
    }
}
