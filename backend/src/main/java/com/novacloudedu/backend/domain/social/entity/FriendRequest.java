package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.FriendRequestId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 好友申请聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FriendRequest {

    private FriendRequestId id;
    private UserId senderId;
    private UserId receiverId;
    private FriendRequestStatus status;
    private String message;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建好友申请
     */
    public static FriendRequest create(UserId senderId, UserId receiverId, String message) {
        if (senderId.equals(receiverId)) {
            throw new IllegalArgumentException("不能向自己发送好友申请");
        }
        
        FriendRequest request = new FriendRequest();
        request.senderId = senderId;
        request.receiverId = receiverId;
        request.message = message;
        request.status = FriendRequestStatus.PENDING;
        request.createTime = LocalDateTime.now();
        request.updateTime = LocalDateTime.now();
        return request;
    }

    /**
     * 从持久化数据重建
     */
    public static FriendRequest reconstruct(FriendRequestId id, UserId senderId, UserId receiverId,
                                            FriendRequestStatus status, String message,
                                            LocalDateTime createTime, LocalDateTime updateTime) {
        FriendRequest request = new FriendRequest();
        request.id = id;
        request.senderId = senderId;
        request.receiverId = receiverId;
        request.status = status;
        request.message = message;
        request.createTime = createTime;
        request.updateTime = updateTime;
        return request;
    }

    /**
     * 分配ID
     */
    public void assignId(FriendRequestId id) {
        if (this.id != null) {
            throw new IllegalStateException("好友申请ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 接受申请
     */
    public void accept() {
        if (this.status != FriendRequestStatus.PENDING) {
            throw new IllegalStateException("只能处理待处理状态的申请");
        }
        this.status = FriendRequestStatus.ACCEPTED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 拒绝申请
     */
    public void reject() {
        if (this.status != FriendRequestStatus.PENDING) {
            throw new IllegalStateException("只能处理待处理状态的申请");
        }
        this.status = FriendRequestStatus.REJECTED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 是否待处理
     */
    public boolean isPending() {
        return this.status == FriendRequestStatus.PENDING;
    }
}
