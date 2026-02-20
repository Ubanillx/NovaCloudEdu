package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * AI聊天会话实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AiChatSession {

    private AiChatSessionId id;
    private UserId userId;
    private Long assistantId;
    private String title;
    private String memorySummary;
    private int messageCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新会话
     */
    public static AiChatSession create(UserId userId) {
        return create(userId, null);
    }

    /**
     * 创建关联助手的新会话
     */
    public static AiChatSession create(UserId userId, Long assistantId) {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }

        AiChatSession session = new AiChatSession();
        session.userId = userId;
        session.assistantId = assistantId;
        session.title = null;
        session.memorySummary = null;
        session.messageCount = 0;
        session.createTime = LocalDateTime.now();
        session.updateTime = LocalDateTime.now();
        return session;
    }

    /**
     * 重构（从数据库加载）
     */
    public static AiChatSession reconstruct(AiChatSessionId id, UserId userId, Long assistantId,
                                             String title, String memorySummary, int messageCount,
                                             LocalDateTime createTime, LocalDateTime updateTime) {
        AiChatSession session = new AiChatSession();
        session.id = id;
        session.userId = userId;
        session.assistantId = assistantId;
        session.title = title;
        session.memorySummary = memorySummary;
        session.messageCount = messageCount;
        session.createTime = createTime;
        session.updateTime = updateTime;
        return session;
    }

    /**
     * 更新会话标题
     */
    public void updateTitle(String title) {
        this.title = title;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新记忆摘要
     */
    public void updateMemorySummary(String summary) {
        this.memorySummary = summary;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加消息计数
     */
    public void incrementMessageCount(int count) {
        this.messageCount += count;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 检查是否属于指定用户
     */
    public boolean belongsTo(UserId userId) {
        return this.userId.equals(userId);
    }
}
