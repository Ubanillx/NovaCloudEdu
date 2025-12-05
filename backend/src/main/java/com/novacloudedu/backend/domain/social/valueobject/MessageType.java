package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 消息类型枚举
 */
public enum MessageType {
    TEXT("text"),
    IMAGE("image"),
    FILE("file"),
    AUDIO("audio"),
    VIDEO("video"),
    SYSTEM("system");

    private final String value;

    MessageType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static MessageType fromValue(String value) {
        for (MessageType type : values()) {
            if (type.value.equalsIgnoreCase(value)) {
                return type;
            }
        }
        throw new IllegalArgumentException("未知的消息类型: " + value);
    }
}
