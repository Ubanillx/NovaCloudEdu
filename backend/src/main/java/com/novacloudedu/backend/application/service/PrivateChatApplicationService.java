package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.social.command.SendPrivateMessageCommand;
import com.novacloudedu.backend.application.social.query.ChatHistoryQuery;
import com.novacloudedu.backend.domain.social.entity.PrivateChatSession;
import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateChatSessionRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateMessageRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateMessageRepository.MessagePage;
import com.novacloudedu.backend.domain.social.valueobject.MessageId;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.common.ErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 私聊应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class PrivateChatApplicationService {

    private final PrivateMessageRepository privateMessageRepository;
    private final PrivateChatSessionRepository privateChatSessionRepository;
    private final FriendRelationshipRepository friendRelationshipRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;

    /**
     * 发送私聊消息
     */
    @Transactional
    public PrivateMessage sendMessage(SendPrivateMessageCommand command) {
        UserId senderId = UserId.of(command.senderId());
        UserId receiverId = UserId.of(command.receiverId());

        // 验证接收者存在
        userRepository.findById(receiverId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "接收用户不存在"));

        // 验证双方是好友关系
        if (!friendRelationshipRepository.areFriends(senderId, receiverId)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "只能给好友发送消息");
        }

        // 创建消息
        PrivateMessage message = PrivateMessage.create(
                senderId,
                receiverId,
                command.content(),
                command.type()
        );

        // 保存消息
        PrivateMessage savedMessage = privateMessageRepository.save(message);

        // 更新或创建会话
        PrivateChatSession session = privateChatSessionRepository.getOrCreate(senderId, receiverId);
        session.updateLastMessageTime(LocalDateTime.now());
        privateChatSessionRepository.update(session);

        log.debug("消息发送成功: senderId={}, receiverId={}, messageId={}",
                command.senderId(), command.receiverId(), savedMessage.getId().value());

        // 发送通知（通知接收者有新消息，接收者通过 HTTP 获取详情）
        User sender = userRepository.findById(senderId).orElse(null);
        String senderName = sender != null ? sender.getUserName() : "未知用户";
        notificationService.notifyNewPrivateMessage(command.receiverId(), command.senderId(), senderName);

        return savedMessage;
    }

    /**
     * 获取聊天历史记录
     */
    public MessagePage getChatHistory(ChatHistoryQuery query) {
        UserId userId = UserId.of(query.userId());
        UserId partnerId = UserId.of(query.partnerId());

        return privateMessageRepository.findBetweenUsers(userId, partnerId, query.page(), query.size());
    }

    /**
     * 获取聊天历史（基于游标分页）
     */
    public List<PrivateMessage> getChatHistoryBefore(Long userId, Long partnerId, Long beforeMessageId, int limit) {
        UserId user = UserId.of(userId);
        UserId partner = UserId.of(partnerId);
        MessageId beforeId = beforeMessageId != null ? MessageId.of(beforeMessageId) : null;

        return privateMessageRepository.findBetweenUsersBefore(user, partner, beforeId, limit);
    }

    /**
     * 标记消息已读
     */
    @Transactional
    public void markMessagesAsRead(Long receiverId, Long senderId) {
        privateMessageRepository.markAllAsReadBetweenUsers(
                UserId.of(senderId),
                UserId.of(receiverId)
        );
        log.debug("消息已标记为已读: senderId={}, receiverId={}", senderId, receiverId);

        // 通知消息发送者，对方已读
        notificationService.notifyPrivateMessageRead(senderId, receiverId);
    }

    /**
     * 获取用户的会话列表
     */
    public List<SessionInfo> getSessionList(Long userId) {
        UserId user = UserId.of(userId);
        List<PrivateChatSession> sessions = privateChatSessionRepository.findByUserId(user);

        // 获取所有对话用户的信息
        List<UserId> partnerIds = sessions.stream()
                .map(s -> s.getOtherUserId(user))
                .toList();
        Map<Long, User> userMap = getUserMap(partnerIds);

        return sessions.stream()
                .map(session -> {
                    UserId partnerId = session.getOtherUserId(user);
                    User partner = userMap.get(partnerId.value());
                    int unreadCount = privateMessageRepository.countUnreadMessages(user, partnerId);

                    return new SessionInfo(
                            session.getId().value(),
                            partnerId.value(),
                            partner != null ? partner.getUserName() : "未知用户",
                            partner != null ? partner.getUserAvatar() : null,
                            session.getLastMessageTime(),
                            unreadCount
                    );
                })
                .toList();
    }

    /**
     * 获取未读消息总数
     */
    public int getTotalUnreadCount(Long userId) {
        UserId user = UserId.of(userId);
        List<PrivateChatSession> sessions = privateChatSessionRepository.findByUserId(user);

        return sessions.stream()
                .mapToInt(session -> {
                    UserId partnerId = session.getOtherUserId(user);
                    return privateMessageRepository.countUnreadMessages(user, partnerId);
                })
                .sum();
    }

    private Map<Long, User> getUserMap(List<UserId> userIds) {
        if (userIds.isEmpty()) {
            return Map.of();
        }
        List<User> users = userRepository.findByIds(userIds);
        return users.stream().collect(Collectors.toMap(u -> u.getId().value(), u -> u));
    }

    /**
     * 会话信息
     */
    public record SessionInfo(
            Long sessionId,
            Long partnerId,
            String partnerName,
            String partnerAvatar,
            LocalDateTime lastMessageTime,
            int unreadCount
    ) {
    }
}
