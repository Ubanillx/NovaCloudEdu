package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.JoinRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 群申请实体
 */
@Getter
public class GroupJoinRequest {

    private Long id;
    private GroupId groupId;
    private UserId userId;
    private String message;
    private JoinRequestStatus status;
    private UserId handlerId;
    private LocalDateTime handleTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private GroupJoinRequest() {}

    /**
     * 创建群申请
     */
    public static GroupJoinRequest create(GroupId groupId, UserId userId, String message) {
        GroupJoinRequest request = new GroupJoinRequest();
        request.groupId = groupId;
        request.userId = userId;
        request.message = message;
        request.status = JoinRequestStatus.PENDING;
        request.createTime = LocalDateTime.now();
        request.updateTime = LocalDateTime.now();
        return request;
    }

    /**
     * 重建申请（从数据库恢复）
     */
    public static GroupJoinRequest reconstruct(Long id, GroupId groupId, UserId userId, String message,
                                               JoinRequestStatus status, UserId handlerId,
                                               LocalDateTime handleTime, LocalDateTime createTime,
                                               LocalDateTime updateTime) {
        GroupJoinRequest request = new GroupJoinRequest();
        request.id = id;
        request.groupId = groupId;
        request.userId = userId;
        request.message = message;
        request.status = status;
        request.handlerId = handlerId;
        request.handleTime = handleTime;
        request.createTime = createTime;
        request.updateTime = updateTime;
        return request;
    }

    /**
     * 分配ID
     */
    public void assignId(Long id) {
        this.id = id;
    }

    /**
     * 通过申请
     */
    public void approve(UserId handlerId) {
        this.status = JoinRequestStatus.APPROVED;
        this.handlerId = handlerId;
        this.handleTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 拒绝申请
     */
    public void reject(UserId handlerId) {
        this.status = JoinRequestStatus.REJECTED;
        this.handlerId = handlerId;
        this.handleTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 是否待处理
     */
    public boolean isPending() {
        return status == JoinRequestStatus.PENDING;
    }
}
