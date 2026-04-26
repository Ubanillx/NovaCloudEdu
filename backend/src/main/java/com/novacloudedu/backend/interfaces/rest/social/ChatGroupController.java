package com.novacloudedu.backend.interfaces.rest.social;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.application.service.ChatGroupApplicationService;
import com.novacloudedu.backend.application.service.GroupChatApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.entity.GroupJoinRequest;
import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.repository.ChatGroupMemberRepository;
import com.novacloudedu.backend.domain.social.valueobject.InviteMode;
import com.novacloudedu.backend.domain.social.valueobject.JoinMode;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.rest.social.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.*;
import com.novacloudedu.backend.exception.BusinessException;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 群聊管理控制器
 */
@RestController
@RequestMapping("/api/groups")
@RequiredArgsConstructor
@Tag(name = "群聊管理", description = "群的创建、加入、审核等功能")
public class ChatGroupController {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private final ChatGroupApplicationService groupService;
    private final GroupChatApplicationService groupChatService;
    private final UserRepository userRepository;

    // ==================== 群管理 ====================

    @PostMapping
    @Operation(summary = "创建群聊")
    public BaseResponse<GroupResponse> createGroup(
            @AuthenticationPrincipal Long userId,
            @Valid @RequestBody CreateGroupRequest request) {
        ChatGroup group = groupService.createGroup(
                userId,
                request.getGroupName(),
                request.getDescription(),
                request.getAvatar(),
                parseJoinMode(request.getJoinMode()),
                parseInviteMode(request.getInviteMode()),
                request.getAnnouncement()
        );
        return ResultUtils.success(GroupResponse.from(group));
    }

    @GetMapping("/{groupId}")
    @Operation(summary = "获取群详情")
    public BaseResponse<GroupResponse> getGroupInfo(@PathVariable Long groupId) {
        ChatGroup group = groupService.getGroupInfo(groupId);
        return ResultUtils.success(GroupResponse.from(group));
    }

    @PutMapping("/{groupId}")
    @Operation(summary = "更新群信息")
    public BaseResponse<Void> updateGroupInfo(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @Valid @RequestBody UpdateGroupRequest request) {
        groupService.updateGroupInfo(groupId, userId, 
                request.getGroupName(), request.getDescription(), request.getAvatar());
        return ResultUtils.success(null);
    }

    @PutMapping("/{groupId}/join-mode")
    @Operation(summary = "设置群加入模式", description = "0-自由加入，1-需审批，2-禁止加入")
    public BaseResponse<Void> setJoinMode(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam int mode) {
        groupService.setJoinMode(groupId, userId, parseJoinMode(mode));
        return ResultUtils.success(null);
    }

    @PutMapping("/{groupId}/invite-mode")
    @Operation(summary = "设置群邀请模式", description = "0-所有成员可邀请，1-仅管理员可邀请")
    public BaseResponse<Void> setInviteMode(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam int mode) {
        groupService.setInviteMode(groupId, userId, parseInviteMode(mode));
        return ResultUtils.success(null);
    }

