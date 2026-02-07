package com.novacloudedu.backend.interfaces.websocket.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群消息已读回执响应 DTO（WebSocket 推送）
 */
@Data
public class GroupReadReceiptResponse {

    private Long messageId;
    private Long groupId;
    private Long readerId;
    private String readerName;
    private String readerAvatar;
    private int totalReadCount;
    private LocalDateTime readTime;
}
