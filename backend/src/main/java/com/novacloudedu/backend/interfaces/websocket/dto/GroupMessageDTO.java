package com.novacloudedu.backend.interfaces.websocket.dto;

import lombok.Data;

/**
 * 群消息 WebSocket DTO
 */
@Data
public class GroupMessageDTO {

    /**
     * 群ID
     */
    private Long groupId;

    /**
     * 消息内容
     */
    private String content;

    /**
     * 消息类型：text/image/file/audio/video
     */
    private String type;

    /**
     * 回复的消息ID（可选）
     */
    private Long replyTo;
}
