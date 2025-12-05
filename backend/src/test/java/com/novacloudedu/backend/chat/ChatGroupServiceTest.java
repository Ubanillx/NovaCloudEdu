package com.novacloudedu.backend.chat;

import com.novacloudedu.backend.application.service.ChatGroupApplicationService;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.entity.GroupJoinRequest;
import com.novacloudedu.backend.domain.social.repository.ChatGroupMemberRepository;
import com.novacloudedu.backend.domain.social.repository.ChatGroupRepository;
import com.novacloudedu.backend.domain.social.repository.GroupJoinRequestRepository;
import com.novacloudedu.backend.domain.social.valueobject.*;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * 群聊服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class ChatGroupServiceTest {

    @Mock
    private ChatGroupRepository groupRepository;

    @Mock
    private ChatGroupMemberRepository memberRepository;

    @Mock
    private GroupJoinRequestRepository requestRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private ChatGroupApplicationService groupService;

    private static final Long OWNER_ID = 1L;
    private static final Long USER_ID = 2L;
    private static final Long ADMIN_ID = 3L;
    private static final Long GROUP_ID = 100L;

    // ==================== 群创建测试 ====================

    @Test
    @Order(1)
    @DisplayName("创建群 - 成功")
    void createGroup_Success() {
        // Mock 用户存在
        User owner = mock(User.class);
        when(userRepository.findById(UserId.of(OWNER_ID))).thenReturn(Optional.of(owner));

        // Mock 保存群
        when(groupRepository.save(any(ChatGroup.class))).thenAnswer(invocation -> {
            ChatGroup group = invocation.getArgument(0);
            group.assignId(GroupId.of(GROUP_ID));
            return group;
        });

        // Mock 保存成员
        when(memberRepository.save(any(ChatGroupMember.class))).thenAnswer(invocation -> {
            ChatGroupMember member = invocation.getArgument(0);
            member.assignId(1L);
            return member;
        });

        // 执行
        ChatGroup result = groupService.createGroup(OWNER_ID, "测试群", "描述", null);

        // 验证
        assertNotNull(result);
        assertEquals(GroupId.of(GROUP_ID), result.getId());
        assertEquals("测试群", result.getGroupName());
        assertEquals(UserId.of(OWNER_ID), result.getOwnerId());

        verify(groupRepository, times(1)).save(any(ChatGroup.class));
        verify(memberRepository, times(1)).save(any(ChatGroupMember.class));
    }

    @Test
    @Order(2)
    @DisplayName("创建群 - 失败（用户不存在）")
    void createGroup_FailUserNotFound() {
        when(userRepository.findById(UserId.of(OWNER_ID))).thenReturn(Optional.empty());

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.createGroup(OWNER_ID, "测试群", "描述", null);
        });

        assertEquals("用户不存在", exception.getMessage());
        verify(groupRepository, never()).save(any());
    }

    // ==================== 加入群测试 ====================

    @Test
    @Order(3)
    @DisplayName("申请加入群 - 自由加入模式，直接成功")
    void applyToJoin_FreeMode_Success() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        User user = mock(User.class);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(userRepository.findById(UserId.of(USER_ID))).thenReturn(Optional.of(user));
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(USER_ID))).thenReturn(false);
        when(memberRepository.save(any(ChatGroupMember.class))).thenAnswer(invocation -> {
            ChatGroupMember m = invocation.getArgument(0);
            m.assignId(2L);
            return m;
        });

        // 执行
        GroupJoinRequest result = groupService.applyToJoin(GROUP_ID, USER_ID, "申请消息");

        // 自由加入模式返回 null
        assertNull(result);
        verify(memberRepository, times(1)).save(any(ChatGroupMember.class));
        verify(groupRepository, times(1)).update(any(ChatGroup.class));
    }

    @Test
    @Order(4)
    @DisplayName("申请加入群 - 需审批模式，创建申请")
    void applyToJoin_ApprovalMode_CreateRequest() {
        ChatGroup group = createMockGroup(JoinMode.APPROVAL);
        User user = mock(User.class);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(userRepository.findById(UserId.of(USER_ID))).thenReturn(Optional.of(user));
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(USER_ID))).thenReturn(false);
        when(requestRepository.existsPendingRequest(GroupId.of(GROUP_ID), UserId.of(USER_ID))).thenReturn(false);
        when(requestRepository.save(any(GroupJoinRequest.class))).thenAnswer(invocation -> {
            GroupJoinRequest req = invocation.getArgument(0);
            req.assignId(1L);
            return req;
        });

        // 执行
        GroupJoinRequest result = groupService.applyToJoin(GROUP_ID, USER_ID, "请通过我的申请");

        // 验证
        assertNotNull(result);
        assertEquals("请通过我的申请", result.getMessage());
        assertEquals(JoinRequestStatus.PENDING, result.getStatus());

        verify(requestRepository, times(1)).save(any(GroupJoinRequest.class));
        verify(memberRepository, never()).save(any());
    }

    @Test
    @Order(5)
    @DisplayName("申请加入群 - 失败（禁止加入）")
    void applyToJoin_ForbiddenMode_Fail() {
        ChatGroup group = createMockGroup(JoinMode.FORBIDDEN);
        User user = mock(User.class);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(userRepository.findById(UserId.of(USER_ID))).thenReturn(Optional.of(user));
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(USER_ID))).thenReturn(false);

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.applyToJoin(GROUP_ID, USER_ID, "申请消息");
        });

        assertEquals("该群禁止加入", exception.getMessage());
    }

    @Test
    @Order(6)
    @DisplayName("申请加入群 - 失败（已是成员）")
    void applyToJoin_AlreadyMember_Fail() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        User user = mock(User.class);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(userRepository.findById(UserId.of(USER_ID))).thenReturn(Optional.of(user));
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(USER_ID))).thenReturn(true);

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.applyToJoin(GROUP_ID, USER_ID, null);
        });

        assertEquals("您已是群成员", exception.getMessage());
    }

    // ==================== 审批申请测试 ====================

    @Test
    @Order(7)
    @DisplayName("审批申请 - 通过")
    void handleJoinRequest_Approve() {
        ChatGroup group = createMockGroup(JoinMode.APPROVAL);
        GroupJoinRequest request = createMockRequest();
        ChatGroupMember admin = createMockMember(ADMIN_ID, GroupRole.ADMIN);

        when(requestRepository.findById(1L)).thenReturn(Optional.of(request));
        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(ADMIN_ID)))
                .thenReturn(Optional.of(admin));
        when(memberRepository.save(any(ChatGroupMember.class))).thenAnswer(invocation -> {
            ChatGroupMember m = invocation.getArgument(0);
            m.assignId(3L);
            return m;
        });

        // 执行
        groupService.handleJoinRequest(1L, ADMIN_ID, true);

        // 验证
        verify(requestRepository, times(1)).update(any(GroupJoinRequest.class));
        verify(memberRepository, times(1)).save(any(ChatGroupMember.class));
        verify(groupRepository, times(1)).update(any(ChatGroup.class));
    }

    @Test
    @Order(8)
    @DisplayName("审批申请 - 拒绝")
    void handleJoinRequest_Reject() {
        ChatGroup group = createMockGroup(JoinMode.APPROVAL);
        GroupJoinRequest request = createMockRequest();
        ChatGroupMember admin = createMockMember(ADMIN_ID, GroupRole.ADMIN);

        when(requestRepository.findById(1L)).thenReturn(Optional.of(request));
        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(ADMIN_ID)))
                .thenReturn(Optional.of(admin));

        // 执行
        groupService.handleJoinRequest(1L, ADMIN_ID, false);

        // 验证
        verify(requestRepository, times(1)).update(any(GroupJoinRequest.class));
        verify(memberRepository, never()).save(any());
    }

    @Test
    @Order(9)
    @DisplayName("审批申请 - 失败（无权限）")
    void handleJoinRequest_NoPermission() {
        ChatGroup group = createMockGroup(JoinMode.APPROVAL);
        GroupJoinRequest request = createMockRequest();
        ChatGroupMember member = createMockMember(USER_ID, GroupRole.MEMBER);

        when(requestRepository.findById(1L)).thenReturn(Optional.of(request));
        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(USER_ID)))
                .thenReturn(Optional.of(member));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.handleJoinRequest(1L, USER_ID, true);
        });

        assertEquals("没有权限审批申请", exception.getMessage());
    }

    // ==================== 移除成员测试 ====================

    @Test
    @Order(10)
    @DisplayName("移除成员 - 管理员移除普通成员")
    void removeMember_AdminRemoveMember() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        ChatGroupMember admin = createMockMember(ADMIN_ID, GroupRole.ADMIN);
        ChatGroupMember target = createMockMember(USER_ID, GroupRole.MEMBER);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(ADMIN_ID)))
                .thenReturn(Optional.of(admin));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(USER_ID)))
                .thenReturn(Optional.of(target));

        // 执行
        groupService.removeMember(GROUP_ID, ADMIN_ID, USER_ID);

        // 验证
        verify(memberRepository, times(1)).update(any(ChatGroupMember.class));
        verify(groupRepository, times(1)).update(any(ChatGroup.class));
    }

    @Test
    @Order(11)
    @DisplayName("移除成员 - 失败（普通成员无权限）")
    void removeMember_MemberNoPermission() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        ChatGroupMember member = createMockMember(USER_ID, GroupRole.MEMBER);
        ChatGroupMember target = createMockMember(4L, GroupRole.MEMBER);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(USER_ID)))
                .thenReturn(Optional.of(member));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(4L)))
                .thenReturn(Optional.of(target));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.removeMember(GROUP_ID, USER_ID, 4L);
        });

        assertEquals("没有权限移除成员", exception.getMessage());
    }

    @Test
    @Order(12)
    @DisplayName("移除成员 - 失败（不能移除群主）")
    void removeMember_CannotRemoveOwner() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        ChatGroupMember admin = createMockMember(ADMIN_ID, GroupRole.ADMIN);
        ChatGroupMember owner = createMockMember(OWNER_ID, GroupRole.OWNER);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(ADMIN_ID)))
                .thenReturn(Optional.of(admin));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(OWNER_ID)))
                .thenReturn(Optional.of(owner));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.removeMember(GROUP_ID, ADMIN_ID, OWNER_ID);
        });

        assertEquals("不能移除群主", exception.getMessage());
    }

    // ==================== 退出群测试 ====================

    @Test
    @Order(13)
    @DisplayName("退出群 - 成功")
    void leaveGroup_Success() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        ChatGroupMember member = createMockMember(USER_ID, GroupRole.MEMBER);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(USER_ID)))
                .thenReturn(Optional.of(member));

        // 执行
        groupService.leaveGroup(GROUP_ID, USER_ID);

        // 验证
        verify(memberRepository, times(1)).update(any(ChatGroupMember.class));
        verify(groupRepository, times(1)).update(any(ChatGroup.class));
    }

    @Test
    @Order(14)
    @DisplayName("退出群 - 失败（群主不能退出）")
    void leaveGroup_OwnerCannotLeave() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        ChatGroupMember owner = createMockMember(OWNER_ID, GroupRole.OWNER);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(OWNER_ID)))
                .thenReturn(Optional.of(owner));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.leaveGroup(GROUP_ID, OWNER_ID);
        });

        assertEquals("群主不能退出群，请先转让群主或解散群", exception.getMessage());
    }

    // ==================== 转让群主测试 ====================

    @Test
    @Order(15)
    @DisplayName("转让群主 - 成功")
    void transferOwnership_Success() {
        ChatGroup group = createMockGroup(JoinMode.FREE);
        ChatGroupMember ownerMember = createMockMember(OWNER_ID, GroupRole.OWNER);
        ChatGroupMember newOwnerMember = createMockMember(USER_ID, GroupRole.MEMBER);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(OWNER_ID)))
                .thenReturn(Optional.of(ownerMember));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(USER_ID)))
                .thenReturn(Optional.of(newOwnerMember));

        // 执行
        groupService.transferOwnership(GROUP_ID, OWNER_ID, USER_ID);

        // 验证
        verify(groupRepository, times(1)).update(any(ChatGroup.class));
        verify(memberRepository, times(2)).update(any(ChatGroupMember.class));
    }

    @Test
    @Order(16)
    @DisplayName("转让群主 - 失败（非群主操作）")
    void transferOwnership_NotOwner() {
        ChatGroup group = createMockGroup(JoinMode.FREE);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.transferOwnership(GROUP_ID, USER_ID, ADMIN_ID);
        });

        assertEquals("只有群主可以转让群", exception.getMessage());
    }

    // ==================== 解散群测试 ====================

    @Test
    @Order(17)
    @DisplayName("解散群 - 成功")
    void dissolveGroup_Success() {
        ChatGroup group = createMockGroup(JoinMode.FREE);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));

        // 执行
        groupService.dissolveGroup(GROUP_ID, OWNER_ID);

        // 验证
        verify(memberRepository, times(1)).deleteByGroupId(GroupId.of(GROUP_ID));
        verify(groupRepository, times(1)).update(any(ChatGroup.class));
    }

    @Test
    @Order(18)
    @DisplayName("解散群 - 失败（非群主）")
    void dissolveGroup_NotOwner() {
        ChatGroup group = createMockGroup(JoinMode.FREE);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupService.dissolveGroup(GROUP_ID, USER_ID);
        });

        assertEquals("只有群主可以解散群", exception.getMessage());
    }

    // ==================== 辅助方法 ====================

    private ChatGroup createMockGroup(JoinMode joinMode) {
        return ChatGroup.reconstruct(
                GroupId.of(GROUP_ID),
                "测试群",
                null,
                "群描述",
                UserId.of(OWNER_ID),
                null,
                200,
                5,
                InviteMode.ALL,
                joinMode,
                false,
                null,
                null,
                LocalDateTime.now(),
                LocalDateTime.now(),
                false
        );
    }

    private ChatGroupMember createMockMember(Long userId, GroupRole role) {
        return ChatGroupMember.reconstruct(
                userId,
                GroupId.of(GROUP_ID),
                MemberType.USER,
                UserId.of(userId),
                null,
                role,
                null,
                false,
                null,
                LocalDateTime.now(),
                LocalDateTime.now(),
                false
        );
    }

    private GroupJoinRequest createMockRequest() {
        return GroupJoinRequest.reconstruct(
                1L,
                GroupId.of(GROUP_ID),
                UserId.of(USER_ID),
                "请通过我的申请",
                JoinRequestStatus.PENDING,
                null,
                null,
                LocalDateTime.now(),
                LocalDateTime.now()
        );
    }
}
