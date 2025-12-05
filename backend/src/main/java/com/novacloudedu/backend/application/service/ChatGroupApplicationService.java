package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.entity.GroupJoinRequest;
import com.novacloudedu.backend.domain.social.repository.ChatGroupMemberRepository;
import com.novacloudedu.backend.domain.social.repository.ChatGroupRepository;
import com.novacloudedu.backend.domain.social.repository.GroupJoinRequestRepository;
import com.novacloudedu.backend.domain.social.valueobject.*;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 群聊应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ChatGroupApplicationService {

    private final ChatGroupRepository groupRepository;
    private final ChatGroupMemberRepository memberRepository;
    private final GroupJoinRequestRepository requestRepository;
    private final UserRepository userRepository;

    // ==================== 群管理 ====================

    /**
     * 创建群聊
     */
    @Transactional
    public ChatGroup createGroup(Long ownerId, String groupName, String description, String avatar) {
        // 验证用户存在
        userRepository.findById(UserId.of(ownerId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        // 创建群
        ChatGroup group = ChatGroup.create(groupName, UserId.of(ownerId));
        if (description != null) {
            group.updateInfo(groupName, avatar, description);
        }
        ChatGroup savedGroup = groupRepository.save(group);

        // 添加群主为成员
        ChatGroupMember ownerMember = ChatGroupMember.createUserMember(
                savedGroup.getId(), UserId.of(ownerId), GroupRole.OWNER
        );
        memberRepository.save(ownerMember);

        log.info("群聊创建成功: groupId={}, groupName={}, ownerId={}", 
                savedGroup.getId().value(), groupName, ownerId);
        return savedGroup;
    }

    /**
     * 更新群信息
     */
    @Transactional
    public void updateGroupInfo(Long groupId, Long operatorId, String groupName, String description, String avatar) {
        ChatGroup group = getGroupOrThrow(groupId);
        ChatGroupMember operator = getMemberOrThrow(groupId, operatorId);

        // 只有管理员或群主可以修改
        if (!operator.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限修改群信息");
        }

        group.updateInfo(groupName, avatar, description);
        groupRepository.update(group);
        log.info("群信息更新: groupId={}, operator={}", groupId, operatorId);
    }

    /**
     * 设置群加入模式
     */
    @Transactional
    public void setJoinMode(Long groupId, Long operatorId, JoinMode joinMode) {
        ChatGroup group = getGroupOrThrow(groupId);
        ChatGroupMember operator = getMemberOrThrow(groupId, operatorId);

        if (!operator.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限修改群设置");
        }

        group.setJoinMode(joinMode);
        groupRepository.update(group);
    }

    /**
     * 发布群公告
     */
    @Transactional
    public void publishAnnouncement(Long groupId, Long operatorId, String announcement) {
        ChatGroup group = getGroupOrThrow(groupId);
        ChatGroupMember operator = getMemberOrThrow(groupId, operatorId);

        if (!operator.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限发布公告");
        }

        group.publishAnnouncement(announcement);
        groupRepository.update(group);
    }

    /**
     * 解散群
     */
    @Transactional
    public void dissolveGroup(Long groupId, Long operatorId) {
        ChatGroup group = getGroupOrThrow(groupId);

        // 只有群主可以解散
        if (!group.isOwner(UserId.of(operatorId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "只有群主可以解散群");
        }

        // 删除所有成员
        memberRepository.deleteByGroupId(GroupId.of(groupId));
        // 删除群
        group.dissolve();
        groupRepository.update(group);

        log.info("群已解散: groupId={}, operator={}", groupId, operatorId);
    }

    /**
     * 转让群主
     */
    @Transactional
    public void transferOwnership(Long groupId, Long currentOwnerId, Long newOwnerId) {
        ChatGroup group = getGroupOrThrow(groupId);

        if (!group.isOwner(UserId.of(currentOwnerId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "只有群主可以转让群");
        }

        ChatGroupMember currentOwnerMember = getMemberOrThrow(groupId, currentOwnerId);
        ChatGroupMember newOwnerMember = getMemberOrThrow(groupId, newOwnerId);

        // 转让
        group.transferOwnership(UserId.of(newOwnerId));
        groupRepository.update(group);

        // 更新成员角色
        currentOwnerMember.setRole(GroupRole.MEMBER);
        memberRepository.update(currentOwnerMember);

        newOwnerMember.setRole(GroupRole.OWNER);
        memberRepository.update(newOwnerMember);

        log.info("群主已转让: groupId={}, from={}, to={}", groupId, currentOwnerId, newOwnerId);
    }

    // ==================== 成员管理 ====================

    /**
     * 申请加入群
     */
    @Transactional
    public GroupJoinRequest applyToJoin(Long groupId, Long userId, String message) {
        ChatGroup group = getGroupOrThrow(groupId);
        UserId userIdVo = UserId.of(userId);

        // 验证用户存在
        userRepository.findById(userIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        // 检查是否已是成员
        if (memberRepository.isMember(GroupId.of(groupId), userIdVo)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "您已是群成员");
        }

        // 检查群是否已满
        if (group.isFull()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "群成员已满");
        }

        // 检查加入模式
        if (group.getJoinMode() == JoinMode.FORBIDDEN) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "该群禁止加入");
        }

        // 自由加入模式，直接添加成员
        if (group.getJoinMode() == JoinMode.FREE) {
            addMemberInternal(group, userIdVo, GroupRole.MEMBER);
            log.info("用户直接加入群: groupId={}, userId={}", groupId, userId);
            return null;
        }

        // 需要审批模式，检查是否已有待处理申请
        if (requestRepository.existsPendingRequest(GroupId.of(groupId), userIdVo)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "您已提交过申请，请等待审批");
        }

        // 创建申请
        GroupJoinRequest request = GroupJoinRequest.create(GroupId.of(groupId), userIdVo, message);
        GroupJoinRequest savedRequest = requestRepository.save(request);

        log.info("群申请已提交: groupId={}, userId={}", groupId, userId);
        return savedRequest;
    }

    /**
     * 审批加入申请
     */
    @Transactional
    public void handleJoinRequest(Long requestId, Long handlerId, boolean approve) {
        GroupJoinRequest request = requestRepository.findById(requestId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "申请不存在"));

        if (!request.isPending()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "申请已处理");
        }

        ChatGroup group = getGroupOrThrow(request.getGroupId().value());
        ChatGroupMember handler = getMemberOrThrow(request.getGroupId().value(), handlerId);

        // 只有管理员或群主可以审批
        if (!handler.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限审批申请");
        }

        if (approve) {
            // 检查群是否已满
            if (group.isFull()) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR, "群成员已满");
            }

            // 通过申请
            request.approve(UserId.of(handlerId));
            requestRepository.update(request);

            // 添加成员
            addMemberInternal(group, request.getUserId(), GroupRole.MEMBER);

            log.info("群申请已通过: requestId={}, handler={}", requestId, handlerId);
        } else {
            // 拒绝申请
            request.reject(UserId.of(handlerId));
            requestRepository.update(request);

            log.info("群申请已拒绝: requestId={}, handler={}", requestId, handlerId);
        }
    }

    /**
     * 邀请用户加入群
     */
    @Transactional
    public void inviteMember(Long groupId, Long inviterId, Long inviteeId) {
        ChatGroup group = getGroupOrThrow(groupId);
        ChatGroupMember inviter = getMemberOrThrow(groupId, inviterId);

        // 检查邀请权限
        if (group.getInviteMode() == InviteMode.ADMIN_ONLY && !inviter.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "只有管理员可以邀请成员");
        }

        UserId inviteeIdVo = UserId.of(inviteeId);

        // 验证被邀请用户存在
        userRepository.findById(inviteeIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        // 检查是否已是成员
        if (memberRepository.isMember(GroupId.of(groupId), inviteeIdVo)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "用户已是群成员");
        }

        // 检查群是否已满
        if (group.isFull()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "群成员已满");
        }

        // 添加成员
        addMemberInternal(group, inviteeIdVo, GroupRole.MEMBER);

        log.info("邀请成员成功: groupId={}, inviter={}, invitee={}", groupId, inviterId, inviteeId);
    }

    /**
     * 移除成员
     */
    @Transactional
    public void removeMember(Long groupId, Long operatorId, Long targetUserId) {
        ChatGroup group = getGroupOrThrow(groupId);
        ChatGroupMember operator = getMemberOrThrow(groupId, operatorId);
        ChatGroupMember target = getMemberOrThrow(groupId, targetUserId);

        // 不能移除自己
        if (operatorId.equals(targetUserId)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "不能移除自己，请使用退出群功能");
        }

        // 不能移除群主
        if (target.isOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "不能移除群主");
        }

        // 只有管理员或群主可以移除成员
        if (!operator.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限移除成员");
        }

        // 管理员不能移除其他管理员（群主可以）
        if (operator.getRole() == GroupRole.ADMIN && target.getRole() == GroupRole.ADMIN) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "管理员不能移除其他管理员");
        }

        // 移除成员
        target.leave();
        memberRepository.update(target);

        // 更新群成员数
        group.decrementMemberCount();
        groupRepository.update(group);

        log.info("成员已移除: groupId={}, operator={}, target={}", groupId, operatorId, targetUserId);
    }

    /**
     * 退出群
     */
    @Transactional
    public void leaveGroup(Long groupId, Long userId) {
        ChatGroup group = getGroupOrThrow(groupId);
        ChatGroupMember member = getMemberOrThrow(groupId, userId);

        // 群主不能退出，需要先转让或解散
        if (member.isOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "群主不能退出群，请先转让群主或解散群");
        }

        member.leave();
        memberRepository.update(member);

        group.decrementMemberCount();
        groupRepository.update(group);

        log.info("用户退出群: groupId={}, userId={}", groupId, userId);
    }

    /**
     * 设置管理员
     */
    @Transactional
    public void setAdmin(Long groupId, Long operatorId, Long targetUserId, boolean isAdmin) {
        ChatGroup group = getGroupOrThrow(groupId);
        
        // 只有群主可以设置管理员
        if (!group.isOwner(UserId.of(operatorId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "只有群主可以设置管理员");
        }

        ChatGroupMember target = getMemberOrThrow(groupId, targetUserId);

        // 不能设置群主为管理员
        if (target.isOwner()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "不能修改群主的角色");
        }

        target.setRole(isAdmin ? GroupRole.ADMIN : GroupRole.MEMBER);
        memberRepository.update(target);

        log.info("管理员设置: groupId={}, target={}, isAdmin={}", groupId, targetUserId, isAdmin);
    }

    // ==================== 查询 ====================

    /**
     * 获取群详情
     */
    public ChatGroup getGroupInfo(Long groupId) {
        return getGroupOrThrow(groupId);
    }

    /**
     * 获取群成员列表
     */
    public List<ChatGroupMember> getGroupMembers(Long groupId) {
        getGroupOrThrow(groupId);
        return memberRepository.findByGroupId(GroupId.of(groupId));
    }

    /**
     * 分页获取群成员
     */
    public ChatGroupMemberRepository.MemberPage getGroupMembersPage(Long groupId, int pageNum, int pageSize) {
        getGroupOrThrow(groupId);
        return memberRepository.findByGroupId(GroupId.of(groupId), pageNum, pageSize);
    }

    /**
     * 获取用户加入的群列表
     */
    public List<ChatGroup> getUserGroups(Long userId) {
        List<ChatGroupMember> memberships = memberRepository.findByUserId(UserId.of(userId));
        return memberships.stream()
                .map(m -> groupRepository.findById(m.getGroupId()).orElse(null))
                .filter(g -> g != null && !g.isDelete())
                .toList();
    }

    /**
     * 获取群待审批申请列表
     */
    public List<GroupJoinRequest> getPendingRequests(Long groupId, Long operatorId) {
        ChatGroupMember operator = getMemberOrThrow(groupId, operatorId);

        if (!operator.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限查看申请列表");
        }

        return requestRepository.findByGroupIdAndStatus(GroupId.of(groupId), JoinRequestStatus.PENDING);
    }

    /**
     * 搜索群
     */
    public ChatGroupRepository.GroupPage searchGroups(String keyword, int pageNum, int pageSize) {
        return groupRepository.searchByName(keyword, pageNum, pageSize);
    }

    // ==================== 私有方法 ====================

    private ChatGroup getGroupOrThrow(Long groupId) {
        return groupRepository.findById(GroupId.of(groupId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "群不存在"));
    }

    private ChatGroupMember getMemberOrThrow(Long groupId, Long userId) {
        return memberRepository.findByGroupIdAndUserId(GroupId.of(groupId), UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "您不是群成员"));
    }

    private void addMemberInternal(ChatGroup group, UserId userId, GroupRole role) {
        ChatGroupMember member = ChatGroupMember.createUserMember(group.getId(), userId, role);
        memberRepository.save(member);

        group.incrementMemberCount();
        groupRepository.update(group);
    }
}
