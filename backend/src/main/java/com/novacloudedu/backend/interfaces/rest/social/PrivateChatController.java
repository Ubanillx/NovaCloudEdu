package com.novacloudedu.backend.interfaces.rest.social;

import com.novacloudedu.backend.application.service.PrivateChatApplicationService;
import com.novacloudedu.backend.application.service.PrivateChatApplicationService.SessionInfo;
import com.novacloudedu.backend.application.social.query.ChatHistoryQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.repository.PrivateMessageRepository.MessagePage;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.rest.social.dto.request.ChatHistoryRequestDTO;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.ChatMessagePageResponse;
import com.novacloudedu.backend.interfaces.rest.social.dto.response.ChatSessionResponse;
import com.novacloudedu.backend.interfaces.websocket.dto.ChatMessageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 私聊 REST 控制器
 */
@Tag(name = "私聊管理", description = "私聊相关接口")
@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
@Slf4j
public class PrivateChatController {

    private final PrivateChatApplicationService privateChatApplicationService;
    private final UserRepository userRepository;

    /**
     * 获取聊天历史记录
     */
    @Operation(summary = "获取聊天历史", description = "获取与指定用户的聊天历史记录")
    @PostMapping("/history")
    public BaseResponse<ChatMessagePageResponse> getChatHistory(@RequestBody @Valid ChatHistoryRequestDTO request) {
        Long userId = getCurrentUserId();

        // 如果使用游标分页
        if (request.getBeforeMessageId() != null) {
            List<PrivateMessage> messages = privateChatApplicationService.getChatHistoryBefore(
                    userId,
                    request.getPartnerId(),
                    request.getBeforeMessageId(),
                    request.getSize()
            );

            Map<Long, User> userMap = getUserMapFromMessages(messages);
            List<ChatMessageResponse> messageResponses = messages.stream()
                    .map(m -> toMessageResponse(m, userMap))
                    .toList();

            ChatMessagePageResponse response = ChatMessagePageResponse.builder()
                    .messages(messageResponses)
                    .total(messageResponses.size())
                    .page(1)
                    .size(request.getSize())
                    .hasMore(messageResponses.size() >= request.getSize())
                    .build();

            return ResultUtils.success(response);
        }

        // 使用普通分页
        ChatHistoryQuery query = new ChatHistoryQuery(
                userId,
                request.getPartnerId(),
                request.getPage(),
                request.getSize()
        );

        MessagePage page = privateChatApplicationService.getChatHistory(query);
        Map<Long, User> userMap = getUserMapFromMessages(page.messages());

        List<ChatMessageResponse> messageResponses = page.messages().stream()
                .map(m -> toMessageResponse(m, userMap))
                .toList();

        ChatMessagePageResponse response = ChatMessagePageResponse.builder()
                .messages(messageResponses)
                .total(page.total())
                .page(page.page())
                .size(page.size())
                .totalPages(page.totalPages())
                .hasMore(page.hasMore())
                .build();

        return ResultUtils.success(response);
    }

    /**
     * 获取会话列表
     */
    @Operation(summary = "获取会话列表", description = "获取当前用户的所有私聊会话")
    @GetMapping("/sessions")
    public BaseResponse<List<ChatSessionResponse>> getSessionList() {
        Long userId = getCurrentUserId();
        List<SessionInfo> sessions = privateChatApplicationService.getSessionList(userId);

        List<ChatSessionResponse> response = sessions.stream()
                .map(s -> ChatSessionResponse.builder()
                        .sessionId(s.sessionId())
                        .partnerId(s.partnerId())
                        .partnerName(s.partnerName())
                        .partnerAvatar(s.partnerAvatar())
                        .lastMessageTime(s.lastMessageTime())
                        .unreadCount(s.unreadCount())
                        .build())
                .toList();

        return ResultUtils.success(response);
    }

    /**
     * 标记消息为已读
     */
    @Operation(summary = "标记消息已读", description = "标记与指定用户的消息为已读")
    @PostMapping("/read/{senderId}")
    public BaseResponse<Boolean> markAsRead(@PathVariable Long senderId) {
        Long userId = getCurrentUserId();
        privateChatApplicationService.markMessagesAsRead(userId, senderId);
        return ResultUtils.success(true);
    }

    /**
     * 获取未读消息总数
     */
    @Operation(summary = "获取未读消息数", description = "获取当前用户的未读消息总数")
    @GetMapping("/unread/count")
    public BaseResponse<Integer> getUnreadCount() {
        Long userId = getCurrentUserId();
        int count = privateChatApplicationService.getTotalUnreadCount(userId);
        return ResultUtils.success(count);
    }

    // ==================== 辅助方法 ====================

    private Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof Long userId) {
            return userId;
        }
        return null;
    }

    private Map<Long, User> getUserMapFromMessages(List<PrivateMessage> messages) {
        Set<Long> userIds = messages.stream()
                .flatMap(m -> List.of(m.getSenderId().value(), m.getReceiverId().value()).stream())
                .collect(Collectors.toSet());

        if (userIds.isEmpty()) {
            return Map.of();
        }

        List<UserId> userIdList = userIds.stream().map(UserId::of).toList();
        List<User> users = userRepository.findByIds(userIdList);
        return users.stream().collect(Collectors.toMap(u -> u.getId().value(), u -> u));
    }

    private ChatMessageResponse toMessageResponse(PrivateMessage message, Map<Long, User> userMap) {
        User sender = userMap.get(message.getSenderId().value());
        return ChatMessageResponse.builder()
                .messageId(message.getId().value())
                .senderId(message.getSenderId().value())
                .senderName(sender != null ? sender.getUserName() : "未知用户")
                .senderAvatar(sender != null ? sender.getUserAvatar() : null)
                .receiverId(message.getReceiverId().value())
                .content(message.getContent())
                .type(message.getType().getValue())
                .createTime(message.getCreateTime())
                .isRead(message.isRead())
                .build();
    }
}
