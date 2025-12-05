package com.novacloudedu.backend.chat;

import com.novacloudedu.backend.application.service.GroupChatApplicationService;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.repository.*;
import com.novacloudedu.backend.domain.social.valueobject.*;
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
 * 群聊消息服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class GroupChatServiceTest {

    @Mock
    private GroupMessageRepository messageRepository;

    @Mock
    private GroupMessageReadRepository readRepository;

    @Mock
    private ChatGroupRepository groupRepository;

    @Mock
    private ChatGroupMemberRepository memberRepository;

    @InjectMocks
    private GroupChatApplicationService groupChatService;

    private static final Long GROUP_ID = 100L;
    private static final Long OWNER_ID = 1L;
    private static final Long MEMBER_ID = 2L;
    private static final Long ADMIN_ID = 3L;
    private static final Long MESSAGE_ID = 1000L;

    // ==================== 发送消息测试 ====================

    @Test
    @Order(1)
    @DisplayName("发送群消息 - 成功")
    void sendMessage_Success() {
        ChatGroup group = createMockGroup(false);
        ChatGroupMember member = createMockMember(MEMBER_ID, GroupRole.MEMBER, false);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID)))
                .thenReturn(Optional.of(member));
        when(messageRepository.save(any(GroupMessage.class))).thenAnswer(invocation -> {
            GroupMessage msg = invocation.getArgument(0);
            msg.assignId(GroupMessageId.of(MESSAGE_ID));
            return msg;
        });

        // 执行
        GroupMessage result = groupChatService.sendMessage(GROUP_ID, MEMBER_ID, "Hello!", MessageType.TEXT, null);

        // 验证
        assertNotNull(result);
        assertEquals(GroupMessageId.of(MESSAGE_ID), result.getId());
        assertEquals("Hello!", result.getContent());
        assertEquals(MessageType.TEXT, result.getType());

        verify(messageRepository, times(1)).save(any(GroupMessage.class));
    }

    @Test
    @Order(2)
    @DisplayName("发送群消息 - 失败（群不存在）")
    void sendMessage_GroupNotFound() {
        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.empty());

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.sendMessage(GROUP_ID, MEMBER_ID, "Hello!", MessageType.TEXT, null);
        });

        assertEquals("群不存在", exception.getMessage());
        verify(messageRepository, never()).save(any());
    }

    @Test
    @Order(3)
    @DisplayName("发送群消息 - 失败（非群成员）")
    void sendMessage_NotMember() {
        ChatGroup group = createMockGroup(false);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID)))
                .thenReturn(Optional.empty());

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.sendMessage(GROUP_ID, MEMBER_ID, "Hello!", MessageType.TEXT, null);
        });

        assertEquals("您不是群成员", exception.getMessage());
    }

    @Test
    @Order(4)
    @DisplayName("发送群消息 - 失败（群全员禁言，普通成员）")
    void sendMessage_GroupMuted_MemberCannotSend() {
        ChatGroup group = createMockGroup(true); // 全员禁言
        ChatGroupMember member = createMockMember(MEMBER_ID, GroupRole.MEMBER, false);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID)))
                .thenReturn(Optional.of(member));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.sendMessage(GROUP_ID, MEMBER_ID, "Hello!", MessageType.TEXT, null);
        });

        assertEquals("群处于全员禁言状态", exception.getMessage());
    }

    @Test
    @Order(5)
    @DisplayName("发送群消息 - 成功（群全员禁言，但管理员可发）")
    void sendMessage_GroupMuted_AdminCanSend() {
        ChatGroup group = createMockGroup(true); // 全员禁言
        ChatGroupMember admin = createMockMember(ADMIN_ID, GroupRole.ADMIN, false);

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(ADMIN_ID)))
                .thenReturn(Optional.of(admin));
        when(messageRepository.save(any(GroupMessage.class))).thenAnswer(invocation -> {
            GroupMessage msg = invocation.getArgument(0);
            msg.assignId(GroupMessageId.of(MESSAGE_ID));
            return msg;
        });

        // 执行
        GroupMessage result = groupChatService.sendMessage(GROUP_ID, ADMIN_ID, "公告", MessageType.TEXT, null);

        // 验证
        assertNotNull(result);
        verify(messageRepository, times(1)).save(any(GroupMessage.class));
    }

    @Test
    @Order(6)
    @DisplayName("发送群消息 - 失败（成员被禁言）")
    void sendMessage_MemberMuted() {
        ChatGroup group = createMockGroup(false);
        ChatGroupMember member = createMockMember(MEMBER_ID, GroupRole.MEMBER, true); // 被禁言

        when(groupRepository.findById(GroupId.of(GROUP_ID))).thenReturn(Optional.of(group));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID)))
                .thenReturn(Optional.of(member));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.sendMessage(GROUP_ID, MEMBER_ID, "Hello!", MessageType.TEXT, null);
        });

        assertEquals("您已被禁言", exception.getMessage());
    }

    // ==================== 获取消息测试 ====================

    @Test
    @Order(7)
    @DisplayName("获取群消息列表 - 成功")
    void getMessages_Success() {
        GroupMessage msg1 = createMockMessage(1L, "消息1");
        GroupMessage msg2 = createMockMessage(2L, "消息2");
        GroupMessageRepository.MessagePage mockPage = new GroupMessageRepository.MessagePage(
                List.of(msg1, msg2), 2, 1, 20
        );

        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(true);
        when(messageRepository.findByGroupId(GroupId.of(GROUP_ID), 1, 20)).thenReturn(mockPage);

        // 执行
        GroupMessageRepository.MessagePage result = groupChatService.getMessages(GROUP_ID, MEMBER_ID, 1, 20);

        // 验证
        assertNotNull(result);
        assertEquals(2, result.messages().size());
        assertEquals(2, result.total());
    }

    @Test
    @Order(8)
    @DisplayName("获取群消息列表 - 失败（非群成员）")
    void getMessages_NotMember() {
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(false);

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.getMessages(GROUP_ID, MEMBER_ID, 1, 20);
        });

        assertEquals("您不是群成员", exception.getMessage());
    }

    @Test
    @Order(9)
    @DisplayName("获取最新消息 - 成功")
    void getLatestMessages_Success() {
        GroupMessage msg1 = createMockMessage(1L, "最新消息1");
        GroupMessage msg2 = createMockMessage(2L, "最新消息2");

        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(true);
        when(messageRepository.findLatestByGroupId(GroupId.of(GROUP_ID), 10)).thenReturn(List.of(msg1, msg2));

        // 执行
        List<GroupMessage> result = groupChatService.getLatestMessages(GROUP_ID, MEMBER_ID, 10);

        // 验证
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    // ==================== 已读标记测试 ====================

    @Test
    @Order(10)
    @DisplayName("标记消息已读 - 成功")
    void markAsRead_Success() {
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(true);

        // 执行
        groupChatService.markAsRead(GROUP_ID, MEMBER_ID, MESSAGE_ID);

        // 验证
        verify(readRepository, times(1)).markAllAsRead(
                GroupId.of(GROUP_ID), UserId.of(MEMBER_ID), GroupMessageId.of(MESSAGE_ID)
        );
    }

    @Test
    @Order(11)
    @DisplayName("标记消息已读 - 失败（非群成员）")
    void markAsRead_NotMember() {
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(false);

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.markAsRead(GROUP_ID, MEMBER_ID, MESSAGE_ID);
        });

        assertEquals("您不是群成员", exception.getMessage());
    }

    @Test
    @Order(12)
    @DisplayName("获取未读消息数 - 成功")
    void getUnreadCount_Success() {
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(true);
        when(readRepository.countUnreadMessages(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(5);

        // 执行
        int count = groupChatService.getUnreadCount(GROUP_ID, MEMBER_ID);

        // 验证
        assertEquals(5, count);
    }

    @Test
    @Order(13)
    @DisplayName("获取未读消息数 - 非群成员返回0")
    void getUnreadCount_NotMember() {
        when(memberRepository.isMember(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID))).thenReturn(false);

        // 执行
        int count = groupChatService.getUnreadCount(GROUP_ID, MEMBER_ID);

        // 验证
        assertEquals(0, count);
    }

    // ==================== 删除消息测试 ====================

    @Test
    @Order(14)
    @DisplayName("删除消息 - 成功（消息发送者）")
    void deleteMessage_BySender() {
        GroupMessage message = createMockMessage(MESSAGE_ID, "要删除的消息");
        ChatGroupMember sender = createMockMember(MEMBER_ID, GroupRole.MEMBER, false);

        when(messageRepository.findById(GroupMessageId.of(MESSAGE_ID))).thenReturn(Optional.of(message));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(MEMBER_ID)))
                .thenReturn(Optional.of(sender));

        // 执行
        groupChatService.deleteMessage(GROUP_ID, MEMBER_ID, MESSAGE_ID);

        // 验证
        verify(messageRepository, times(1)).delete(GroupMessageId.of(MESSAGE_ID));
    }

    @Test
    @Order(15)
    @DisplayName("删除消息 - 成功（管理员）")
    void deleteMessage_ByAdmin() {
        GroupMessage message = createMockMessage(MESSAGE_ID, "要删除的消息");
        ChatGroupMember admin = createMockMember(ADMIN_ID, GroupRole.ADMIN, false);

        when(messageRepository.findById(GroupMessageId.of(MESSAGE_ID))).thenReturn(Optional.of(message));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(ADMIN_ID)))
                .thenReturn(Optional.of(admin));

        // 执行
        groupChatService.deleteMessage(GROUP_ID, ADMIN_ID, MESSAGE_ID);

        // 验证
        verify(messageRepository, times(1)).delete(GroupMessageId.of(MESSAGE_ID));
    }

    @Test
    @Order(16)
    @DisplayName("删除消息 - 失败（非发送者且非管理员）")
    void deleteMessage_NoPermission() {
        GroupMessage message = createMockMessage(MESSAGE_ID, "要删除的消息");
        // 消息发送者是 MEMBER_ID，但操作者是 4L
        ChatGroupMember otherMember = createMockMember(4L, GroupRole.MEMBER, false);

        when(messageRepository.findById(GroupMessageId.of(MESSAGE_ID))).thenReturn(Optional.of(message));
        when(memberRepository.findByGroupIdAndUserId(GroupId.of(GROUP_ID), UserId.of(4L)))
                .thenReturn(Optional.of(otherMember));

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.deleteMessage(GROUP_ID, 4L, MESSAGE_ID);
        });

        assertEquals("没有权限删除此消息", exception.getMessage());
    }

    @Test
    @Order(17)
    @DisplayName("删除消息 - 失败（消息不存在）")
    void deleteMessage_MessageNotFound() {
        when(messageRepository.findById(GroupMessageId.of(MESSAGE_ID))).thenReturn(Optional.empty());

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            groupChatService.deleteMessage(GROUP_ID, MEMBER_ID, MESSAGE_ID);
        });

        assertEquals("消息不存在", exception.getMessage());
    }

    // ==================== 辅助方法 ====================

    private ChatGroup createMockGroup(boolean isMute) {
        return ChatGroup.reconstruct(
                GroupId.of(GROUP_ID),
                "测试群",
                null,
                "群描述",
                UserId.of(OWNER_ID),
                null,
                200,
                10,
                InviteMode.ALL,
                JoinMode.FREE,
                isMute,
                null,
                null,
                LocalDateTime.now(),
                LocalDateTime.now(),
                false
        );
    }

    private ChatGroupMember createMockMember(Long userId, GroupRole role, boolean isMute) {
        return ChatGroupMember.reconstruct(
                userId,
                GroupId.of(GROUP_ID),
                MemberType.USER,
                UserId.of(userId),
                null,
                role,
                null,
                isMute,
                isMute ? LocalDateTime.now().plusDays(1) : null, // 禁言到明天
                LocalDateTime.now(),
                LocalDateTime.now(),
                false
        );
    }

    private GroupMessage createMockMessage(Long messageId, String content) {
        return GroupMessage.reconstruct(
                GroupMessageId.of(messageId),
                GroupId.of(GROUP_ID),
                SenderType.USER,
                UserId.of(MEMBER_ID),
                null,
                content,
                MessageType.TEXT,
                null,
                LocalDateTime.now(),
                false
        );
    }
}
