package com.novacloudedu.backend.infrastructure.websocket;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * 离线通知缓存（Redis 实现）
 * 缓存用户离线期间收到的通知，上线后推送
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class OfflineNotificationCache {

    private final StringRedisTemplate redisTemplate;
    private final ObjectMapper objectMapper;

    /**
     * Redis Key 前缀
     */
    private static final String KEY_PREFIX = "notification:offline:";

    /**
     * 每个用户最大缓存通知数量
     */
    private static final int MAX_CACHE_SIZE_PER_USER = 100;

    /**
     * 缓存过期时间（天）
     */
    private static final int EXPIRE_DAYS = 7;

    /**
     * 缓存通知
     */
    public void cacheNotification(Long userId, NotificationEvent event) {
        String key = KEY_PREFIX + userId;
        try {
            String json = objectMapper.writeValueAsString(event);
            
            // 添加到列表尾部
            redisTemplate.opsForList().rightPush(key, json);
            
            // 控制列表大小，超出则移除最旧的
            Long size = redisTemplate.opsForList().size(key);
            if (size != null && size > MAX_CACHE_SIZE_PER_USER) {
                redisTemplate.opsForList().leftPop(key);
            }
            
            // 设置过期时间
            redisTemplate.expire(key, EXPIRE_DAYS, TimeUnit.DAYS);
            
            log.debug("通知已缓存到Redis: userId={}, type={}", userId, event.getType());
        } catch (JsonProcessingException e) {
            log.error("缓存通知失败，序列化错误: userId={}", userId, e);
        }
    }

    /**
     * 批量缓存通知
     */
    public void cacheNotifications(Collection<Long> userIds, NotificationEvent event) {
        for (Long userId : userIds) {
            cacheNotification(userId, event);
        }
    }

    /**
     * 获取并清除用户的所有缓存通知
     */
    public List<NotificationEvent> pollAllNotifications(Long userId) {
        String key = KEY_PREFIX + userId;
        
        // 获取所有通知
        List<String> jsonList = redisTemplate.opsForList().range(key, 0, -1);
        if (jsonList == null || jsonList.isEmpty()) {
            return Collections.emptyList();
        }
        
        // 删除 key
        redisTemplate.delete(key);
        
        // 反序列化
        List<NotificationEvent> notifications = new ArrayList<>();
        for (String json : jsonList) {
            try {
                NotificationEvent event = objectMapper.readValue(json, NotificationEvent.class);
                notifications.add(event);
            } catch (JsonProcessingException e) {
                log.error("反序列化通知失败: {}", json, e);
            }
        }
        
        log.debug("从Redis获取缓存通知: userId={}, count={}", userId, notifications.size());
        return notifications;
    }

    /**
     * 获取用户缓存通知数量
     */
    public int getCacheSize(Long userId) {
        String key = KEY_PREFIX + userId;
        Long size = redisTemplate.opsForList().size(key);
        return size != null ? size.intValue() : 0;
    }

    /**
     * 检查用户是否有缓存通知
     */
    public boolean hasNotifications(Long userId) {
        String key = KEY_PREFIX + userId;
        return Boolean.TRUE.equals(redisTemplate.hasKey(key));
    }

    /**
     * 清除用户的所有缓存通知
     */
    public void clearNotifications(Long userId) {
        String key = KEY_PREFIX + userId;
        redisTemplate.delete(key);
        log.debug("Redis缓存已清除: userId={}", userId);
    }

    /**
     * 获取总缓存用户数（注意：生产环境慎用，可能较慢）
     */
    public int getCachedUserCount() {
        Set<String> keys = redisTemplate.keys(KEY_PREFIX + "*");
        return keys != null ? keys.size() : 0;
    }
}
