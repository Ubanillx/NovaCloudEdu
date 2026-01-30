package com.novacloudedu.backend.interfaces.rest.social;

import com.novacloudedu.backend.application.service.UserFollowApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.social.repository.UserFollowRepository;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.FollowPageResponse;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.FollowStatsResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

/**
 * 用户关注控制器
 */
@RestController
@RequestMapping("/api/follow")
@RequiredArgsConstructor
@Tag(name = "用户关注", description = "用户关注/取关、关注列表、粉丝列表等功能")
public class UserFollowController {

    private final UserFollowApplicationService followService;

    @PostMapping("/{targetUserId}")
    @Operation(summary = "关注用户")
    public BaseResponse<Void> follow(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long targetUserId) {
        followService.follow(userId, targetUserId);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{targetUserId}")
    @Operation(summary = "取消关注")
    public BaseResponse<Void> unfollow(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long targetUserId) {
        followService.unfollow(userId, targetUserId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{targetUserId}/toggle")
    @Operation(summary = "切换关注状态")
    public BaseResponse<Boolean> toggleFollow(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long targetUserId) {
        boolean result = followService.toggleFollow(userId, targetUserId);
        return ResultUtils.success(result);
    }

    @GetMapping("/check/{targetUserId}")
    @Operation(summary = "检查是否已关注")
    public BaseResponse<Boolean> isFollowing(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long targetUserId) {
        boolean result = followService.isFollowing(userId, targetUserId);
        return ResultUtils.success(result);
    }

    @GetMapping("/followings")
    @Operation(summary = "获取我的关注列表")
    public BaseResponse<FollowPageResponse> getMyFollowings(
            @AuthenticationPrincipal Long userId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        UserFollowRepository.FollowPage page = followService.getFollowings(userId, pageNum, pageSize);
        return ResultUtils.success(FollowPageResponse.from(page, true));
    }

    @GetMapping("/followers")
    @Operation(summary = "获取我的粉丝列表")
    public BaseResponse<FollowPageResponse> getMyFollowers(
            @AuthenticationPrincipal Long userId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        UserFollowRepository.FollowPage page = followService.getFollowers(userId, pageNum, pageSize);
        return ResultUtils.success(FollowPageResponse.from(page, false));
    }

    @GetMapping("/user/{targetUserId}/followings")
    @Operation(summary = "获取指定用户的关注列表")
    public BaseResponse<FollowPageResponse> getUserFollowings(
            @PathVariable Long targetUserId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        UserFollowRepository.FollowPage page = followService.getFollowings(targetUserId, pageNum, pageSize);
        return ResultUtils.success(FollowPageResponse.from(page, true));
    }

    @GetMapping("/user/{targetUserId}/followers")
    @Operation(summary = "获取指定用户的粉丝列表")
    public BaseResponse<FollowPageResponse> getUserFollowers(
            @PathVariable Long targetUserId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        UserFollowRepository.FollowPage page = followService.getFollowers(targetUserId, pageNum, pageSize);
        return ResultUtils.success(FollowPageResponse.from(page, false));
    }

    @GetMapping("/stats")
    @Operation(summary = "获取我的关注统计")
    public BaseResponse<FollowStatsResponse> getMyFollowStats(@AuthenticationPrincipal Long userId) {
        UserFollowApplicationService.FollowStats stats = followService.getFollowStats(userId);
        return ResultUtils.success(FollowStatsResponse.from(stats));
    }

    @GetMapping("/user/{targetUserId}/stats")
    @Operation(summary = "获取指定用户的关注统计")
    public BaseResponse<FollowStatsResponse> getUserFollowStats(@PathVariable Long targetUserId) {
        UserFollowApplicationService.FollowStats stats = followService.getFollowStats(targetUserId);
        return ResultUtils.success(FollowStatsResponse.from(stats));
    }
}
