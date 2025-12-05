package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.FriendRequest;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 好友申请仓储接口
 */
public interface FriendRequestRepository {

    /**
     * 保存好友申请
     */
    FriendRequest save(FriendRequest friendRequest);

    /**
     * 根据ID查找
     */
    Optional<FriendRequest> findById(FriendRequestId id);

    /**
     * 查找两个用户之间的待处理申请
     */
    Optional<FriendRequest> findPendingRequest(UserId senderId, UserId receiverId);

    /**
     * 查找用户收到的好友申请列表
     */
    List<FriendRequest> findByReceiverId(UserId receiverId, FriendRequestStatus status);

    /**
     * 查找用户发送的好友申请列表
     */
    List<FriendRequest> findBySenderId(UserId senderId, FriendRequestStatus status);

    /**
     * 分页查询收到的好友申请
     */
    FriendRequestPage findReceivedRequests(UserId receiverId, FriendRequestStatus status, int pageNum, int pageSize);

    /**
     * 分页查询发送的好友申请
     */
    FriendRequestPage findSentRequests(UserId senderId, FriendRequestStatus status, int pageNum, int pageSize);

    /**
     * 检查是否存在待处理的申请
     */
    boolean existsPendingRequest(UserId senderId, UserId receiverId);

    /**
     * 好友申请分页结果
     */
    record FriendRequestPage(List<FriendRequest> requests, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
