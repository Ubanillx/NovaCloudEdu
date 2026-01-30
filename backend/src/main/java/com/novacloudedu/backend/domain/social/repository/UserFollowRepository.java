package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.UserFollow;
import com.novacloudedu.backend.domain.social.valueobject.UserFollowId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 用户关注仓储接口
 */
public interface UserFollowRepository {

    /**
     * 保存关注关系
     */
    UserFollow save(UserFollow follow);

    /**
     * 根据ID查找
     */
    Optional<UserFollow> findById(UserFollowId id);

    /**
     * 查找关注关系
     */
    Optional<UserFollow> findByFollowerAndFollowing(UserId followerId, UserId followingId);

    /**
     * 检查是否已关注
     */
    boolean isFollowing(UserId followerId, UserId followingId);

    /**
     * 获取用户的关注列表（我关注的人）
     */
    List<UserFollow> findFollowingsByUserId(UserId userId);

    /**
     * 分页获取用户的关注列表
     */
    FollowPage findFollowingsByUserId(UserId userId, int pageNum, int pageSize);

    /**
     * 获取用户的粉丝列表（关注我的人）
     */
    List<UserFollow> findFollowersByUserId(UserId userId);

    /**
     * 分页获取用户的粉丝列表
     */
    FollowPage findFollowersByUserId(UserId userId, int pageNum, int pageSize);

    /**
     * 获取用户关注的所有用户ID列表
     */
    List<UserId> findFollowingUserIds(UserId userId);

    /**
     * 删除关注关系
     */
    void delete(UserFollow follow);

    /**
     * 统计关注数
     */
    long countFollowings(UserId userId);

    /**
     * 统计粉丝数
     */
    long countFollowers(UserId userId);

    /**
     * 关注分页结果
     */
    record FollowPage(List<UserFollow> follows, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
