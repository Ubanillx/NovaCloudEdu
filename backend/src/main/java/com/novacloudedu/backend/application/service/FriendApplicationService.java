package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.social.command.DeleteFriendCommand;
import com.novacloudedu.backend.application.social.command.HandleFriendRequestCommand;
import com.novacloudedu.backend.application.social.command.SendFriendRequestCommand;
import com.novacloudedu.backend.application.social.query.FriendListQuery;
import com.novacloudedu.backend.application.social.query.FriendRequestListQuery;
import com.novacloudedu.backend.application.social.query.SearchUserQuery;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.social.entity.FriendRelationship;
import com.novacloudedu.backend.domain.social.entity.FriendRequest;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository.FriendPage;
import com.novacloudedu.backend.domain.social.repository.FriendRequestRepository;
import com.novacloudedu.backend.domain.social.repository.FriendRequestRepository.FriendRequestPage;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestStatus;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserPage;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserQueryCondition;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 好友应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class FriendApplicationService {

    private final FriendRequestRepository friendRequestRepository;
    private final FriendRelationshipRepository friendRelationshipRepository;
    private final UserRepository userRepository;

    /**
     * 搜索用户（添加好友前搜索）
     */
    @Transactional(readOnly = true)
    public UserPage searchUsers(SearchUserQuery query) {
        UserQueryCondition condition = UserQueryCondition.of(
                query.keyword(), // 按用户名搜索
                query.keyword(), // 按账号搜索
                null,
                null,
                null,
                false, // 不搜索被封禁的用户
                query.pageNum(),
                query.pageSize()
        );
        return userRepository.findByCondition(condition);
    }

    /**
     * 发送好友申请
     */
    @Transactional
    public Long sendFriendRequest(SendFriendRequestCommand command) {
        UserId currentUserId = getCurrentUserId();
        UserId receiverId = UserId.of(command.receiverId());

        // 1. 不能向自己发送申请
        if (currentUserId.equals(receiverId)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "不能向自己发送好友申请");
        }

        // 2. 检查目标用户是否存在
        userRepository.findById(receiverId)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST, "目标用户不存在"));

        // 3. 检查是否已是好友
        if (friendRelationshipRepository.areFriends(currentUserId, receiverId)) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "已经是好友关系");
        }

        // 4. 检查是否已有待处理的申请
        if (friendRequestRepository.existsPendingRequest(currentUserId, receiverId)) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "已有待处理的好友申请");
        }

        // 5. 检查对方是否已向我发送过申请（如果有，直接成为好友）
        var reverseRequest = friendRequestRepository.findPendingRequest(receiverId, currentUserId);
        if (reverseRequest.isPresent()) {
            // 自动接受对方的申请
            FriendRequest request = reverseRequest.get();
            request.accept();
            friendRequestRepository.save(request);

            // 建立好友关系
            FriendRelationship relationship = FriendRelationship.create(currentUserId, receiverId);
            friendRelationshipRepository.save(relationship);
            log.info("互相申请，自动成为好友: {} <-> {}", currentUserId.value(), receiverId.value());
            return request.getId().value();
        }

        // 6. 创建好友申请
        FriendRequest request = FriendRequest.create(currentUserId, receiverId, command.message());
        friendRequestRepository.save(request);
        log.info("发送好友申请: {} -> {}", currentUserId.value(), receiverId.value());
        return request.getId().value();
    }

    /**
     * 获取收到的好友申请列表
     */
    @Transactional(readOnly = true)
    public FriendRequestPage getReceivedRequests(FriendRequestListQuery query) {
        UserId currentUserId = getCurrentUserId();
        FriendRequestStatus status = query.status() != null && !query.status().isBlank()
                ? FriendRequestStatus.fromValue(query.status())
                : null;
        return friendRequestRepository.findReceivedRequests(currentUserId, status, query.pageNum(), query.pageSize());
    }

    /**
     * 获取发送的好友申请列表
     */
    @Transactional(readOnly = true)
    public FriendRequestPage getSentRequests(FriendRequestListQuery query) {
        UserId currentUserId = getCurrentUserId();
        FriendRequestStatus status = query.status() != null && !query.status().isBlank()
                ? FriendRequestStatus.fromValue(query.status())
                : null;
        return friendRequestRepository.findSentRequests(currentUserId, status, query.pageNum(), query.pageSize());
    }

    /**
     * 处理好友申请（接受/拒绝）
     */
    @Transactional
    public void handleFriendRequest(HandleFriendRequestCommand command) {
        UserId currentUserId = getCurrentUserId();
        FriendRequestId requestId = FriendRequestId.of(command.requestId());

        // 1. 查找申请
        FriendRequest request = friendRequestRepository.findById(requestId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "好友申请不存在"));

        // 2. 检查是否是接收者
        if (!request.getReceiverId().equals(currentUserId)) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR, "无权处理此申请");
        }

        // 3. 检查申请状态
        if (!request.isPending()) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "该申请已被处理");
        }

        if (command.accept()) {
            // 接受申请
            request.accept();
            friendRequestRepository.save(request);

            // 建立好友关系
            FriendRelationship relationship = FriendRelationship.create(
                    request.getSenderId(),
                    request.getReceiverId()
            );
            friendRelationshipRepository.save(relationship);
            log.info("接受好友申请，成为好友: {} <-> {}", request.getSenderId().value(), request.getReceiverId().value());
        } else {
            // 拒绝申请
            request.reject();
            friendRequestRepository.save(request);
            log.info("拒绝好友申请: {} -> {}", request.getSenderId().value(), request.getReceiverId().value());
        }
    }

    /**
     * 获取好友列表
     */
    @Transactional(readOnly = true)
    public FriendPage getFriendList(FriendListQuery query) {
        UserId currentUserId = getCurrentUserId();
        return friendRelationshipRepository.findFriendsByUserId(currentUserId, query.pageNum(), query.pageSize());
    }

    /**
     * 获取好友详细信息列表（包含用户信息）
     */
    @Transactional(readOnly = true)
    public List<User> getFriendUserList() {
        UserId currentUserId = getCurrentUserId();
        List<FriendRelationship> relationships = friendRelationshipRepository.findFriendsByUserId(currentUserId);
        
        List<UserId> friendUserIds = relationships.stream()
                .map(r -> r.getOtherUserId(currentUserId))
                .toList();
        
        return userRepository.findByIds(friendUserIds);
    }

    /**
     * 删除好友
     */
    @Transactional
    public void deleteFriend(DeleteFriendCommand command) {
        UserId currentUserId = getCurrentUserId();
        UserId friendId = UserId.of(command.friendId());

        FriendRelationship relationship = friendRelationshipRepository.findByUserIds(currentUserId, friendId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "好友关系不存在"));

        friendRelationshipRepository.delete(relationship);
        log.info("删除好友: {} <-> {}", currentUserId.value(), friendId.value());
    }

    /**
     * 检查是否是好友
     */
    @Transactional(readOnly = true)
    public boolean isFriend(Long targetUserId) {
        UserId currentUserId = getCurrentUserId();
        return friendRelationshipRepository.areFriends(currentUserId, UserId.of(targetUserId));
    }

    /**
     * 获取当前登录用户ID
     */
    private UserId getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }

        Object principal = authentication.getPrincipal();
        if (principal instanceof Long userId) {
            return UserId.of(userId);
        }

        throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
    }
}
