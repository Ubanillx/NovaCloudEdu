package com.novacloudedu.backend.notification;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.novacloudedu.backend.infrastructure.websocket.OfflineNotificationCache;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent;
import com.novacloudedu.backend.interfaces.websocket.dto.NotificationEvent.EventType;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 离线通知缓存单元测试
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class OfflineNotificationCacheTest {

    @Mock
    private StringRedisTemplate redisTemplate;

    @Mock
    private ListOperations<String, String> listOperations;

    private OfflineNotificationCache cache;

    private ObjectMapper objectMapper;

    private static final Long USER_ID = 1L;
    private static final String KEY = "notification:offline:1";

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        cache = new OfflineNotificationCache(redisTemplate, objectMapper);

        when(redisTemplate.opsForList()).thenReturn(listOperations);
    }

    // ==================== 缓存通知测试 ====================

    @Test
    @Order(1)
    @DisplayName("缓存通知 - 成功")
    void cacheNotification_Success() {
        when(listOperations.size(KEY)).thenReturn(5L);

        NotificationEvent event = NotificationEvent.of(EventType.NEW_PRIVATE_MESSAGE, Map.of(
                "senderId", 2L,
                "senderName", "张三"
        ));

        // 执行
        cache.cacheNotification(USER_ID, event);

        // 验证 RPUSH
        verify(listOperations, times(1)).rightPush(eq(KEY), anyString());

        // 验证设置过期时间
        verify(redisTemplate, times(1)).expire(KEY, 7, TimeUnit.DAYS);
    }

    @Test
    @Order(2)
    @DisplayName("缓存通知 - 超出限制时移除最旧的")
    void cacheNotification_ExceedLimit_RemoveOldest() {
        // 模拟已有101条（超出100限制）
        when(listOperations.size(KEY)).thenReturn(101L);

        NotificationEvent event = NotificationEvent.of(EventType.NEW_PRIVATE_MESSAGE, Map.of("senderId", 2L));

        // 执行
        cache.cacheNotification(USER_ID, event);

        // 验证：移除最旧的
        verify(listOperations, times(1)).leftPop(KEY);
    }

    @Test
    @Order(3)
    @DisplayName("缓存通知 - 未超限制不移除")
    void cacheNotification_WithinLimit_NoRemove() {
        when(listOperations.size(KEY)).thenReturn(50L);

        NotificationEvent event = NotificationEvent.of(EventType.NEW_PRIVATE_MESSAGE, Map.of("senderId", 2L));

        // 执行
        cache.cacheNotification(USER_ID, event);

        // 验证：不移除
        verify(listOperations, never()).leftPop(anyString());
    }

    // ==================== 获取缓存通知测试 ====================

    @Test
    @Order(4)
    @DisplayName("获取并清除缓存 - 有数据")
    void pollAllNotifications_HasData() throws Exception {
        NotificationEvent event1 = NotificationEvent.of(EventType.NEW_PRIVATE_MESSAGE, Map.of("senderId", 10L));
        NotificationEvent event2 = NotificationEvent.of(EventType.FRIEND_REQUEST_RECEIVED, Map.of("requestId", 20L));

        String json1 = objectMapper.writeValueAsString(event1);
        String json2 = objectMapper.writeValueAsString(event2);

        when(listOperations.range(KEY, 0, -1)).thenReturn(List.of(json1, json2));
        when(redisTemplate.delete(KEY)).thenReturn(true);

        // 执行
        List<NotificationEvent> result = cache.pollAllNotifications(USER_ID);

        // 验证
        assertEquals(2, result.size());
        assertEquals(EventType.NEW_PRIVATE_MESSAGE, result.get(0).getType());
        assertEquals(EventType.FRIEND_REQUEST_RECEIVED, result.get(1).getType());

        // 验证删除 key
        verify(redisTemplate, times(1)).delete(KEY);
    }

    @Test
    @Order(5)
    @DisplayName("获取并清除缓存 - 无数据")
    void pollAllNotifications_NoData() {
        when(listOperations.range(KEY, 0, -1)).thenReturn(List.of());

        // 执行
        List<NotificationEvent> result = cache.pollAllNotifications(USER_ID);

        // 验证
        assertTrue(result.isEmpty());

        // 不应删除 key（因为没数据）
        verify(redisTemplate, never()).delete(KEY);
    }

    @Test
    @Order(6)
    @DisplayName("获取并清除缓存 - null 返回")
    void pollAllNotifications_NullReturn() {
        when(listOperations.range(KEY, 0, -1)).thenReturn(null);

        // 执行
        List<NotificationEvent> result = cache.pollAllNotifications(USER_ID);

        // 验证
        assertTrue(result.isEmpty());
    }

    // ==================== 查询方法测试 ====================

    @Test
    @Order(7)
    @DisplayName("获取缓存大小")
    void getCacheSize() {
        when(listOperations.size(KEY)).thenReturn(10L);

        int size = cache.getCacheSize(USER_ID);

        assertEquals(10, size);
    }

    @Test
    @Order(8)
    @DisplayName("获取缓存大小 - null 返回0")
    void getCacheSize_Null() {
        when(listOperations.size(KEY)).thenReturn(null);

        int size = cache.getCacheSize(USER_ID);

        assertEquals(0, size);
    }

    @Test
    @Order(9)
    @DisplayName("检查是否有缓存 - 有")
    void hasNotifications_True() {
        when(redisTemplate.hasKey(KEY)).thenReturn(true);

        assertTrue(cache.hasNotifications(USER_ID));
    }

    @Test
    @Order(10)
    @DisplayName("检查是否有缓存 - 无")
    void hasNotifications_False() {
        when(redisTemplate.hasKey(KEY)).thenReturn(false);

        assertFalse(cache.hasNotifications(USER_ID));
    }

    // ==================== 清除缓存测试 ====================

    @Test
    @Order(11)
    @DisplayName("清除用户缓存")
    void clearNotifications() {
        // 执行
        cache.clearNotifications(USER_ID);

        // 验证
        verify(redisTemplate, times(1)).delete(KEY);
    }

    // ==================== 批量缓存测试 ====================

    @Test
    @Order(12)
    @DisplayName("批量缓存通知")
    void cacheNotifications_Batch() {
        when(listOperations.size(anyString())).thenReturn(5L);

        NotificationEvent event = NotificationEvent.of(EventType.GROUP_UPDATED, Map.of("groupId", 100L));

        // 执行
        cache.cacheNotifications(List.of(1L, 2L, 3L), event);

        // 验证：为3个用户各缓存一次
        verify(listOperations, times(3)).rightPush(anyString(), anyString());
    }
}
