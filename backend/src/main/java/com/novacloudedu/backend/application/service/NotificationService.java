package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.infrastructure.websocket.OfflineNotificationCache;
import com.novacloudedu.backend.infrastructure.websocket.WebSocketEventListener;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent.EventType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 通知服务
 * 通过 WebSocket 向客户端推送轻量级通知事件
 * 客户端收到通知后，通过 HTTP API 获取详细数据
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationService {

    private final SimpMessagingTemplate messagingTemplate;
    private final WebSocketEventListener webSocketEventListener;
    private final OfflineNotificationCache offlineNotificationCache;

    /**
     * 向单个用户发送通知
     * 客户端订阅: /user/queue/notifications
     * 如果用户离线，则缓存通知
     */
    public void notifyUser(Long userId, EventType type, Map<String, Object> data) {
        NotificationEvent event = NotificationEvent.of(type, data);
        
        if (webSocketEventListener.isUserOnline(userId)) {
            // 用户在线，直接推送
            String destination = "/queue/notifications";
            messagingTemplate.convertAndSendToUser(userId.toString(), destination, event);
            log.debug("通知已发送: userId={}, type={}", userId, type);
        } else {
            // 用户离线，缓存通知
            offlineNotificationCache.cacheNotification(userId, event);
            log.debug("用户离线，通知已缓存: userId={}, type={}", userId, type);
        }
    }

    /**
     * 向多个用户发送通知
     * 在线用户直接推送，离线用户缓存
     */
    public void notifyUsers(Collection<Long> userIds, EventType type, Map<String, Object> data) {
        NotificationEvent event = NotificationEvent.of(type, data);
        String destination = "/queue/notifications";
        
        int onlineCount = 0;
        int offlineCount = 0;
        
        for (Long userId : userIds) {
            if (webSocketEventListener.isUserOnline(userId)) {
                messagingTemplate.convertAndSendToUser(userId.toString(), destination, event);
                onlineCount++;
            } else {
                offlineNotificationCache.cacheNotification(userId, event);
                offlineCount++;
            }
        }
        log.debug("批量通知: type={}, online={}, offline={}", type, onlineCount, offlineCount);
    }

    /**
     * 推送用户的所有缓存通知（用户上线时调用）
     */
    public void pushCachedNotifications(Long userId) {
        List<NotificationEvent> cachedNotifications = offlineNotificationCache.pollAllNotifications(userId);
        if (cachedNotifications.isEmpty()) {
            return;
        }

        String destination = "/queue/notifications";
        for (NotificationEvent event : cachedNotifications) {
            messagingTemplate.convertAndSendToUser(userId.toString(), destination, event);
        }
        log.info("缓存通知已推送: userId={}, count={}", userId, cachedNotifications.size());
    }

    /**
     * 获取用户缓存通知数量
     */
    public int getCachedNotificationCount(Long userId) {
        return offlineNotificationCache.getCacheSize(userId);
    }

    /**
     * 向群组所有成员发送通知（通过群主题）
     * 客户端订阅: /topic/group/{groupId}/notifications
     */
    public void notifyGroup(Long groupId, EventType type, Map<String, Object> data) {
        NotificationEvent event = NotificationEvent.of(type, data);
        String destination = "/topic/group/" + groupId + "/notifications";
        messagingTemplate.convertAndSend(destination, event);
        log.debug("群通知已发送: groupId={}, type={}", groupId, type);
    }

    // ==================== 便捷方法 ====================

    /**
     * 通知用户有新私聊消息
     */
    public void notifyNewPrivateMessage(Long receiverId, Long senderId, String senderName) {
        notifyUser(receiverId, EventType.NEW_PRIVATE_MESSAGE, Map.of(
                "senderId", senderId,
                "senderName", senderName
        ));
    }

    /**
     * 通知发送者消息已读
     */
    public void notifyPrivateMessageRead(Long senderId, Long readerId) {
        notifyUser(senderId, EventType.PRIVATE_MESSAGE_READ, Map.of(
                "readerId", readerId
        ));
    }

    /**
     * 通知群组有新消息
     */
    public void notifyNewGroupMessage(Long groupId, String groupName, Long senderId, String senderName) {
        notifyGroup(groupId, EventType.NEW_GROUP_MESSAGE, Map.of(
                "groupId", groupId,
                "groupName", groupName,
                "senderId", senderId,
                "senderName", senderName
        ));
    }

    /**
     * 通知用户收到好友申请
     */
    public void notifyFriendRequest(Long receiverId, Long requestId, Long senderId, String senderName) {
        notifyUser(receiverId, EventType.FRIEND_REQUEST_RECEIVED, Map.of(
                "requestId", requestId,
                "senderId", senderId,
                "senderName", senderName
        ));
    }

    /**
     * 通知用户好友申请被处理
     */
    public void notifyFriendRequestHandled(Long senderId, Long requestId, boolean accepted) {
        notifyUser(senderId, EventType.FRIEND_REQUEST_HANDLED, Map.of(
                "requestId", requestId,
                "accepted", accepted
        ));
    }

    /**
     * 通知群管理员收到入群申请
     */
    public void notifyGroupJoinRequest(Collection<Long> adminIds, Long groupId, Long requestId, 
                                       Long userId, String userName) {
        notifyUsers(adminIds, EventType.GROUP_JOIN_REQUEST_RECEIVED, Map.of(
                "groupId", groupId,
                "requestId", requestId,
                "userId", userId,
                "userName", userName
        ));
    }

    /**
     * 通知用户入群申请被处理
     */
    public void notifyGroupJoinRequestHandled(Long userId, Long groupId, Long requestId, boolean approved) {
        notifyUser(userId, EventType.GROUP_JOIN_REQUEST_HANDLED, Map.of(
                "groupId", groupId,
                "requestId", requestId,
                "approved", approved
        ));
    }

    /**
     * 通知用户被邀请入群
     */
    public void notifyGroupInvited(Long userId, Long groupId, String groupName, Long inviterId) {
        notifyUser(userId, EventType.GROUP_INVITED, Map.of(
                "groupId", groupId,
                "groupName", groupName,
                "inviterId", inviterId
        ));
    }

    /**
     * 通知用户被移出群
     */
    public void notifyGroupRemoved(Long userId, Long groupId, String groupName) {
        notifyUser(userId, EventType.GROUP_REMOVED, Map.of(
                "groupId", groupId,
                "groupName", groupName
        ));
    }

    /**
     * 通知群成员群信息更新
     */
    public void notifyGroupUpdated(Long groupId) {
        notifyGroup(groupId, EventType.GROUP_UPDATED, Map.of(
                "groupId", groupId
        ));
    }

    /**
     * 通知群成员群解散
     */
    public void notifyGroupDissolved(Collection<Long> memberIds, Long groupId, String groupName) {
        notifyUsers(memberIds, EventType.GROUP_DISSOLVED, Map.of(
                "groupId", groupId,
                "groupName", groupName
        ));
    }

    /**
     * 通知用户未读数变化
     */
    public void notifyUnreadCountChanged(Long userId, int privateUnread, int groupUnread) {
        notifyUser(userId, EventType.UNREAD_COUNT_CHANGED, Map.of(
                "privateUnread", privateUnread,
                "groupUnread", groupUnread,
                "totalUnread", privateUnread + groupUnread
        ));
    }

    /**
     * 发送系统通知
     */
    public void notifySystem(Long userId, String title, String content) {
        notifyUser(userId, EventType.SYSTEM_NOTIFICATION, Map.of(
                "title", title,
                "content", content
        ));
    }
}
