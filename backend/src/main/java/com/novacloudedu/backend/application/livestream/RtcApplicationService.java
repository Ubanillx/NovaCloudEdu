package com.novacloudedu.backend.application.livestream;

import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.repository.FriendRelationshipRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateChatSessionRepository;
import com.novacloudedu.backend.domain.social.repository.PrivateMessageRepository;
import com.novacloudedu.backend.domain.social.valueobject.MessageType;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.CallRecordMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CallRecordPO;
import com.novacloudedu.backend.interfaces.websocket.dto.ChatMessageResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

/**
 * RTC 通话应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class RtcApplicationService {

    private final FriendRelationshipRepository friendRelationshipRepository;
    private final UserRepository userRepository;
    private final CallRecordMapper callRecordMapper;
    private final PrivateMessageRepository privateMessageRepository;
    private final PrivateChatSessionRepository privateChatSessionRepository;
    private final SimpMessagingTemplate messagingTemplate;

    /**
     * 校验通话权限
     */
    public PermissionResult checkCallPermission(Long callerId, Long calleeId) {
        // 检查好友关系
        boolean isFriend = friendRelationshipRepository.findByUserIds(UserId.of(callerId), UserId.of(calleeId)).isPresent();
        if (!isFriend) {
            return new PermissionResult(false, "非好友关系，无法发起通话", null, null);
        }
        // 查询主叫方用户信息
        String callerName = "";
        String callerAvatar = "";
        var callerOpt = userRepository.findById(UserId.of(callerId));
        if (callerOpt.isPresent()) {
            User caller = callerOpt.get();
            callerName = caller.getUserName() != null ? caller.getUserName() : "";
            callerAvatar = caller.getUserAvatar() != null ? caller.getUserAvatar() : "";
        }
        return new PermissionResult(true, "ok", callerName, callerAvatar);
    }

    /**
     * 保存通话记录，并写入聊天消息 + STOMP 推送
     */
    @Transactional
    public Long saveCallRecord(String callId, Long callerId, Long calleeId,
                                String mediaType, String status, String mode,
                                LocalDateTime startedAt, LocalDateTime endedAt, Integer duration) {
        // 1. 保存通话记录
        CallRecordPO po = new CallRecordPO();
        po.setCallId(callId);
        po.setCallerId(callerId);
        po.setCalleeId(calleeId);
        po.setMediaType(mediaType);
        po.setStatus(status);
        po.setMode(mode != null ? mode : "p2p");
        po.setStartedAt(startedAt);
        po.setEndedAt(endedAt);
        po.setDuration(duration != null ? duration : 0);
        po.setCreateTime(LocalDateTime.now());
        callRecordMapper.insert(po);
        log.info("通话记录已保存: callId={}, id={}", callId, po.getId());

        // 2. 构建通话消息内容（JSON）
        String callContent = String.format(
                "{\"mediaType\":\"%s\",\"status\":\"%s\",\"duration\":%d,\"callId\":\"%s\"}",
                mediaType != null ? mediaType : "audio",
                status != null ? status : "completed",
                duration != null ? duration : 0,
                callId
        );

        // 3. 创建私聊消息（发送者为主叫方）
        UserId senderUserId = UserId.of(callerId);
        UserId receiverUserId = UserId.of(calleeId);
        PrivateMessage message = PrivateMessage.create(senderUserId, receiverUserId, callContent, MessageType.CALL);
        PrivateMessage savedMessage = privateMessageRepository.save(message);

        // 4. 更新会话
        var session = privateChatSessionRepository.getOrCreate(senderUserId, receiverUserId);
        session.updateLastMessageTime(LocalDateTime.now());
        privateChatSessionRepository.update(session);

        // 5. 查询主叫方用户信息
        String callerName = "";
        String callerAvatar = "";
        var callerOpt = userRepository.findById(senderUserId);
        if (callerOpt.isPresent()) {
            User caller = callerOpt.get();
            callerName = caller.getUserName() != null ? caller.getUserName() : "";
            callerAvatar = caller.getUserAvatar() != null ? caller.getUserAvatar() : "";
        }

        // 6. STOMP 推送给双方
        ChatMessageResponse response = ChatMessageResponse.builder()
                .messageId(savedMessage.getId().value())
                .senderId(callerId)
                .senderName(callerName)
                .senderAvatar(callerAvatar)
                .receiverId(calleeId)
                .content(callContent)
                .type("CALL")
                .createTime(savedMessage.getCreateTime())
                .isRead(false)
                .build();

        messagingTemplate.convertAndSendToUser(String.valueOf(callerId), "/queue/messages", response);
        messagingTemplate.convertAndSendToUser(String.valueOf(calleeId), "/queue/messages", response);

        log.info("通话聊天消息已推送: callId={}, messageId={}, status={}", callId, savedMessage.getId().value(), status);
        return po.getId();
    }

    /**
     * 权限校验结果
     */
    public record PermissionResult(boolean allowed, String reason, String callerName, String callerAvatar) {}
}
