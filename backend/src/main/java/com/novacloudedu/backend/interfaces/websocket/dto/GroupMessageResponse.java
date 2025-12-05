package com.novacloudedu.backend.interfaces.websocket.dto;

import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群消息响应 DTO
 */
@Data
public class GroupMessageResponse {

    private Long messageId;
    private Long groupId;
    private int senderType;
    private Long senderId;
    private Long aiRoleId;
    private String senderName;
    private String senderAvatar;
    private String content;
    private String type;
    private Long replyTo;
    private LocalDateTime createTime;

    public static GroupMessageResponse from(GroupMessage message) {
        GroupMessageResponse response = new GroupMessageResponse();
        response.setMessageId(message.getId().value());
        response.setGroupId(message.getGroupId().value());
        response.setSenderType(message.getSenderType().getCode());
        if (message.getSenderId() != null) {
            response.setSenderId(message.getSenderId().value());
        }
        response.setAiRoleId(message.getAiRoleId());
        response.setContent(message.getContent());
        response.setType(message.getType().getValue());
        if (message.getReplyTo() != null) {
            response.setReplyTo(message.getReplyTo().value());
        }
        response.setCreateTime(message.getCreateTime());
        return response;
    }

    public GroupMessageResponse withSenderInfo(String name, String avatar) {
        this.senderName = name;
        this.senderAvatar = avatar;
        return this;
    }
}
