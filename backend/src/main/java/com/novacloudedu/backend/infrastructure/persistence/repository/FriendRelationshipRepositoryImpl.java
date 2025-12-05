package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.FriendRelationship;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository;
import com.novacloudedu.backend.domain.social.valueobject.FriendRelationshipId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRelationshipStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.FriendRelationshipConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.FriendRelationshipMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.FriendRelationshipPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 好友关系仓储实现
 */
@Repository
@RequiredArgsConstructor
public class FriendRelationshipRepositoryImpl implements FriendRelationshipRepository {

    private final FriendRelationshipMapper friendRelationshipMapper;
    private final FriendRelationshipConverter friendRelationshipConverter;

    @Override
    public FriendRelationship save(FriendRelationship relationship) {
        FriendRelationshipPO po = friendRelationshipConverter.toPO(relationship);
        if (relationship.getId() == null) {
            friendRelationshipMapper.insert(po);
            relationship.assignId(FriendRelationshipId.of(po.getId()));
        } else {
            friendRelationshipMapper.updateById(po);
        }
        return relationship;
    }

    @Override
    public Optional<FriendRelationship> findById(FriendRelationshipId id) {
        FriendRelationshipPO po = friendRelationshipMapper.selectById(id.value());
        return Optional.ofNullable(friendRelationshipConverter.toDomain(po));
    }

    @Override
    public Optional<FriendRelationship> findByUserIds(UserId userId1, UserId userId2) {
        // 保证 userId1 < userId2
        Long id1 = Math.min(userId1.value(), userId2.value());
        Long id2 = Math.max(userId1.value(), userId2.value());

        LambdaQueryWrapper<FriendRelationshipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRelationshipPO::getUserId1, id1)
                .eq(FriendRelationshipPO::getUserId2, id2);
        FriendRelationshipPO po = friendRelationshipMapper.selectOne(wrapper);
        return Optional.ofNullable(friendRelationshipConverter.toDomain(po));
    }

    @Override
    public boolean areFriends(UserId userId1, UserId userId2) {
        Long id1 = Math.min(userId1.value(), userId2.value());
        Long id2 = Math.max(userId1.value(), userId2.value());

        LambdaQueryWrapper<FriendRelationshipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRelationshipPO::getUserId1, id1)
                .eq(FriendRelationshipPO::getUserId2, id2)
                .eq(FriendRelationshipPO::getStatus, FriendRelationshipStatus.ACCEPTED.getValue());
        return friendRelationshipMapper.selectCount(wrapper) > 0;
    }

    @Override
    public List<FriendRelationship> findFriendsByUserId(UserId userId) {
        LambdaQueryWrapper<FriendRelationshipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w.eq(FriendRelationshipPO::getUserId1, userId.value())
                        .or()
                        .eq(FriendRelationshipPO::getUserId2, userId.value()))
                .eq(FriendRelationshipPO::getStatus, FriendRelationshipStatus.ACCEPTED.getValue())
                .orderByDesc(FriendRelationshipPO::getCreateTime);
        List<FriendRelationshipPO> poList = friendRelationshipMapper.selectList(wrapper);
        return poList.stream().map(friendRelationshipConverter::toDomain).toList();
    }

    @Override
    public FriendPage findFriendsByUserId(UserId userId, int pageNum, int pageSize) {
        LambdaQueryWrapper<FriendRelationshipPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w.eq(FriendRelationshipPO::getUserId1, userId.value())
                        .or()
                        .eq(FriendRelationshipPO::getUserId2, userId.value()))
                .eq(FriendRelationshipPO::getStatus, FriendRelationshipStatus.ACCEPTED.getValue())
                .orderByDesc(FriendRelationshipPO::getCreateTime);

        Page<FriendRelationshipPO> page = new Page<>(pageNum, pageSize);
        Page<FriendRelationshipPO> resultPage = friendRelationshipMapper.selectPage(page, wrapper);

        List<FriendRelationship> friends = resultPage.getRecords().stream()
                .map(friendRelationshipConverter::toDomain)
                .toList();

        return new FriendPage(friends, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public void delete(FriendRelationship relationship) {
        if (relationship.getId() != null) {
            friendRelationshipMapper.deleteById(relationship.getId().value());
        }
    }
}
