package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.social.entity.UserFollow;
import com.novacloudedu.backend.domain.social.repository.UserFollowRepository;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户关注应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class UserFollowApplicationService {

    private final UserFollowRepository userFollowRepository;
    private final UserRepository userRepository;

    /**
     * 关注用户
     */
    @Transactional
    public void follow(Long followerId, Long followingId) {
        if (followerId.equals(followingId)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "不能关注自己");
        }

        UserId followerIdVo = new UserId(followerId);
        UserId followingIdVo = new UserId(followingId);

        // 验证被关注用户存在
        userRepository.findById(followingIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        // 检查是否已关注
        if (userFollowRepository.isFollowing(followerIdVo, followingIdVo)) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "已关注该用户");
        }

        UserFollow follow = UserFollow.create(followerIdVo, followingIdVo);
        userFollowRepository.save(follow);

        log.info("关注成功: followerId={}, followingId={}", followerId, followingId);
    }

    /**
     * 取消关注
     */
    @Transactional
    public void unfollow(Long followerId, Long followingId) {
        UserId followerIdVo = new UserId(followerId);
        UserId followingIdVo = new UserId(followingId);

        UserFollow follow = userFollowRepository.findByFollowerAndFollowing(followerIdVo, followingIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "未关注该用户"));

        userFollowRepository.delete(follow);

        log.info("取消关注成功: followerId={}, followingId={}", followerId, followingId);
    }

    /**
     * 切换关注状态
     */
    @Transactional
    public boolean toggleFollow(Long followerId, Long followingId) {
        if (followerId.equals(followingId)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "不能关注自己");
        }

        UserId followerIdVo = new UserId(followerId);
        UserId followingIdVo = new UserId(followingId);

        // 验证被关注用户存在
        userRepository.findById(followingIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        boolean isFollowing = userFollowRepository.isFollowing(followerIdVo, followingIdVo);

        if (isFollowing) {
            // 取消关注
            UserFollow follow = userFollowRepository.findByFollowerAndFollowing(followerIdVo, followingIdVo)
                    .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "关注关系不存在"));
            userFollowRepository.delete(follow);
            log.info("取消关注: followerId={}, followingId={}", followerId, followingId);
            return false;
        } else {
            // 关注
            UserFollow follow = UserFollow.create(followerIdVo, followingIdVo);
            userFollowRepository.save(follow);
            log.info("关注成功: followerId={}, followingId={}", followerId, followingId);
            return true;
        }
    }

    /**
     * 检查是否已关注
     */
    public boolean isFollowing(Long followerId, Long followingId) {
        return userFollowRepository.isFollowing(new UserId(followerId), new UserId(followingId));
    }

    /**
     * 获取关注列表（我关注的人）
     */
    public UserFollowRepository.FollowPage getFollowings(Long userId, int pageNum, int pageSize) {
        return userFollowRepository.findFollowingsByUserId(new UserId(userId), pageNum, pageSize);
    }

    /**
     * 获取粉丝列表（关注我的人）
     */
    public UserFollowRepository.FollowPage getFollowers(Long userId, int pageNum, int pageSize) {
        return userFollowRepository.findFollowersByUserId(new UserId(userId), pageNum, pageSize);
    }

    /**
     * 获取用户关注的所有用户ID
     */
    public List<UserId> getFollowingUserIds(Long userId) {
        return userFollowRepository.findFollowingUserIds(new UserId(userId));
    }

    /**
     * 获取关注数
     */
    public long getFollowingCount(Long userId) {
        return userFollowRepository.countFollowings(new UserId(userId));
    }

    /**
     * 获取粉丝数
     */
    public long getFollowerCount(Long userId) {
        return userFollowRepository.countFollowers(new UserId(userId));
    }

    /**
     * 获取用户关注统计
     */
    public FollowStats getFollowStats(Long userId) {
        long followingCount = userFollowRepository.countFollowings(new UserId(userId));
        long followerCount = userFollowRepository.countFollowers(new UserId(userId));
        return new FollowStats(followingCount, followerCount);
    }

    /**
     * 关注统计
     */
    public record FollowStats(long followingCount, long followerCount) {}
}
