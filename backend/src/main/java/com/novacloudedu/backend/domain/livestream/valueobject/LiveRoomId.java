package com.novacloudedu.backend.domain.livestream.valueobject;

/**
 * 直播间ID值对象
 */
public record LiveRoomId(Long value) {
    public static LiveRoomId of(Long value) {
        return new LiveRoomId(value);
    }
}
