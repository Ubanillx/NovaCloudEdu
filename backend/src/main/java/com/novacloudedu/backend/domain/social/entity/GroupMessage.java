package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 群消息实体
 */
@Getter
public class GroupMessage {

    private GroupMessageId id;
    private GroupId groupId;
    private SenderType senderType;
    private UserId senderId;
    private Long aiRoleId;
    private String content;
    private MessageType type;
    private GroupMessageId replyTo;
    private LocalDateTime createTime;
    private boolean isDelete;

    private GroupMessage() {}

    /**
     * 创建用户发送的消息
     */
    public static GroupMessage createUserMessage(GroupId groupId, UserId senderId, 
                                                  String content, MessageType type, 
                                                  GroupMessageId replyTo) {
        GroupMessage message = new GroupMessage();
        message.groupId = groupId;
        message.senderType = SenderType.USER;
        message.senderId = senderId;
        message.content = content;
        message.type = type;
        message.replyTo = replyTo;
        message.createTime = LocalDateTime.now();
        message.isDelete = false;
        return message;
    }

    /**
     * 创建AI角色发送的消息
     */
    public static GroupMessage createAiMessage(GroupId groupId, Long aiRoleId,
                                                String content, MessageType type,
                                                GroupMessageId replyTo) {
        GroupMessage message = new GroupMessage();
        message.groupId = groupId;
        message.senderType = SenderType.AI_ROLE;
        message.aiRoleId = aiRoleId;
        message.content = content;
        message.type = type;
        message.replyTo = replyTo;
        message.createTime = LocalDateTime.now();
        message.isDelete = false;
        return message;
    }

    /**
     * 重建消息（从数据库恢复）
     */
    public static GroupMessage reconstruct(GroupMessageId id, GroupId groupId, SenderType senderType,
                                           UserId senderId, Long aiRoleId, String content,
                                           MessageType type, GroupMessageId replyTo,
                                           LocalDateTime createTime, boolean isDelete) {
        GroupMessage message = new GroupMessage();
        message.id = id;
        message.groupId = groupId;
        message.senderType = senderType;
        message.senderId = senderId;
        message.aiRoleId = aiRoleId;
        message.content = content;
        message.type = type;
        message.replyTo = replyTo;
        message.createTime = createTime;
        message.isDelete = isDelete;
        return message;
    }

    /**
     * 分配ID
     */
    public void assignId(GroupMessageId id) {
        this.id = id;
    }

    /**
     * 删除消息
     */
    public void delete() {
        this.isDelete = true;
    }
}
