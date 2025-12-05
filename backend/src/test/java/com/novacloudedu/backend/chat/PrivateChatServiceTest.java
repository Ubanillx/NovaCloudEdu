package com.novacloudedu.backend.chat;

import com.novacloudedu.backend.application.service.PrivateChatApplicationService;
import com.novacloudedu.backend.application.social.command.SendPrivateMessageCommand;
import com.novacloudedu.backend.application.social.query.ChatHistoryQuery;
import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateChatSessionRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateMessageRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateMessageRepository.MessagePage;
import com.novacloudedu.backend.domain.social.valueobject.MessageId;
import com.novacloudedu.backend.domain.social.valueobject.MessageType;
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
 * 私聊服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class PrivateChatServiceTest {

    @Mock
    private PrivateMessageRepository privateMessageRepository;

    @Mock
    private PrivateChatSessionRepository privateChatSessionRepository;

    @Mock
    private FriendRelationshipRepository friendRelationshipRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private PrivateChatApplicationService privateChatService;

    private static final Long SENDER_ID = 1L;
    private static final Long RECEIVER_ID = 2L;

    @Test
    @Order(1)
    @DisplayName("发送消息 - 成功（好友关系存在）")
    void sendMessage_Success() {
        // 准备数据
        SendPrivateMessageCommand command = new SendPrivateMessageCommand(
                SENDER_ID, RECEIVER_ID, "Hello!", MessageType.TEXT
        );

        User receiver = mock(User.class);
        when(userRepository.findById(UserId.of(RECEIVER_ID))).thenReturn(Optional.of(receiver));
        when(friendRelationshipRepository.areFriends(UserId.of(SENDER_ID), UserId.of(RECEIVER_ID))).thenReturn(true);
        
        // Mock 保存消息
        when(privateMessageRepository.save(any(PrivateMessage.class))).thenAnswer(invocation -> {
            PrivateMessage msg = invocation.getArgument(0);
            msg.assignId(MessageId.of(100L));
            return msg;
        });
        
        // Mock 会话
        when(privateChatSessionRepository.getOrCreate(any(), any())).thenReturn(mock(com.novacloudedu.backend.domain.social.entity.PrivateChatSession.class));

        // 执行
        PrivateMessage result = privateChatService.sendMessage(command);

        // 验证
        assertNotNull(result);
        assertEquals(MessageId.of(100L), result.getId());
        assertEquals("Hello!", result.getContent());
        assertEquals(MessageType.TEXT, result.getType());

        verify(privateMessageRepository, times(1)).save(any(PrivateMessage.class));
        verify(privateChatSessionRepository, times(1)).update(any());
    }

    @Test
    @Order(2)
    @DisplayName("发送消息 - 失败（非好友关系）")
    void sendMessage_FailNotFriends() {
        // 准备数据
        SendPrivateMessageCommand command = new SendPrivateMessageCommand(
                SENDER_ID, RECEIVER_ID, "Hello!", MessageType.TEXT
        );

        User receiver = mock(User.class);
        when(userRepository.findById(UserId.of(RECEIVER_ID))).thenReturn(Optional.of(receiver));
        when(friendRelationshipRepository.areFriends(UserId.of(SENDER_ID), UserId.of(RECEIVER_ID))).thenReturn(false);

        // 执行 & 验证
        BusinessException exception = assertThrows(BusinessException.class, () -> {
            privateChatService.sendMessage(command);
        });

        assertEquals("只能给好友发送消息", exception.getMessage());
        verify(privateMessageRepository, never()).save(any());
    }

    @Test
    @Order(3)
    @DisplayName("发送消息 - 失败（接收者不存在）")
    void sendMessage_FailReceiverNotFound() {
        // 准备数据
        SendPrivateMessageCommand command = new SendPrivateMessageCommand(
                SENDER_ID, RECEIVER_ID, "Hello!", MessageType.TEXT
        );

        when(userRepository.findById(UserId.of(RECEIVER_ID))).thenReturn(Optional.empty());

        // 执行 & 验证
        BusinessException exception = assertThrows(BusinessException.class, () -> {
            privateChatService.sendMessage(command);
        });

        assertEquals("接收用户不存在", exception.getMessage());
        verify(privateMessageRepository, never()).save(any());
    }

    @Test
    @Order(4)
    @DisplayName("获取聊天历史记录")
    void getChatHistory_Success() {
        // 准备数据
        ChatHistoryQuery query = new ChatHistoryQuery(SENDER_ID, RECEIVER_ID, 1, 20);

        PrivateMessage msg1 = PrivateMessage.reconstruct(
                MessageId.of(1L), UserId.of(SENDER_ID), UserId.of(RECEIVER_ID),
                "消息1", MessageType.TEXT, false, LocalDateTime.now(), false
        );
        PrivateMessage msg2 = PrivateMessage.reconstruct(
                MessageId.of(2L), UserId.of(RECEIVER_ID), UserId.of(SENDER_ID),
                "消息2", MessageType.TEXT, true, LocalDateTime.now(), false
        );

        MessagePage mockPage = new MessagePage(List.of(msg1, msg2), 2, 1, 20);
        when(privateMessageRepository.findBetweenUsers(
                UserId.of(SENDER_ID), UserId.of(RECEIVER_ID), 1, 20
        )).thenReturn(mockPage);

        // 执行
        MessagePage result = privateChatService.getChatHistory(query);

        // 验证
        assertNotNull(result);
        assertEquals(2, result.messages().size());
        assertEquals(2, result.total());
        assertEquals("消息1", result.messages().get(0).getContent());
    }

    @Test
    @Order(5)
    @DisplayName("标记消息已读")
    void markMessagesAsRead_Success() {
        // 执行
        privateChatService.markMessagesAsRead(RECEIVER_ID, SENDER_ID);

        // 验证
        verify(privateMessageRepository, times(1)).markAllAsReadBetweenUsers(
                UserId.of(SENDER_ID), UserId.of(RECEIVER_ID)
        );
    }

    @Test
    @Order(6)
    @DisplayName("获取未读消息总数")
    void getTotalUnreadCount_Success() {
        // 准备数据
        when(privateChatSessionRepository.findByUserId(UserId.of(SENDER_ID))).thenReturn(List.of());

        // 执行
        int count = privateChatService.getTotalUnreadCount(SENDER_ID);

        // 验证
        assertEquals(0, count);
    }
}
