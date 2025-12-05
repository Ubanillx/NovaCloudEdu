package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.MessageId;
import com.novacloudedu.backend.domain.social.valueobject.MessageType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 私聊消息实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PrivateMessage {

    private MessageId id;
    private UserId senderId;
    private UserId receiverId;
    private String content;
    private MessageType type;
    private boolean isRead;
    private LocalDateTime createTime;
    private boolean isDelete;

    /**
     * 创建新消息
     */
    public static PrivateMessage create(UserId senderId, UserId receiverId, String content, MessageType type) {
        PrivateMessage message = new PrivateMessage();
        message.senderId = senderId;
        message.receiverId = receiverId;
        message.content = content;
        message.type = type;
        message.isRead = false;
        message.createTime = LocalDateTime.now();
        message.isDelete = false;
        return message;
    }

    /**
     * 从持久化数据重建
     */
    public static PrivateMessage reconstruct(MessageId id, UserId senderId, UserId receiverId,
                                              String content, MessageType type, boolean isRead,
                                              LocalDateTime createTime, boolean isDelete) {
        PrivateMessage message = new PrivateMessage();
        message.id = id;
        message.senderId = senderId;
        message.receiverId = receiverId;
        message.content = content;
        message.type = type;
        message.isRead = isRead;
        message.createTime = createTime;
        message.isDelete = isDelete;
        return message;
    }

    /**
     * 分配ID
     */
    public void assignId(MessageId id) {
        if (this.id != null) {
            throw new IllegalStateException("消息ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 标记为已读
     */
    public void markAsRead() {
        this.isRead = true;
    }

    /**
     * 软删除
     */
    public void delete() {
        this.isDelete = true;
    }

    /**
     * 检查是否为某用户发送或接收的消息
     */
    public boolean belongsTo(UserId userId) {
        return senderId.equals(userId) || receiverId.equals(userId);
    }
}
