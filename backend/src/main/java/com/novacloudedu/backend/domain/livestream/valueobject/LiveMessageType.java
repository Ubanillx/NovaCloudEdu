package com.novacloudedu.backend.domain.livestream.valueobject;

/**
 * 直播间消息类型枚举
 */
public enum LiveMessageType {
    TEXT("TEXT"),
    SYSTEM("SYSTEM"),
    GIFT("GIFT");

    private final String value;

    LiveMessageType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static LiveMessageType fromValue(String value) {
        for (LiveMessageType type : values()) {
            if (type.value.equalsIgnoreCase(value)) {
                return type;
            }
        }
        throw new IllegalArgumentException("未知的直播消息类型: " + value);
    }
}
