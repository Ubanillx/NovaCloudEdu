package com.novacloudedu.backend.interfaces.rest.livestream.dto;

import com.novacloudedu.backend.domain.livestream.entity.LiveRoomMessage;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 直播间消息响应
 */
@Data
@Builder
public class LiveRoomMessageResponse {
    private Long id;
    private Long roomId;
    private Long senderId;
    private String senderName;
    private String senderAvatar;
    private String content;
    private String messageType;
    private LocalDateTime createTime;

    public static LiveRoomMessageResponse fromDomain(LiveRoomMessage message) {
        return LiveRoomMessageResponse.builder()
                .id(message.getId().value())
                .roomId(message.getRoomId().value())
                .senderId(message.getSenderId() != null ? message.getSenderId().value() : null)
                .content(message.getContent())
                .messageType(message.getMessageType().getValue())
                .createTime(message.getCreateTime())
                .build();
    }
}
