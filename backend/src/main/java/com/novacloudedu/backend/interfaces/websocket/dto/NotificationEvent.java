package com.novacloudedu.backend.interfaces.websocket.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * WebSocket 通知事件 DTO
 * 客户端收到通知后，根据事件类型调用对应的 HTTP API 获取详细数据
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NotificationEvent {

    /**
     * 事件类型
     */
    private EventType type;

    /**
     * 事件相关的数据（轻量级，仅包含ID等必要信息）
     */
    private Map<String, Object> data;

    /**
     * 事件时间
     */
    private LocalDateTime timestamp;

    /**
     * 事件类型枚举
     */
    public enum EventType {
        // ===== 私聊相关 =====
        /** 新私聊消息 - data: {senderId, senderName} */
        NEW_PRIVATE_MESSAGE,
        /** 私聊消息已读 - data: {senderId} */
        PRIVATE_MESSAGE_READ,

        // ===== 群聊相关 =====
        /** 新群消息 - data: {groupId, groupName, senderId} */
        NEW_GROUP_MESSAGE,
        /** 群消息已读 - data: {groupId, messageId, readCount} */
        GROUP_MESSAGE_READ,

        // ===== 好友相关 =====
        /** 收到好友申请 - data: {requestId, senderId, senderName} */
        FRIEND_REQUEST_RECEIVED,
        /** 好友申请被处理 - data: {requestId, accepted} */
        FRIEND_REQUEST_HANDLED,
        /** 新好友 - data: {friendId, friendName} */
        NEW_FRIEND,
        /** 好友删除 - data: {friendId} */
        FRIEND_REMOVED,

        // ===== 群管理相关 =====
        /** 收到入群申请 - data: {groupId, requestId, userId, userName} */
        GROUP_JOIN_REQUEST_RECEIVED,
        /** 入群申请被处理 - data: {groupId, requestId, approved} */
        GROUP_JOIN_REQUEST_HANDLED,
        /** 被邀请入群 - data: {groupId, groupName, inviterId} */
        GROUP_INVITED,
        /** 被移出群 - data: {groupId, groupName} */
        GROUP_REMOVED,
        /** 群信息更新 - data: {groupId} */
        GROUP_UPDATED,
        /** 群解散 - data: {groupId, groupName} */
        GROUP_DISSOLVED,

        // ===== 未读数更新 =====
        /** 未读消息数变化 - data: {privateUnread, groupUnread, totalUnread} */
        UNREAD_COUNT_CHANGED,

        // ===== 系统通知 =====
        /** 系统通知 - data: {title, content} */
        SYSTEM_NOTIFICATION
    }

    /**
     * 创建通知事件
     */
    public static NotificationEvent of(EventType type, Map<String, Object> data) {
        return NotificationEvent.builder()
                .type(type)
                .data(data)
                .timestamp(LocalDateTime.now())
                .build();
    }
}