    @PutMapping("/{groupId}/announcement")
    @Operation(summary = "发布群公告")
    public BaseResponse<Void> publishAnnouncement(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestBody(required = false) String announcement) {
        groupService.publishAnnouncement(groupId, userId, normalizeTextBody(announcement));
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{groupId}")
    @Operation(summary = "解散群")
    public BaseResponse<Void> dissolveGroup(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId) {
        groupService.dissolveGroup(groupId, userId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{groupId}/transfer")
    @Operation(summary = "转让群主")
    public BaseResponse<Void> transferOwnership(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam Long newOwnerId) {
        groupService.transferOwnership(groupId, userId, newOwnerId);
        return ResultUtils.success(null);
    }

    // ==================== 成员管理 ====================

    @PostMapping("/{groupId}/join")
    @Operation(summary = "申请加入群")
    public BaseResponse<JoinRequestResponse> applyToJoin(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestBody(required = false) JoinGroupRequest request) {
        String message = request != null ? request.getMessage() : null;
        GroupJoinRequest joinRequest = groupService.applyToJoin(groupId, userId, message);
        
        // 如果是自由加入模式，直接返回成功
        if (joinRequest == null) {
            return ResultUtils.success(null);
        }
        return ResultUtils.success(JoinRequestResponse.from(joinRequest));
    }

    @PostMapping("/{groupId}/invite")
    @Operation(summary = "邀请用户加入群")
    public BaseResponse<Void> inviteMember(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam Long inviteeId) {
        groupService.inviteMember(groupId, userId, inviteeId);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{groupId}/members/{targetUserId}")
    @Operation(summary = "移除成员")
    public BaseResponse<Void> removeMember(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @PathVariable Long targetUserId) {
        groupService.removeMember(groupId, userId, targetUserId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{groupId}/leave")
    @Operation(summary = "退出群")
    public BaseResponse<Void> leaveGroup(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId) {
        groupService.leaveGroup(groupId, userId);
        return ResultUtils.success(null);
    }

    @PutMapping("/{groupId}/members/{targetUserId}/admin")
    @Operation(summary = "设置/取消管理员")
    public BaseResponse<Void> setAdmin(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @PathVariable Long targetUserId,
            @RequestParam boolean isAdmin) {
        groupService.setAdmin(groupId, userId, targetUserId, isAdmin);
        return ResultUtils.success(null);
    }

    // ==================== 申请管理 ====================

    @GetMapping("/{groupId}/requests")
    @Operation(summary = "获取群待审批申请列表")
    public BaseResponse<List<JoinRequestResponse>> getPendingRequests(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId) {
        List<GroupJoinRequest> requests = groupService.getPendingRequests(groupId, userId);
        List<JoinRequestResponse> responses = requests.stream()
                .map(JoinRequestResponse::from)
                .toList();
        return ResultUtils.success(responses);
    }

    @PostMapping("/requests/{requestId}/handle")
    @Operation(summary = "处理加入申请")
    public BaseResponse<Void> handleJoinRequest(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long requestId,
            @Valid @RequestBody HandleJoinRequestDTO request) {
        groupService.handleJoinRequest(requestId, userId, request.getApprove());
        return ResultUtils.success(null);
    }

    // ==================== 查询 ====================

    @GetMapping("/{groupId}/members")
    @Operation(summary = "获取群成员列表")
    public BaseResponse<List<GroupMemberResponse>> getGroupMembers(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId) {
        List<ChatGroupMember> members = groupService.getGroupMembers(groupId, userId);
        List<GroupMemberResponse> responses = members.stream()
                .map(GroupMemberResponse::from)
                .toList();
        return ResultUtils.success(responses);
    }

    @GetMapping("/{groupId}/members/page")
    @Operation(summary = "分页获取群成员")
    public BaseResponse<ChatGroupMemberRepository.MemberPage> getGroupMembersPage(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long groupId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize) {
        return ResultUtils.success(groupService.getGroupMembersPage(groupId, userId, pageNum, pageSize));
    }

    @GetMapping("/my")
    @Operation(summary = "获取我加入的群列表")
    public BaseResponse<List<GroupResponse>> getMyGroups(@AuthenticationPrincipal Long userId) {
        List<ChatGroup> groups = groupService.getUserGroups(userId);
        List<GroupResponse> responses = groups.stream()
                .map(group -> toMyGroupResponse(group, userId))
                .toList();
        return ResultUtils.success(responses);
    }

    private GroupResponse toMyGroupResponse(ChatGroup group, Long userId) {
        GroupResponse response = GroupResponse.from(group);
        List<GroupMessage> latestMessages = groupChatService.getLatestMessages(group.getId().value(), userId, 1);
        if (!latestMessages.isEmpty()) {
            GroupMessage latest = latestMessages.get(0);
            response.setLastMessageSenderId(latest.getSenderId() != null ? latest.getSenderId().value() : null);
            response.setLastMessage(latest.getContent());
            response.setLastMessageType(latest.getType() != null ? latest.getType().getValue() : null);
            response.setLastMessageTime(latest.getCreateTime());
            if (latest.getSenderId() != null) {
                User sender = userRepository.findById(UserId.of(latest.getSenderId().value())).orElse(null);
                response.setLastMessageSenderName(sender != null ? sender.getUserName() : "未知用户");
            }
        }
        response.setUnreadCount(groupChatService.getUnreadCount(group.getId().value(), userId));
        return response;
    }

    @GetMapping("/search")
    @Operation(summary = "搜索群")
    public BaseResponse<GroupPageResponse> searchGroups(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize) {
        return ResultUtils.success(GroupPageResponse.from(groupService.searchGroups(keyword, pageNum, pageSize)));
    }

    private JoinMode parseJoinMode(Integer mode) {
        try {
            return mode == null ? JoinMode.FREE : JoinMode.fromCode(mode);
        } catch (IllegalArgumentException e) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "加入方式不正确");
        }
    }

    private InviteMode parseInviteMode(Integer mode) {
        try {
            return mode == null ? InviteMode.ALL : InviteMode.fromCode(mode);
        } catch (IllegalArgumentException e) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "邀请权限不正确");
        }
    }

    private String normalizeTextBody(String body) {
        if (body == null) {
            return "";
        }
        String trimmed = body.trim();
        if (trimmed.length() >= 2 && trimmed.startsWith("\"") && trimmed.endsWith("\"")) {
            try {
                return OBJECT_MAPPER.readValue(trimmed, String.class);
            } catch (JsonProcessingException ignored) {
                return trimmed.substring(1, trimmed.length() - 1);
            }
        }
        return body;
    }
}
