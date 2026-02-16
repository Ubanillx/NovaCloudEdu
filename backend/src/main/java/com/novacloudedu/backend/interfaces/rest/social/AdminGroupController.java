package com.novacloudedu.backend.interfaces.rest.social;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.ChatGroupApplicationService;
import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.repository.ChatGroupMemberRepository;
import com.novacloudedu.backend.domain.social.repository.ChatGroupRepository;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import com.novacloudedu.backend.interfaces.rest.social.dto.request.UpdateGroupRequest;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.GroupResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 群聊管理控制器（管理员/教师）
 * 管理员可操作任意群聊；教师只能操作自己作为群主的群聊
 */
@RestController
@RequestMapping("/api/admin/groups")
@RequiredArgsConstructor
@Tag(name = "群聊管理", description = "管理员/教师群聊管理接口")
public class AdminGroupController {

    private final ChatGroupApplicationService groupService;
    private final UserApplicationService userApplicationService;

    // ==================== 查询 ====================

    @GetMapping("/list")
    @Operation(summary = "分页获取群列表")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<AdminGroupPageResponse> listGroups(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int pageNum,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int pageSize) {
        User currentUser = userApplicationService.getCurrentUser();
        ChatGroupRepository.GroupPage page;
        if (currentUser.getRole() == UserRole.ADMIN) {
            page = groupService.adminListGroups(pageNum, pageSize);
        } else {
            page = groupService.teacherListGroups(getLoginUserId(), pageNum, pageSize);
        }
        return ResultUtils.success(AdminGroupPageResponse.from(page));
    }

    @GetMapping("/search")
    @Operation(summary = "搜索群")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<AdminGroupPageResponse> searchGroups(
            @RequestParam @Parameter(description = "关键词") String keyword,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int pageNum,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int pageSize) {
        User currentUser = userApplicationService.getCurrentUser();
        ChatGroupRepository.GroupPage page;
        if (currentUser.getRole() == UserRole.ADMIN) {
            page = groupService.adminSearchGroups(keyword, pageNum, pageSize);
        } else {
            page = groupService.teacherSearchGroups(keyword, getLoginUserId(), pageNum, pageSize);
        }
        return ResultUtils.success(AdminGroupPageResponse.from(page));
    }

    @GetMapping("/{groupId}")
    @Operation(summary = "获取群详情")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<GroupResponse> getGroupInfo(
            @PathVariable @Parameter(description = "群ID") Long groupId) {
        User currentUser = userApplicationService.getCurrentUser();
        ChatGroup group;
        if (currentUser.getRole() == UserRole.ADMIN) {
            group = groupService.getGroupInfo(groupId);
        } else {
            group = groupService.teacherGetGroupInfo(groupId, getLoginUserId());
        }
        return ResultUtils.success(GroupResponse.from(group));
    }

    @GetMapping("/{groupId}/members")
    @Operation(summary = "分页获取群成员")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<ChatGroupMemberRepository.MemberPage> getGroupMembers(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int pageNum,
            @RequestParam(defaultValue = "20") @Parameter(description = "每页数量") int pageSize) {
        User currentUser = userApplicationService.getCurrentUser();
        if (currentUser.getRole() == UserRole.ADMIN) {
            return ResultUtils.success(groupService.getGroupMembersPage(groupId, pageNum, pageSize));
        } else {
            return ResultUtils.success(groupService.teacherGetGroupMembersPage(groupId, getLoginUserId(), pageNum, pageSize));
        }
    }

    // ==================== 操作 ====================

    @PutMapping("/{groupId}")
    @Operation(summary = "更新群信息")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<Void> updateGroupInfo(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @Valid @RequestBody UpdateGroupRequest request) {
        User currentUser = userApplicationService.getCurrentUser();
        if (currentUser.getRole() == UserRole.ADMIN) {
            groupService.adminUpdateGroupInfo(groupId,
                    request.getGroupName(), request.getDescription(), request.getAvatar());
        } else {
            groupService.teacherUpdateGroupInfo(groupId, getLoginUserId(),
                    request.getGroupName(), request.getDescription(), request.getAvatar());
        }
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{groupId}/members/{targetUserId}")
    @Operation(summary = "移除群成员")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<Void> removeMember(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @PathVariable @Parameter(description = "目标用户ID") Long targetUserId) {
        User currentUser = userApplicationService.getCurrentUser();
        if (currentUser.getRole() == UserRole.ADMIN) {
            groupService.adminRemoveMember(groupId, targetUserId);
        } else {
            groupService.teacherRemoveMember(groupId, getLoginUserId(), targetUserId);
        }
        return ResultUtils.success(null);
    }

    @PostMapping("/{groupId}/mute")
    @Operation(summary = "设置群全员禁言")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<Void> setMute(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @RequestParam @Parameter(description = "是否禁言") boolean mute) {
        User currentUser = userApplicationService.getCurrentUser();
        if (currentUser.getRole() == UserRole.ADMIN) {
            groupService.adminSetMute(groupId, mute);
        } else {
            groupService.teacherSetMute(groupId, getLoginUserId(), mute);
        }
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{groupId}")
    @Operation(summary = "解散群")
    @AuthCheck(mustRole = "teacher")
    public BaseResponse<Void> dissolveGroup(
            @PathVariable @Parameter(description = "群ID") Long groupId) {
        User currentUser = userApplicationService.getCurrentUser();
        if (currentUser.getRole() == UserRole.ADMIN) {
            groupService.adminDissolveGroup(groupId);
        } else {
            groupService.teacherDissolveGroup(groupId, getLoginUserId());
        }
        return ResultUtils.success(null);
    }

    // ==================== 辅助方法 ====================

    private Long getLoginUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return Long.parseLong(authentication.getName());
    }

    // ==================== 响应 DTO ====================

    /**
     * 管理员群列表分页响应
     */
    @lombok.Data
    public static class AdminGroupPageResponse {
        private List<GroupResponse> list;
        private long total;
        private int pageNum;
        private int pageSize;
        private int totalPages;

        public static AdminGroupPageResponse from(ChatGroupRepository.GroupPage page) {
            AdminGroupPageResponse resp = new AdminGroupPageResponse();
            resp.setList(page.groups().stream().map(GroupResponse::from).toList());
            resp.setTotal(page.total());
            resp.setPageNum(page.pageNum());
            resp.setPageSize(page.pageSize());
            resp.setTotalPages(page.getTotalPages());
            return resp;
        }
    }
}
