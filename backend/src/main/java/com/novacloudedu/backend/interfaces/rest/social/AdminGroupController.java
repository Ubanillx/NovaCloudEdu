package com.novacloudedu.backend.interfaces.rest.social;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.ChatGroupApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.repository.ChatGroupMemberRepository;
import com.novacloudedu.backend.domain.social.repository.ChatGroupRepository;
import com.novacloudedu.backend.interfaces.rest.social.dto.request.UpdateGroupRequest;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.GroupResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 群聊管理控制器（系统管理员）
 * 系统管理员可直接操作任意群聊，无需群成员身份
 */
@RestController
@RequestMapping("/api/admin/groups")
@RequiredArgsConstructor
@Tag(name = "群聊管理（管理员）", description = "系统管理员群聊管理接口")
public class AdminGroupController {

    private final ChatGroupApplicationService groupService;

    // ==================== 查询 ====================

    @GetMapping("/list")
    @Operation(summary = "分页获取所有群列表")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<AdminGroupPageResponse> listGroups(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int pageNum,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int pageSize) {
        ChatGroupRepository.GroupPage page = groupService.adminListGroups(pageNum, pageSize);
        return ResultUtils.success(AdminGroupPageResponse.from(page));
    }

    @GetMapping("/search")
    @Operation(summary = "搜索群")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<AdminGroupPageResponse> searchGroups(
            @RequestParam @Parameter(description = "关键词") String keyword,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int pageNum,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int pageSize) {
        ChatGroupRepository.GroupPage page = groupService.adminSearchGroups(keyword, pageNum, pageSize);
        return ResultUtils.success(AdminGroupPageResponse.from(page));
    }

    @GetMapping("/{groupId}")
    @Operation(summary = "获取群详情")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<GroupResponse> getGroupInfo(
            @PathVariable @Parameter(description = "群ID") Long groupId) {
        ChatGroup group = groupService.getGroupInfo(groupId);
        return ResultUtils.success(GroupResponse.from(group));
    }

    @GetMapping("/{groupId}/members")
    @Operation(summary = "分页获取群成员")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<ChatGroupMemberRepository.MemberPage> getGroupMembers(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int pageNum,
            @RequestParam(defaultValue = "20") @Parameter(description = "每页数量") int pageSize) {
        return ResultUtils.success(groupService.getGroupMembersPage(groupId, pageNum, pageSize));
    }

    // ==================== 操作 ====================

    @PutMapping("/{groupId}")
    @Operation(summary = "更新群信息")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Void> updateGroupInfo(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @Valid @RequestBody UpdateGroupRequest request) {
        groupService.adminUpdateGroupInfo(groupId,
                request.getGroupName(), request.getDescription(), request.getAvatar());
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{groupId}/members/{targetUserId}")
    @Operation(summary = "移除群成员")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Void> removeMember(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @PathVariable @Parameter(description = "目标用户ID") Long targetUserId) {
        groupService.adminRemoveMember(groupId, targetUserId);
        return ResultUtils.success(null);
    }

    @PostMapping("/{groupId}/mute")
    @Operation(summary = "设置群全员禁言")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Void> setMute(
            @PathVariable @Parameter(description = "群ID") Long groupId,
            @RequestParam @Parameter(description = "是否禁言") boolean mute) {
        groupService.adminSetMute(groupId, mute);
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{groupId}")
    @Operation(summary = "解散群")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Void> dissolveGroup(
            @PathVariable @Parameter(description = "群ID") Long groupId) {
        groupService.adminDissolveGroup(groupId);
        return ResultUtils.success(null);
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
