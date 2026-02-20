package com.novacloudedu.backend.domain.livestream.valueobject;

/**
 * 直播间可见性枚举
 */
public enum LiveRoomVisibility {
    PUBLIC("PUBLIC"),
    CLASS_ONLY("CLASS_ONLY");

    private final String value;

    LiveRoomVisibility(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static LiveRoomVisibility fromValue(String value) {
        for (LiveRoomVisibility visibility : values()) {
            if (visibility.value.equalsIgnoreCase(value)) {
                return visibility;
            }
        }
        throw new IllegalArgumentException("未知的可见性: " + value);
    }
}
