package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.SessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 私聊会话实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PrivateChatSession {

    private SessionId id;
    private UserId userId1;
    private UserId userId2;
    private LocalDateTime lastMessageTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    /**
     * 创建新会话
     */
    public static PrivateChatSession create(UserId userId1, UserId userId2) {
        PrivateChatSession session = new PrivateChatSession();
        // 保证 userId1 < userId2，确保唯一性
        if (userId1.value() < userId2.value()) {
            session.userId1 = userId1;
            session.userId2 = userId2;
        } else {
            session.userId1 = userId2;
            session.userId2 = userId1;
        }
        session.createTime = LocalDateTime.now();
        session.updateTime = LocalDateTime.now();
        session.isDelete = false;
        return session;
    }

    /**
     * 从持久化数据重建
     */
    public static PrivateChatSession reconstruct(SessionId id, UserId userId1, UserId userId2,
                                                   LocalDateTime lastMessageTime,
                                                   LocalDateTime createTime, LocalDateTime updateTime,
                                                   boolean isDelete) {
        PrivateChatSession session = new PrivateChatSession();
        session.id = id;
        session.userId1 = userId1;
        session.userId2 = userId2;
        session.lastMessageTime = lastMessageTime;
        session.createTime = createTime;
        session.updateTime = updateTime;
        session.isDelete = isDelete;
        return session;
    }

    /**
     * 分配ID
     */
    public void assignId(SessionId id) {
        if (this.id != null) {
            throw new IllegalStateException("会话ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新最后消息时间
     */
    public void updateLastMessageTime(LocalDateTime time) {
        this.lastMessageTime = time;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 检查用户是否在此会话中
     */
    public boolean containsUser(UserId userId) {
        return userId1.equals(userId) || userId2.equals(userId);
    }

    /**
     * 获取另一方用户ID
     */
    public UserId getOtherUserId(UserId userId) {
        if (userId1.equals(userId)) {
            return userId2;
        } else if (userId2.equals(userId)) {
            return userId1;
        }
        throw new IllegalArgumentException("用户不在此会话中");
    }

    /**
     * 软删除
     */
    public void delete() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }
}
