package com.novacloudedu.backend.interfaces.websocket;

import com.novacloudedu.backend.application.service.PrivateChatApplicationService;
import com.novacloudedu.backend.application.social.command.SendPrivateMessageCommand;
import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.valueobject.MessageType;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.websocket.dto.ChatMessageDTO;
import com.novacloudedu.backend.interfaces.websocket.dto.ChatMessageResponse;
import com.novacloudedu.backend.interfaces.websocket.dto.ReadReceiptDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;

import java.security.Principal;

/**
 * 私聊 WebSocket 控制器
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class PrivateChatWebSocketController {

    private final SimpMessagingTemplate messagingTemplate;
    private final PrivateChatApplicationService privateChatApplicationService;
    private final UserRepository userRepository;

    /**
     * 处理私聊消息发送
     * 客户端发送到: /app/chat.send
     * 消息推送到: /user/{receiverId}/queue/messages
     */
    @MessageMapping("/chat.send")
    public void sendMessage(@Payload ChatMessageDTO chatMessage, Principal principal) {
        Long senderId = extractUserId(principal);
        if (senderId == null) {
            log.warn("WebSocket消息发送失败: 用户未认证");
            return;
        }

        try {
            // 获取发送者信息
            User sender = userRepository.findById(UserId.of(senderId)).orElse(null);

            // 发送消息
            SendPrivateMessageCommand command = new SendPrivateMessageCommand(
                    senderId,
                    chatMessage.getReceiverId(),
                    chatMessage.getContent(),
                    MessageType.fromValue(chatMessage.getType())
            );

            PrivateMessage message = privateChatApplicationService.sendMessage(command);

            // 构建响应
            ChatMessageResponse response = ChatMessageResponse.builder()
                    .messageId(message.getId().value())
                    .senderId(senderId)
                    .senderName(sender != null ? sender.getUserName() : "未知用户")
                    .senderAvatar(sender != null ? sender.getUserAvatar() : null)
                    .receiverId(chatMessage.getReceiverId())
                    .content(chatMessage.getContent())
                    .type(chatMessage.getType())
                    .createTime(message.getCreateTime())
                    .isRead(false)
                    .build();

            // 推送给接收者
            messagingTemplate.convertAndSendToUser(
                    String.valueOf(chatMessage.getReceiverId()),
                    "/queue/messages",
                    response
            );

            // 也推送给发送者（确认消息已发送）
            messagingTemplate.convertAndSendToUser(
                    String.valueOf(senderId),
                    "/queue/messages",
                    response
            );

            log.debug("私聊消息发送成功: {} -> {}, messageId={}",
                    senderId, chatMessage.getReceiverId(), message.getId().value());

        } catch (Exception e) {
            log.error("私聊消息发送失败: senderId={}, receiverId={}",
                    senderId, chatMessage.getReceiverId(), e);
        }
    }

    /**
     * 处理已读回执
     * 客户端发送到: /app/chat.read
     */
    @MessageMapping("/chat.read")
    public void markAsRead(@Payload ReadReceiptDTO readReceipt, Principal principal) {
        Long receiverId = extractUserId(principal);
        if (receiverId == null) {
            log.warn("标记已读失败: 用户未认证");
            return;
        }

        try {
            privateChatApplicationService.markMessagesAsRead(receiverId, readReceipt.getSenderId());

            // 通知对方消息已读
            messagingTemplate.convertAndSendToUser(
                    String.valueOf(readReceipt.getSenderId()),
                    "/queue/read-receipt",
                    receiverId
            );

            log.debug("消息已标记为已读: senderId={}, receiverId={}",
                    readReceipt.getSenderId(), receiverId);

        } catch (Exception e) {
            log.error("标记已读失败: senderId={}, receiverId={}",
                    readReceipt.getSenderId(), receiverId, e);
        }
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
