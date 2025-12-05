package com.novacloudedu.backend.interfaces.rest.social;

import com.novacloudedu.backend.application.service.FriendApplicationService;
import com.novacloudedu.backend.application.social.query.FriendListQuery;
import com.novacloudedu.backend.application.social.query.FriendRequestListQuery;
import com.novacloudedu.backend.application.social.query.SearchUserQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.social.entity.FriendRequest;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository.FriendPage;
import com.novacloudedu.backend.domain.social.repository.FriendRequestRepository.FriendRequestPage;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserPage;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.rest.social.assembler.FriendAssembler;
import com.novacloudedu.backend.interfaces.rest.social.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 好友管理控制器
 */
@Tag(name = "好友管理", description = "好友相关接口")
@RestController
@RequestMapping("/api/friend")
@RequiredArgsConstructor
@Slf4j
public class FriendController {

    private final FriendApplicationService friendApplicationService;
    private final FriendAssembler friendAssembler;
    private final UserRepository userRepository;

    // ==================== 搜索用户 ====================

    /**
     * 搜索用户（添加好友前搜索）
     */
    @Operation(summary = "搜索用户", description = "根据关键词搜索用户，用于添加好友")
    @PostMapping("/search")
    public BaseResponse<SearchUserPageResponse> searchUsers(@RequestBody SearchUserRequestDTO request) {
        SearchUserQuery query = friendAssembler.toSearchQuery(request);
        UserPage page = friendApplicationService.searchUsers(query);

        // 构建响应，包含好友状态和申请状态
        SearchUserPageResponse response = friendAssembler.toSearchUserPageResponse(
                page,
                userId -> friendApplicationService.isFriend(userId),
                userId -> false // 简化处理，可以后续扩展
        );

        return ResultUtils.success(response);
    }

    // ==================== 好友申请 ====================

    /**
     * 发送好友申请
     */
    @Operation(summary = "发送好友申请", description = "向指定用户发送好友申请")
    @PostMapping("/request/send")
    public BaseResponse<Long> sendFriendRequest(@RequestBody @Valid SendFriendRequestDTO request) {
        Long requestId = friendApplicationService.sendFriendRequest(
                friendAssembler.toSendCommand(request)
        );
        return ResultUtils.success(requestId);
    }

    /**
     * 获取收到的好友申请列表
     */
    @Operation(summary = "获取收到的好友申请", description = "获取当前用户收到的好友申请列表")
    @PostMapping("/request/received")
    public BaseResponse<FriendRequestPageResponse> getReceivedRequests(@RequestBody FriendRequestListDTO request) {
        FriendRequestListQuery query = friendAssembler.toRequestListQuery(request);
        FriendRequestPage page = friendApplicationService.getReceivedRequests(query);

        // 获取相关用户信息
        Map<Long, User> userMap = getUserMapFromRequests(page.requests());

        return ResultUtils.success(friendAssembler.toRequestPageResponse(page, userMap));
    }

    /**
     * 获取发送的好友申请列表
     */
    @Operation(summary = "获取发送的好友申请", description = "获取当前用户发送的好友申请列表")
    @PostMapping("/request/sent")
    public BaseResponse<FriendRequestPageResponse> getSentRequests(@RequestBody FriendRequestListDTO request) {
        FriendRequestListQuery query = friendAssembler.toRequestListQuery(request);
        FriendRequestPage page = friendApplicationService.getSentRequests(query);

        // 获取相关用户信息
        Map<Long, User> userMap = getUserMapFromRequests(page.requests());

        return ResultUtils.success(friendAssembler.toRequestPageResponse(page, userMap));
    }

    /**
     * 处理好友申请（接受/拒绝）
     */
    @Operation(summary = "处理好友申请", description = "接受或拒绝好友申请")
    @PostMapping("/request/handle")
    public BaseResponse<Boolean> handleFriendRequest(@RequestBody @Valid HandleFriendRequestDTO request) {
        friendApplicationService.handleFriendRequest(
                friendAssembler.toHandleCommand(request)
        );
        return ResultUtils.success(true);
    }

    // ==================== 好友列表 ====================

    /**
     * 获取好友列表
     */
    @Operation(summary = "获取好友列表", description = "获取当前用户的好友列表")
    @PostMapping("/list")
    public BaseResponse<FriendPageResponse> getFriendList(@RequestBody FriendListRequestDTO request) {
        FriendListQuery query = friendAssembler.toFriendListQuery(request);
        FriendPage page = friendApplicationService.getFriendList(query);

        // 获取当前用户ID
        UserId currentUserId = UserId.of(getCurrentUserId());

        // 获取好友用户信息
        List<UserId> friendUserIds = page.friends().stream()
                .map(r -> r.getOtherUserId(currentUserId))
                .toList();
        Map<Long, User> userMap = getUserMapByIds(friendUserIds);

        return ResultUtils.success(friendAssembler.toFriendPageResponse(page, currentUserId, userMap));
    }

    /**
     * 获取全部好友（简化版）
     */
    @Operation(summary = "获取全部好友", description = "获取当前用户的全部好友列表")
    @GetMapping("/all")
    public BaseResponse<List<FriendResponse>> getAllFriends() {
        List<User> friends = friendApplicationService.getFriendUserList();
        
        List<FriendResponse> response = friends.stream()
                .map(user -> new FriendResponse(
                        user.getId().value(),
                        user.getAccount().value(),
                        user.getUserName(),
                        user.getUserAvatar(),
                        user.getUserProfile(),
                        null
                ))
                .toList();

        return ResultUtils.success(response);
    }

    /**
     * 删除好友
     */
    @Operation(summary = "删除好友", description = "删除指定好友")
    @DeleteMapping("/{friendId}")
    public BaseResponse<Boolean> deleteFriend(@PathVariable Long friendId) {
        friendApplicationService.deleteFriend(
                friendAssembler.toDeleteCommand(friendId)
        );
        return ResultUtils.success(true);
    }

    /**
     * 检查是否是好友
     */
    @Operation(summary = "检查好友关系", description = "检查当前用户与目标用户是否是好友")
    @GetMapping("/check/{userId}")
    public BaseResponse<Boolean> checkFriendship(@PathVariable Long userId) {
        boolean isFriend = friendApplicationService.isFriend(userId);
        return ResultUtils.success(isFriend);
    }

    // ==================== 辅助方法 ====================

    private Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof Long userId) {
            return userId;
        }
        return null;
    }

    private Map<Long, User> getUserMapFromRequests(List<FriendRequest> requests) {
        List<UserId> userIds = requests.stream()
                .flatMap(r -> List.of(r.getSenderId(), r.getReceiverId()).stream())
                .distinct()
                .toList();
        List<User> users = userRepository.findByIds(userIds);
        return users.stream().collect(Collectors.toMap(u -> u.getId().value(), u -> u));
    }

    private Map<Long, User> getUserMapByIds(List<UserId> userIds) {
        if (userIds.isEmpty()) {
            return Map.of();
        }
        List<User> users = userRepository.findByIds(userIds);
        return users.stream().collect(Collectors.toMap(u -> u.getId().value(), u -> u));
    }
}
