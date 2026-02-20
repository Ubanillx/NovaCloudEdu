package com.novacloudedu.backend.domain.livestream.valueobject;

/**
 * 直播间消息ID值对象
 */
public record LiveRoomMessageId(Long value) {
    public static LiveRoomMessageId of(Long value) {
        return new LiveRoomMessageId(value);
    }
}
