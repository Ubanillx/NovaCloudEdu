package com.novacloudedu.backend.notification;

import com.novacloudedu.backend.application.service.NotificationService;
import com.novacloudedu.backend.infrastructure.websocket.OfflineNotificationCache;
import com.novacloudedu.backend.infrastructure.websocket.WebSocketEventListener;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent.EventType;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 通知服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class NotificationServiceTest {

    @Mock
    private SimpMessagingTemplate messagingTemplate;

    @Mock
    private WebSocketEventListener webSocketEventListener;

    @Mock
    private OfflineNotificationCache offlineNotificationCache;

    @InjectMocks
    private NotificationService notificationService;

    private static final Long USER_ID = 1L;
    private static final Long SENDER_ID = 2L;

    // ==================== 在线用户通知测试 ====================

    @Test
    @Order(1)
    @DisplayName("通知在线用户 - 直接推送")
    void notifyUser_Online_DirectPush() {
        // 用户在线
        when(webSocketEventListener.isUserOnline(USER_ID)).thenReturn(true);

        // 执行
        notificationService.notifyUser(USER_ID, EventType.NEW_PRIVATE_MESSAGE, Map.of(
                "senderId", SENDER_ID,
                "senderName", "张三"
        ));

        // 验证：直接推送，不缓存
        verify(messagingTemplate, times(1)).convertAndSendToUser(
                eq(USER_ID.toString()),
                eq("/queue/notifications"),
                any(NotificationEvent.class)
        );
        verify(offlineNotificationCache, never()).cacheNotification(anyLong(), any());
    }

    @Test
    @Order(2)
    @DisplayName("通知离线用户 - 缓存通知")
    void notifyUser_Offline_CacheNotification() {
        // 用户离线
        when(webSocketEventListener.isUserOnline(USER_ID)).thenReturn(false);

        // 执行
        notificationService.notifyUser(USER_ID, EventType.NEW_PRIVATE_MESSAGE, Map.of(
                "senderId", SENDER_ID,
                "senderName", "张三"
        ));

        // 验证：缓存通知，不直接推送
        verify(offlineNotificationCache, times(1)).cacheNotification(eq(USER_ID), any(NotificationEvent.class));
        verify(messagingTemplate, never()).convertAndSendToUser(anyString(), anyString(), any(NotificationEvent.class));
    }

    // ==================== 批量通知测试 ====================

    @Test
    @Order(3)
    @DisplayName("批量通知 - 部分在线部分离线")
    void notifyUsers_MixedOnlineOffline() {
        Long onlineUser1 = 1L;
        Long onlineUser2 = 2L;
        Long offlineUser1 = 3L;
        Long offlineUser2 = 4L;

        when(webSocketEventListener.isUserOnline(onlineUser1)).thenReturn(true);
        when(webSocketEventListener.isUserOnline(onlineUser2)).thenReturn(true);
        when(webSocketEventListener.isUserOnline(offlineUser1)).thenReturn(false);
        when(webSocketEventListener.isUserOnline(offlineUser2)).thenReturn(false);

        // 执行
        notificationService.notifyUsers(
                List.of(onlineUser1, onlineUser2, offlineUser1, offlineUser2),
                EventType.GROUP_UPDATED,
                Map.of("groupId", 100L)
        );

        // 验证：在线用户直接推送（2次）
        verify(messagingTemplate, times(2)).convertAndSendToUser(
                anyString(), eq("/queue/notifications"), any(NotificationEvent.class)
        );

        // 验证：离线用户缓存（2次）
        verify(offlineNotificationCache, times(2)).cacheNotification(anyLong(), any(NotificationEvent.class));
    }

    // ==================== 缓存通知推送测试 ====================

    @Test
    @Order(4)
    @DisplayName("推送缓存通知 - 有缓存")
    void pushCachedNotifications_HasCache() {
        NotificationEvent event1 = NotificationEvent.of(EventType.NEW_PRIVATE_MESSAGE, Map.of("senderId", 10L));
        NotificationEvent event2 = NotificationEvent.of(EventType.FRIEND_REQUEST_RECEIVED, Map.of("requestId", 20L));

        when(offlineNotificationCache.pollAllNotifications(USER_ID)).thenReturn(List.of(event1, event2));

        // 执行
        notificationService.pushCachedNotifications(USER_ID);

        // 验证：推送2条缓存通知
        verify(messagingTemplate, times(2)).convertAndSendToUser(
                eq(USER_ID.toString()),
                eq("/queue/notifications"),
                any(NotificationEvent.class)
        );
    }

    @Test
    @Order(5)
    @DisplayName("推送缓存通知 - 无缓存")
    void pushCachedNotifications_NoCache() {
        when(offlineNotificationCache.pollAllNotifications(USER_ID)).thenReturn(List.of());

        // 执行
        notificationService.pushCachedNotifications(USER_ID);

        // 验证：没有推送
        verify(messagingTemplate, never()).convertAndSendToUser(anyString(), anyString(), any());
    }

    // ==================== 便捷方法测试 ====================

    @Test
    @Order(6)
    @DisplayName("新私聊消息通知")
    void notifyNewPrivateMessage() {
        when(webSocketEventListener.isUserOnline(USER_ID)).thenReturn(true);

        // 执行
        notificationService.notifyNewPrivateMessage(USER_ID, SENDER_ID, "张三");

        // 验证
        ArgumentCaptor<NotificationEvent> captor = ArgumentCaptor.forClass(NotificationEvent.class);
        verify(messagingTemplate).convertAndSendToUser(eq(USER_ID.toString()), eq("/queue/notifications"), captor.capture());

        NotificationEvent event = captor.getValue();
        assertEquals(EventType.NEW_PRIVATE_MESSAGE, event.getType());
        assertEquals(SENDER_ID, event.getData().get("senderId"));
        assertEquals("张三", event.getData().get("senderName"));
    }

    @Test
    @Order(7)
    @DisplayName("好友申请通知")
    void notifyFriendRequest() {
        when(webSocketEventListener.isUserOnline(USER_ID)).thenReturn(true);

        // 执行
        notificationService.notifyFriendRequest(USER_ID, 100L, SENDER_ID, "李四");

        // 验证
        ArgumentCaptor<NotificationEvent> captor = ArgumentCaptor.forClass(NotificationEvent.class);
        verify(messagingTemplate).convertAndSendToUser(eq(USER_ID.toString()), eq("/queue/notifications"), captor.capture());

        NotificationEvent event = captor.getValue();
        assertEquals(EventType.FRIEND_REQUEST_RECEIVED, event.getType());
        assertEquals(100L, event.getData().get("requestId"));
        assertEquals(SENDER_ID, event.getData().get("senderId"));
        assertEquals("李四", event.getData().get("senderName"));
    }

    @Test
    @Order(8)
    @DisplayName("群消息通知")
    void notifyNewGroupMessage() {
        Long groupId = 200L;

        // 执行（群通知直接发到 topic，不检查在线状态）
        notificationService.notifyNewGroupMessage(groupId, "测试群", SENDER_ID, "王五");

        // 验证
        ArgumentCaptor<NotificationEvent> captor = ArgumentCaptor.forClass(NotificationEvent.class);
        verify(messagingTemplate).convertAndSend(eq("/topic/group/200/notifications"), captor.capture());

        NotificationEvent event = captor.getValue();
        assertEquals(EventType.NEW_GROUP_MESSAGE, event.getType());
        assertEquals(groupId, event.getData().get("groupId"));
        assertEquals("测试群", event.getData().get("groupName"));
    }

    @Test
    @Order(9)
    @DisplayName("未读数变化通知")
    void notifyUnreadCountChanged() {
        when(webSocketEventListener.isUserOnline(USER_ID)).thenReturn(true);

        // 执行
        notificationService.notifyUnreadCountChanged(USER_ID, 5, 3);

        // 验证
        ArgumentCaptor<NotificationEvent> captor = ArgumentCaptor.forClass(NotificationEvent.class);
        verify(messagingTemplate).convertAndSendToUser(eq(USER_ID.toString()), eq("/queue/notifications"), captor.capture());

        NotificationEvent event = captor.getValue();
        assertEquals(EventType.UNREAD_COUNT_CHANGED, event.getType());
        assertEquals(5, event.getData().get("privateUnread"));
        assertEquals(3, event.getData().get("groupUnread"));
        assertEquals(8, event.getData().get("totalUnread"));
    }

    // ==================== 获取缓存数量测试 ====================

    @Test
    @Order(10)
    @DisplayName("获取缓存通知数量")
    void getCachedNotificationCount() {
        when(offlineNotificationCache.getCacheSize(USER_ID)).thenReturn(5);

        int count = notificationService.getCachedNotificationCount(USER_ID);

        assertEquals(5, count);
    }
}
