package com.novacloudedu.backend.interfaces.websocket.dto;

import lombok.Data;

/**
 * WebSocket 聊天消息 DTO
 */
@Data
public class ChatMessageDTO {

    /**
     * 接收者用户ID
     */
    private Long receiverId;

    /**
     * 消息内容
     */
    private String content;

    /**
     * 消息类型：text/image/file/audio/video
     */
    private String type = "text";
}
