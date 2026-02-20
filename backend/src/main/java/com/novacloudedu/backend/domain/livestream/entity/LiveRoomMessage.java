package com.novacloudedu.backend.domain.livestream.entity;

import com.novacloudedu.backend.domain.livestream.valueobject.LiveMessageType;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomId;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomMessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 直播间聊天消息实体
 */
@Getter
public class LiveRoomMessage {

    private LiveRoomMessageId id;
    private LiveRoomId roomId;
    private UserId senderId;
    private String content;
    private LiveMessageType messageType;
    private LocalDateTime createTime;
    private boolean isDelete;

    private LiveRoomMessage() {}

    /**
     * 创建用户消息
     */
    public static LiveRoomMessage createUserMessage(LiveRoomId roomId, UserId senderId, String content) {
        LiveRoomMessage message = new LiveRoomMessage();
        message.roomId = roomId;
        message.senderId = senderId;
        message.content = content;
        message.messageType = LiveMessageType.TEXT;
        message.createTime = LocalDateTime.now();
        message.isDelete = false;
        return message;
    }

    /**
     * 创建系统消息
     */
    public static LiveRoomMessage createSystemMessage(LiveRoomId roomId, String content) {
        LiveRoomMessage message = new LiveRoomMessage();
        message.roomId = roomId;
        message.content = content;
        message.messageType = LiveMessageType.SYSTEM;
        message.createTime = LocalDateTime.now();
        message.isDelete = false;
        return message;
    }

    /**
     * 重建（从数据库恢复）
     */
    public static LiveRoomMessage reconstruct(LiveRoomMessageId id, LiveRoomId roomId, UserId senderId,
                                               String content, LiveMessageType messageType,
                                               LocalDateTime createTime, boolean isDelete) {
        LiveRoomMessage message = new LiveRoomMessage();
        message.id = id;
        message.roomId = roomId;
        message.senderId = senderId;
        message.content = content;
        message.messageType = messageType;
        message.createTime = createTime;
        message.isDelete = isDelete;
        return message;
    }

    /**
     * 分配ID
     */
    public void assignId(LiveRoomMessageId id) {
        this.id = id;
    }

    /**
     * 删除消息
     */
    public void delete() {
        this.isDelete = true;
    }
}
