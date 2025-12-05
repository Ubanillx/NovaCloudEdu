package com.novacloudedu.backend.infrastructure.websocket;

import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * WebSocket 事件监听器
 * 处理用户连接和断开事件
 */
@Component
@Slf4j
public class WebSocketEventListener {

    private final OfflineNotificationCache offlineNotificationCache;
    private final SimpMessagingTemplate messagingTemplate;

    /**
     * 在线用户：userId -> sessionId
     */
    private final Map<Long, String> onlineUsers = new ConcurrentHashMap<>();

    public WebSocketEventListener(OfflineNotificationCache offlineNotificationCache, 
                                  SimpMessagingTemplate messagingTemplate) {
        this.offlineNotificationCache = offlineNotificationCache;
        this.messagingTemplate = messagingTemplate;
    }

    /**
     * 处理用户连接事件
     */
    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String sessionId = headerAccessor.getSessionId();
        Principal principal = headerAccessor.getUser();

        Long userId = extractUserId(principal);
        if (userId != null) {
            onlineUsers.put(userId, sessionId);
            log.info("用户上线: userId={}, sessionId={}", userId, sessionId);

            // 延迟一小段时间后推送缓存通知，确保客户端已完成订阅
            pushCachedNotificationsAsync(userId);
        }
    }

    /**
     * 异步推送缓存通知
     */
    private void pushCachedNotificationsAsync(Long userId) {
        // 使用新线程延迟推送，给客户端时间完成订阅
        new Thread(() -> {
            try {
                Thread.sleep(500); // 等待500ms确保客户端订阅完成
                pushCachedNotifications(userId);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }).start();
    }

    /**
     * 推送用户的所有缓存通知
     */
    private void pushCachedNotifications(Long userId) {
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
     * 处理用户断开事件
     */
    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String sessionId = headerAccessor.getSessionId();
        Principal principal = headerAccessor.getUser();

        Long userId = extractUserId(principal);
        if (userId != null) {
            onlineUsers.remove(userId);
            log.info("用户下线: userId={}, sessionId={}", userId, sessionId);
        }
    }

    /**
     * 检查用户是否在线
     */
    public boolean isUserOnline(Long userId) {
        return onlineUsers.containsKey(userId);
    }

    /**
     * 获取在线用户数量
     */
    public int getOnlineUserCount() {
        return onlineUsers.size();
    }

    /**
     * 从 Principal 中提取用户ID
     */
    private Long extractUserId(Principal principal) {
        if (principal instanceof UsernamePasswordAuthenticationToken auth) {
            Object principalObj = auth.getPrincipal();
            if (principalObj instanceof Long userId) {
                return userId;
            }
        }
        return null;
    }
}
