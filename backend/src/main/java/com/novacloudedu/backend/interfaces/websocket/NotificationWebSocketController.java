package com.novacloudedu.backend.interfaces.websocket;

import com.novacloudedu.backend.application.service.NotificationService;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.util.Map;

/**
 * 通知 WebSocket 控制器
 * 
 * 客户端订阅:
 * - /user/queue/notifications - 个人通知
 * - /topic/group/{groupId}/notifications - 群通知
 * 
 * 收到通知后，根据事件类型调用对应的 HTTP API 获取详细数据
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class NotificationWebSocketController {

    private final NotificationService notificationService;

    /**
     * 客户端确认收到通知（可选）
     * 客户端发送到: /app/notification.ack
     */
    @MessageMapping("/notification.ack")
    public void acknowledgeNotification(@Payload Map<String, Object> payload, Principal principal) {
        Long userId = extractUserId(principal);
        if (userId == null) {
            return;
        }

        String eventType = (String) payload.get("eventType");
        log.debug("通知已确认: userId={}, eventType={}", userId, eventType);

        // 可以在这里记录通知已读状态，或更新未读计数等
    }

    /**
     * 客户端请求刷新未读数
     * 客户端发送到: /app/notification.refreshUnread
     * 服务端将推送最新未读数到 /user/queue/notifications
     */
    @MessageMapping("/notification.refreshUnread")
    public void refreshUnreadCount(Principal principal) {
        Long userId = extractUserId(principal);
        if (userId == null) {
            return;
        }

        // 这里可以注入相关服务获取未读数，然后推送
        // 示例：通知用户刷新未读数（实际数据由客户端通过 HTTP 获取）
        notificationService.notifyUser(userId, NotificationEvent.EventType.UNREAD_COUNT_CHANGED, Map.of(
                "refresh", true
        ));
    }

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
