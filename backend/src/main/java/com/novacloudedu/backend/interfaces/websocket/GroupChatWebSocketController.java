package com.novacloudedu.backend.interfaces.websocket;

import com.novacloudedu.backend.application.service.GroupChatApplicationService;
import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.valueobject.MessageType;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.websocket.dto.GroupMessageDTO;
import com.novacloudedu.backend.interfaces.websocket.dto.GroupMessageResponse;
import com.novacloudedu.backend.interfaces.websocket.dto.GroupReadReceiptDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;

import java.security.Principal;

/**
 * 群聊 WebSocket 控制器
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class GroupChatWebSocketController {

    private final GroupChatApplicationService groupChatService;
    private final UserRepository userRepository;
    private final SimpMessagingTemplate messagingTemplate;

    /**
     * 发送群消息
     * 客户端发送到: /app/group.send
     * 服务端推送到: /topic/group/{groupId}
     */
    @MessageMapping("/group.send")
    public void sendMessage(@Payload GroupMessageDTO messageDTO, Principal principal) {
        Long senderId = extractUserId(principal);
        if (senderId == null) {
            log.warn("群消息发送失败: 用户未认证");
            return;
        }

        try {
            // 发送消息
            GroupMessage message = groupChatService.sendMessage(
                    messageDTO.getGroupId(),
                    senderId,
                    messageDTO.getContent(),
                    MessageType.fromValue(messageDTO.getType()),
                    messageDTO.getReplyTo()
            );

            // 获取发送者信息
            User sender = userRepository.findById(UserId.of(senderId)).orElse(null);
            String senderName = sender != null ? sender.getUserName() : "未知用户";
            String senderAvatar = sender != null ? sender.getUserAvatar() : null;

            // 构建响应
            GroupMessageResponse response = GroupMessageResponse.from(message)
                    .withSenderInfo(senderName, senderAvatar);

            // 推送到群主题，所有订阅该群的用户都会收到
            String destination = "/topic/group/" + messageDTO.getGroupId();
            messagingTemplate.convertAndSend(destination, response);

            log.debug("群消息已推送: groupId={}, senderId={}, messageId={}",
                    messageDTO.getGroupId(), senderId, message.getId().value());

        } catch (Exception e) {
            log.error("群消息发送失败: senderId={}, groupId={}, error={}",
                    senderId, messageDTO.getGroupId(), e.getMessage());
            // 发送错误通知给发送者
            sendErrorToUser(senderId, "群消息发送失败: " + e.getMessage());
        }
    }

    /**
     * 群消息已读回执
     * 客户端发送到: /app/group.read
     */
    @MessageMapping("/group.read")
    public void markAsRead(@Payload GroupReadReceiptDTO receiptDTO, Principal principal) {
        Long userId = extractUserId(principal);
        if (userId == null) {
            log.warn("已读标记失败: 用户未认证");
            return;
        }

        try {
            groupChatService.markAsRead(receiptDTO.getGroupId(), userId, receiptDTO.getMessageId());
            log.debug("群消息已标记已读: groupId={}, userId={}, upToMessageId={}",
                    receiptDTO.getGroupId(), userId, receiptDTO.getMessageId());
        } catch (Exception e) {
            log.error("已读标记失败: userId={}, groupId={}, error={}",
                    userId, receiptDTO.getGroupId(), e.getMessage());
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

    /**
     * 发送错误消息给用户
     */
    private void sendErrorToUser(Long userId, String errorMessage) {
        messagingTemplate.convertAndSendToUser(
                userId.toString(),
                "/queue/errors",
                errorMessage
        );
    }
}
