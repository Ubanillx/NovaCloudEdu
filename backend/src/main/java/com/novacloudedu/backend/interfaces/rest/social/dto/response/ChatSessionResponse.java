package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 聊天会话响应 DTO
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatSessionResponse {

    /**
     * 会话ID
     */
    private Long sessionId;

    /**
     * 对方用户ID
     */
    private Long partnerId;

    /**
     * 对方用户名
     */
    private String partnerName;

    /**
     * 对方头像
     */
    private String partnerAvatar;

    /**
     * 最后消息时间
     */
    private LocalDateTime lastMessageTime;

    /**
     * 未读消息数
     */
    private int unreadCount;
}
