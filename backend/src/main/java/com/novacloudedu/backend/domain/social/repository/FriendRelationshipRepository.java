package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.FriendRelationship;
import com.novacloudedu.backend.domain.social.valueobject.FriendRelationshipId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 好友关系仓储接口
 */
public interface FriendRelationshipRepository {

    /**
     * 保存好友关系
     */
    FriendRelationship save(FriendRelationship relationship);

    /**
     * 根据ID查找
     */
    Optional<FriendRelationship> findById(FriendRelationshipId id);

    /**
     * 查找两个用户之间的好友关系
     */
    Optional<FriendRelationship> findByUserIds(UserId userId1, UserId userId2);

    /**
     * 检查两个用户是否已是好友
     */
    boolean areFriends(UserId userId1, UserId userId2);

    /**
     * 获取用户的好友列表
     */
    List<FriendRelationship> findFriendsByUserId(UserId userId);

    /**
     * 分页获取用户的好友列表
     */
    FriendPage findFriendsByUserId(UserId userId, int pageNum, int pageSize);

    /**
     * 删除好友关系
     */
    void delete(FriendRelationship relationship);

    /**
     * 好友分页结果
     */
    record FriendPage(List<FriendRelationship> friends, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
