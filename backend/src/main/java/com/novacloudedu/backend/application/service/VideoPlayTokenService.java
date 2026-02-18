package com.novacloudedu.backend.application.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * 视频播放令牌服务
 * 生成一次性短期 Token，用于密钥分发接口的身份验证
 * 播放器加载 m3u8 时，Key URI 中携带此 Token
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class VideoPlayTokenService {

    private static final String TOKEN_PREFIX = "video:play-token:";
    private static final long TOKEN_EXPIRE_MINUTES = 5; // Token 有效期 5 分钟

    private final StringRedisTemplate redisTemplate;

    /**
     * 生成播放令牌
     * @param userId 用户ID
     * @param keyId 密钥ID
     * @return 一次性播放令牌
     */
    public String generateToken(Long userId, String keyId) {
        String token = UUID.randomUUID().toString().replace("-", "");
        String value = userId + ":" + keyId;
        redisTemplate.opsForValue().set(TOKEN_PREFIX + token, value, TOKEN_EXPIRE_MINUTES, TimeUnit.MINUTES);
        log.debug("播放令牌已生成, token={}, userId={}, keyId={}", token, userId, keyId);
        return token;
    }

    /**
     * 验证并消费播放令牌（一次性使用）
     * @param token 播放令牌
     * @param keyId 期望的密钥ID
     * @return 验证通过返回 true，否则返回 false
     */
    public boolean validateAndConsume(String token, String keyId) {
        if (token == null || token.isBlank() || keyId == null || keyId.isBlank()) {
            return false;
        }

        String value = redisTemplate.opsForValue().get(TOKEN_PREFIX + token);
        if (value == null) {
            log.warn("播放令牌不存在或已过期, token={}", token);
            return false;
        }

        // 验证 keyId 是否匹配
        String expectedKeyId = value.contains(":") ? value.split(":")[1] : "";
        if (!keyId.equals(expectedKeyId)) {
            log.warn("播放令牌 keyId 不匹配, token={}, expected={}, actual={}", token, expectedKeyId, keyId);
            return false;
        }

        // 消费令牌（一次性使用）
        redisTemplate.delete(TOKEN_PREFIX + token);
        log.debug("播放令牌已消费, token={}", token);
        return true;
    }
}
