package com.novacloudedu.backend.interfaces.websocket.dto;

import lombok.Data;

/**
 * 已读回执 DTO
 */
@Data
public class ReadReceiptDTO {

    /**
     * 消息发送者ID（对方）
     */
    private Long senderId;
}
