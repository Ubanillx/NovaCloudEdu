package com.novacloudedu.backend.infrastructure.video;

import com.novacloudedu.backend.domain.course.service.VideoEncryptionKeyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.util.Base64;
import java.util.UUID;

/**
 * 视频加密密钥管理服务 - Redis 实现
 * AES-128 密钥以 Base64 编码存储在 Redis 中，永不过期
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class VideoEncryptionKeyServiceImpl implements VideoEncryptionKeyService {

    private static final String KEY_PREFIX = "video:key:";
    private static final int AES_KEY_SIZE = 16; // AES-128 = 16 bytes

    private final StringRedisTemplate redisTemplate;

    @Override
    public String generateAndStoreKey() {
        // 生成 16 字节随机 AES-128 密钥
        byte[] key = new byte[AES_KEY_SIZE];
        new SecureRandom().nextBytes(key);

        // 生成唯一 keyId
        String keyId = UUID.randomUUID().toString().replace("-", "");

        // Base64 编码后存入 Redis（永不过期）
        String keyBase64 = Base64.getEncoder().encodeToString(key);
        redisTemplate.opsForValue().set(KEY_PREFIX + keyId, keyBase64);

        log.info("视频加密密钥已生成并存储, keyId={}", keyId);
        return keyId;
    }

    @Override
    public byte[] getKey(String keyId) {
        if (keyId == null || keyId.isBlank()) {
            return null;
        }
        String keyBase64 = redisTemplate.opsForValue().get(KEY_PREFIX + keyId);
        if (keyBase64 == null) {
            log.warn("视频加密密钥不存在, keyId={}", keyId);
            return null;
        }
        return Base64.getDecoder().decode(keyBase64);
    }

    @Override
    public void deleteKey(String keyId) {
        if (keyId != null && !keyId.isBlank()) {
            redisTemplate.delete(KEY_PREFIX + keyId);
            log.info("视频加密密钥已删除, keyId={}", keyId);
        }
    }
}
