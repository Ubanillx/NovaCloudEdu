package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.AiChatMessageId;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * AI聊天消息实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AiChatMessage {

    private AiChatMessageId id;
    private AiChatSessionId sessionId;
    private UserId userId;
    private String role;
    private String content;
    private List<String> attachments;
    private boolean summarized;
    private LocalDateTime createTime;

    /**
     * 创建新消息
     */
    public static AiChatMessage create(AiChatSessionId sessionId, UserId userId,
                                        String role, String content, List<String> attachments) {
        if (sessionId == null) {
            throw new IllegalArgumentException("会话ID不能为空");
        }
        if (role == null || role.trim().isEmpty()) {
            throw new IllegalArgumentException("角色不能为空");
        }
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("消息内容不能为空");
        }

        AiChatMessage message = new AiChatMessage();
        message.sessionId = sessionId;
        message.userId = userId;
        message.role = role.trim();
        message.content = content.trim();
        message.attachments = attachments != null ? new ArrayList<>(attachments) : new ArrayList<>();
        message.summarized = false;
        message.createTime = LocalDateTime.now();
        return message;
    }

    /**
     * 重构（从数据库加载）
     */
    public static AiChatMessage reconstruct(AiChatMessageId id, AiChatSessionId sessionId, UserId userId,
                                             String role, String content, List<String> attachments,
                                             boolean summarized, LocalDateTime createTime) {
        AiChatMessage message = new AiChatMessage();
        message.id = id;
        message.sessionId = sessionId;
        message.userId = userId;
        message.role = role;
        message.content = content;
        message.attachments = attachments != null ? new ArrayList<>(attachments) : new ArrayList<>();
        message.summarized = summarized;
        message.createTime = createTime;
        return message;
    }

    /**
     * 标记为已摘要
     */
    public void markAsSummarized() {
        this.summarized = true;
    }
}
