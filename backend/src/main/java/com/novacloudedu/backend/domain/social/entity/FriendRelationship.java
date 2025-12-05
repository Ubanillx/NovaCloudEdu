package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.FriendRelationshipId;
import com.novacloudedu.backend.domain.social.valueobject.FriendRelationshipStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 好友关系聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FriendRelationship {

    private FriendRelationshipId id;
    private UserId userId1;
    private UserId userId2;
    private FriendRelationshipStatus status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建好友关系（接受申请后调用）
     */
    public static FriendRelationship create(UserId userId1, UserId userId2) {
        FriendRelationship relationship = new FriendRelationship();
        // 保证 userId1 < userId2，确保唯一性
        if (userId1.value() < userId2.value()) {
            relationship.userId1 = userId1;
            relationship.userId2 = userId2;
        } else {
            relationship.userId1 = userId2;
            relationship.userId2 = userId1;
        }
        relationship.status = FriendRelationshipStatus.ACCEPTED;
        relationship.createTime = LocalDateTime.now();
        relationship.updateTime = LocalDateTime.now();
        return relationship;
    }

    /**
     * 从持久化数据重建
     */
    public static FriendRelationship reconstruct(FriendRelationshipId id, UserId userId1, UserId userId2,
                                                  FriendRelationshipStatus status,
                                                  LocalDateTime createTime, LocalDateTime updateTime) {
        FriendRelationship relationship = new FriendRelationship();
        relationship.id = id;
        relationship.userId1 = userId1;
        relationship.userId2 = userId2;
        relationship.status = status;
        relationship.createTime = createTime;
        relationship.updateTime = updateTime;
        return relationship;
    }

    /**
     * 分配ID
     */
    public void assignId(FriendRelationshipId id) {
        if (this.id != null) {
            throw new IllegalStateException("好友关系ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 拉黑好友
     */
    public void block() {
        this.status = FriendRelationshipStatus.BLOCKED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 解除拉黑
     */
    public void unblock() {
        this.status = FriendRelationshipStatus.ACCEPTED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 是否为正常好友关系
     */
    public boolean isAccepted() {
        return this.status == FriendRelationshipStatus.ACCEPTED;
    }

    /**
     * 是否被拉黑
     */
    public boolean isBlocked() {
        return this.status == FriendRelationshipStatus.BLOCKED;
    }

    /**
     * 检查某用户是否在此关系中
     */
    public boolean containsUser(UserId userId) {
        return userId1.equals(userId) || userId2.equals(userId);
    }

    /**
     * 获取另一方用户ID
     */
    public UserId getOtherUserId(UserId userId) {
        if (userId1.equals(userId)) {
            return userId2;
        } else if (userId2.equals(userId)) {
            return userId1;
        }
        throw new IllegalArgumentException("用户不在此好友关系中");
    }
}
