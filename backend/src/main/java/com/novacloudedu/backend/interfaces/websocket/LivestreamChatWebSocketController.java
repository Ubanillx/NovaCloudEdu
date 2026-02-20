package com.novacloudedu.backend.interfaces.websocket;

import com.novacloudedu.backend.application.livestream.LivestreamApplicationService;
import com.novacloudedu.backend.domain.livestream.entity.LiveRoomMessage;
import com.novacloudedu.backend.interfaces.rest.livestream.dto.LiveRoomMessageResponse;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.security.Principal;

/**
 * 直播间聊天 WebSocket 控制器
 * 客户端订阅: /topic/livestream/{roomId}
 * 客户端发送: /app/livestream.send
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class LivestreamChatWebSocketController {

    private final SimpMessagingTemplate messagingTemplate;
    private final LivestreamApplicationService livestreamService;

    /**
     * 接收直播间聊天消息
     */
    @MessageMapping("/livestream.send")
    public void sendMessage(LivestreamChatMessage chatMessage, Principal principal) {
        if (principal == null) {
            log.warn("未认证用户尝试发送直播间消息");
            return;
        }
        Long senderId = Long.parseLong(principal.getName());
        Long roomId = chatMessage.getRoomId();

        // 持久化消息
        LiveRoomMessage saved = livestreamService.saveChatMessage(roomId, senderId, chatMessage.getContent());

        // 构建响应
        LiveRoomMessageResponse response = LiveRoomMessageResponse.fromDomain(saved);

        // 广播到直播间频道
        messagingTemplate.convertAndSend("/topic/livestream/" + roomId, response);

        log.debug("直播间消息: roomId={}, senderId={}", roomId, senderId);
    }

    /**
     * 直播间聊天消息请求体
     */
    @Data
    public static class LivestreamChatMessage {
        private Long roomId;
        private String content;
    }
}
