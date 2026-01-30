package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.UserFollowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户关注实体
 * 表示一个用户关注另一个用户的关系
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserFollow {

    private UserFollowId id;
    private UserId followerId;    // 关注者（粉丝）
    private UserId followingId;   // 被关注者
    private LocalDateTime createTime;

    /**
     * 创建关注关系
     */
    public static UserFollow create(UserId followerId, UserId followingId) {
        if (followerId.equals(followingId)) {
            throw new IllegalArgumentException("不能关注自己");
        }
        UserFollow follow = new UserFollow();
        follow.followerId = followerId;
        follow.followingId = followingId;
        follow.createTime = LocalDateTime.now();
        return follow;
    }

    /**
     * 从持久化数据重建
     */
    public static UserFollow reconstruct(UserFollowId id, UserId followerId, UserId followingId,
                                         LocalDateTime createTime) {
        UserFollow follow = new UserFollow();
        follow.id = id;
        follow.followerId = followerId;
        follow.followingId = followingId;
        follow.createTime = createTime;
        return follow;
    }

    /**
     * 分配ID
     */
    public void assignId(UserFollowId id) {
        if (this.id != null) {
            throw new IllegalStateException("关注ID已分配，不可重复分配");
        }
        this.id = id;
    }
}
