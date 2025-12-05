package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.social.entity.FriendRequest;
import com.novacloudedu.backend.domain.social.repository.FriendRequestRepository;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.FriendRequestConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.FriendRequestMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.FriendRequestPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 好友申请仓储实现
 */
@Repository
@RequiredArgsConstructor
public class FriendRequestRepositoryImpl implements FriendRequestRepository {

    private final FriendRequestMapper friendRequestMapper;
    private final FriendRequestConverter friendRequestConverter;

    @Override
    public FriendRequest save(FriendRequest friendRequest) {
        FriendRequestPO po = friendRequestConverter.toPO(friendRequest);
        if (friendRequest.getId() == null) {
            friendRequestMapper.insert(po);
            friendRequest.assignId(FriendRequestId.of(po.getId()));
        } else {
            friendRequestMapper.updateById(po);
        }
        return friendRequest;
    }

    @Override
    public Optional<FriendRequest> findById(FriendRequestId id) {
        FriendRequestPO po = friendRequestMapper.selectById(id.value());
        return Optional.ofNullable(friendRequestConverter.toDomain(po));
    }

    @Override
    public Optional<FriendRequest> findPendingRequest(UserId senderId, UserId receiverId) {
        LambdaQueryWrapper<FriendRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRequestPO::getSenderId, senderId.value())
                .eq(FriendRequestPO::getReceiverId, receiverId.value())
                .eq(FriendRequestPO::getStatus, FriendRequestStatus.PENDING.getValue());
        FriendRequestPO po = friendRequestMapper.selectOne(wrapper);
        return Optional.ofNullable(friendRequestConverter.toDomain(po));
    }

    @Override
    public List<FriendRequest> findByReceiverId(UserId receiverId, FriendRequestStatus status) {
        LambdaQueryWrapper<FriendRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRequestPO::getReceiverId, receiverId.value());
        if (status != null) {
            wrapper.eq(FriendRequestPO::getStatus, status.getValue());
        }
        wrapper.orderByDesc(FriendRequestPO::getCreateTime);
        List<FriendRequestPO> poList = friendRequestMapper.selectList(wrapper);
        return poList.stream().map(friendRequestConverter::toDomain).toList();
    }

    @Override
    public List<FriendRequest> findBySenderId(UserId senderId, FriendRequestStatus status) {
        LambdaQueryWrapper<FriendRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRequestPO::getSenderId, senderId.value());
        if (status != null) {
            wrapper.eq(FriendRequestPO::getStatus, status.getValue());
        }
        wrapper.orderByDesc(FriendRequestPO::getCreateTime);
        List<FriendRequestPO> poList = friendRequestMapper.selectList(wrapper);
        return poList.stream().map(friendRequestConverter::toDomain).toList();
    }

    @Override
    public FriendRequestPage findReceivedRequests(UserId receiverId, FriendRequestStatus status, int pageNum, int pageSize) {
        LambdaQueryWrapper<FriendRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRequestPO::getReceiverId, receiverId.value());
        if (status != null) {
            wrapper.eq(FriendRequestPO::getStatus, status.getValue());
        }
        wrapper.orderByDesc(FriendRequestPO::getCreateTime);

        Page<FriendRequestPO> page = new Page<>(pageNum, pageSize);
        Page<FriendRequestPO> resultPage = friendRequestMapper.selectPage(page, wrapper);

        List<FriendRequest> requests = resultPage.getRecords().stream()
                .map(friendRequestConverter::toDomain)
                .toList();

        return new FriendRequestPage(requests, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public FriendRequestPage findSentRequests(UserId senderId, FriendRequestStatus status, int pageNum, int pageSize) {
        LambdaQueryWrapper<FriendRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRequestPO::getSenderId, senderId.value());
        if (status != null) {
            wrapper.eq(FriendRequestPO::getStatus, status.getValue());
        }
        wrapper.orderByDesc(FriendRequestPO::getCreateTime);

        Page<FriendRequestPO> page = new Page<>(pageNum, pageSize);
        Page<FriendRequestPO> resultPage = friendRequestMapper.selectPage(page, wrapper);

        List<FriendRequest> requests = resultPage.getRecords().stream()
                .map(friendRequestConverter::toDomain)
                .toList();

        return new FriendRequestPage(requests, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public boolean existsPendingRequest(UserId senderId, UserId receiverId) {
        LambdaQueryWrapper<FriendRequestPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FriendRequestPO::getSenderId, senderId.value())
                .eq(FriendRequestPO::getReceiverId, receiverId.value())
                .eq(FriendRequestPO::getStatus, FriendRequestStatus.PENDING.getValue());
        return friendRequestMapper.selectCount(wrapper) > 0;
    }
}
