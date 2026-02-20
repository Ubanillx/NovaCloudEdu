package com.novacloudedu.backend.domain.livestream.valueobject;

import java.util.UUID;

/**
 * 推流密钥值对象
 */
public record StreamKey(String value) {

    public static StreamKey of(String value) {
        return new StreamKey(value);
    }

    /**
     * 生成随机推流密钥
     */
    public static StreamKey generate() {
        String key = UUID.randomUUID().toString().replace("-", "");
        return new StreamKey(key);
    }
}
