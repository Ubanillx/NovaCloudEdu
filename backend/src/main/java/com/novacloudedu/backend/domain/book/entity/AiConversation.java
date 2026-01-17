package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.AiConversationId;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.ConversationType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * AI对话实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AiConversation {

    private AiConversationId id;
    private UserId userId;
    private BookId bookId;
    private ChapterId chapterId;
    private ConversationType conversationType;
    private List<ConversationMessage> messages;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 对话消息
     */
    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class ConversationMessage {
        private String role;  // user, assistant, system
        private String content;
        private LocalDateTime timestamp;

        public static ConversationMessage create(String role, String content) {
            if (role == null || role.trim().isEmpty()) {
                throw new IllegalArgumentException("角色不能为空");
            }
            if (content == null || content.trim().isEmpty()) {
                throw new IllegalArgumentException("消息内容不能为空");
            }

            ConversationMessage message = new ConversationMessage();
            message.role = role.trim();
            message.content = content.trim();
            message.timestamp = LocalDateTime.now();
            return message;
        }
    }

    /**
     * 创建新对话
     */
    public static AiConversation create(UserId userId, BookId bookId, ChapterId chapterId,
                                       ConversationType conversationType) {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        if (bookId == null) {
            throw new IllegalArgumentException("书籍ID不能为空");
        }
        if (conversationType == null) {
            throw new IllegalArgumentException("对话类型不能为空");
        }

        AiConversation conversation = new AiConversation();
        conversation.userId = userId;
        conversation.bookId = bookId;
        conversation.chapterId = chapterId;
        conversation.conversationType = conversationType;
        conversation.messages = new ArrayList<>();
        conversation.createTime = LocalDateTime.now();
        conversation.updateTime = LocalDateTime.now();
        return conversation;
    }

    /**
     * 重构对话（从数据库加载）
     */
    public static AiConversation reconstruct(AiConversationId id, UserId userId, BookId bookId,
                                            ChapterId chapterId, ConversationType conversationType,
                                            List<ConversationMessage> messages,
                                            LocalDateTime createTime, LocalDateTime updateTime) {
        AiConversation conversation = new AiConversation();
        conversation.id = id;
        conversation.userId = userId;
        conversation.bookId = bookId;
        conversation.chapterId = chapterId;
        conversation.conversationType = conversationType;
        conversation.messages = messages != null ? new ArrayList<>(messages) : new ArrayList<>();
        conversation.createTime = createTime;
        conversation.updateTime = updateTime;
        return conversation;
    }

    /**
     * 添加用户消息
     */
    public void addUserMessage(String content) {
        ConversationMessage message = ConversationMessage.create("user", content);
        this.messages.add(message);
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 添加AI回复
     */
    public void addAssistantMessage(String content) {
        ConversationMessage message = ConversationMessage.create("assistant", content);
        this.messages.add(message);
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 添加系统消息
     */
    public void addSystemMessage(String content) {
        ConversationMessage message = ConversationMessage.create("system", content);
        this.messages.add(message);
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 获取最近N条消息
     */
    public List<ConversationMessage> getRecentMessages(int count) {
        if (count <= 0) {
            return new ArrayList<>();
        }
        int size = messages.size();
        int fromIndex = Math.max(0, size - count);
        return new ArrayList<>(messages.subList(fromIndex, size));
    }

    /**
     * 清空对话历史
     */
    public void clearMessages() {
        this.messages.clear();
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 获取消息总数
     */
    public int getMessageCount() {
        return messages.size();
    }
}
