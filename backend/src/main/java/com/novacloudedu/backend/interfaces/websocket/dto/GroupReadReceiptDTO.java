package com.novacloudedu.backend.interfaces.websocket.dto;

import lombok.Data;

/**
 * 群消息已读回执 DTO
 */
@Data
public class GroupReadReceiptDTO {

    /**
     * 群ID
     */
    private Long groupId;

    /**
     * 最新已读消息ID
     */
    private Long messageId;
}
