package com.novacloudedu.backend.application.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
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
    private static final String HMAC_ALGO = "HmacSHA256";

    private final StringRedisTemplate redisTemplate;

    @Value("${jwt.secret:NovaCloudEduSecretKey123456789012345678901234567890}")
    private String hmacSecret;

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
     * 生成流访问令牌（HMAC 签名，不依赖 Redis）
     * 格式: base64(userId:sectionId:expireTimestamp:hmac)
     * @param userId 用户ID
     * @param sectionId 小节ID
     * @return 签名流访问令牌（5分钟有效）
     */
    public String generateStreamToken(Long userId, Long sectionId) {
        long expireAt = System.currentTimeMillis() + TOKEN_EXPIRE_MINUTES * 60 * 1000;
        String payload = userId + ":" + sectionId + ":" + expireAt;
        String signature = hmacSign(payload);
        String token = Base64.getUrlEncoder().withoutPadding()
                .encodeToString((payload + ":" + signature).getBytes(StandardCharsets.UTF_8));
        log.info("流访问令牌已生成, userId={}, sectionId={}", userId, sectionId);
        return token;
    }

    /**
     * 验证流访问令牌并返回 userId（HMAC 验签，不依赖 Redis）
     * @param token 流访问令牌
     * @param sectionId 期望的小节ID
     * @return 验证通过返回 userId，否则返回 null
     */
    public Long validateStreamToken(String token, Long sectionId) {
        if (token == null || token.isBlank() || sectionId == null) {
            return null;
        }
        try {
            String decoded = new String(
                    Base64.getUrlDecoder().decode(token), StandardCharsets.UTF_8);
            // 格式: userId:sectionId:expireTimestamp:hmac
            String[] parts = decoded.split(":");
            if (parts.length != 4) {
                log.warn("流访问令牌格式无效, token={}", token);
                return null;
            }

            Long tokenUserId = Long.parseLong(parts[0]);
            Long tokenSectionId = Long.parseLong(parts[1]);
            long expireAt = Long.parseLong(parts[2]);
            String signature = parts[3];

            // 1. 验证 sectionId
            if (!sectionId.equals(tokenSectionId)) {
                log.warn("流访问令牌 sectionId 不匹配, expected={}, actual={}", tokenSectionId, sectionId);
                return null;
            }

            // 2. 验证过期时间
            if (System.currentTimeMillis() > expireAt) {
                log.warn("流访问令牌已过期, userId={}, sectionId={}", tokenUserId, sectionId);
                return null;
            }

            // 3. 验证 HMAC 签名
            String payload = tokenUserId + ":" + tokenSectionId + ":" + expireAt;
            String expectedSignature = hmacSign(payload);
            if (!signature.equals(expectedSignature)) {
                log.warn("流访问令牌签名无效, userId={}, sectionId={}", tokenUserId, sectionId);
                return null;
            }

            log.info("流访问令牌验证通过, userId={}, sectionId={}", tokenUserId, sectionId);
            return tokenUserId;
        } catch (Exception e) {
            log.warn("流访问令牌解析失败: {}", e.getMessage());
            return null;
        }
    }

    /**
     * HMAC-SHA256 签名
     */
    private String hmacSign(String data) {
        try {
            Mac mac = Mac.getInstance(HMAC_ALGO);
            SecretKeySpec keySpec = new SecretKeySpec(
                    hmacSecret.getBytes(StandardCharsets.UTF_8), HMAC_ALGO);
            mac.init(keySpec);
            byte[] rawHmac = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return Base64.getUrlEncoder().withoutPadding().encodeToString(rawHmac);
        } catch (Exception e) {
            throw new RuntimeException("HMAC 签名失败", e);
        }
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
