package com.novacloudedu.backend.domain.livestream.valueobject;

/**
 * 直播间状态枚举
 */
public enum LiveRoomStatus {
    CREATED("CREATED"),
    LIVE("LIVE"),
    ENDED("ENDED");

    private final String value;

    LiveRoomStatus(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static LiveRoomStatus fromValue(String value) {
        for (LiveRoomStatus status : values()) {
            if (status.value.equalsIgnoreCase(value)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的直播间状态: " + value);
    }
}
