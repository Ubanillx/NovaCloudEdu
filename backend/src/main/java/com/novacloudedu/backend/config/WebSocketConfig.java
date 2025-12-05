package com.novacloudedu.backend.config;

import com.novacloudedu.backend.infrastructure.websocket.WebSocketAuthChannelInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/**
 * WebSocket 配置类
 * 使用 STOMP 协议进行消息传递，SockJS 作为降级方案
 */
@Configuration
@EnableWebSocketMessageBroker
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    private final WebSocketAuthChannelInterceptor webSocketAuthChannelInterceptor;

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 启用简单的内存消息代理，客户端订阅以 /topic 或 /queue 开头的目的地
        // /topic 用于广播消息（一对多）
        // /queue 用于点对点消息（一对一）
        registry.enableSimpleBroker("/topic", "/queue");
        
        // 客户端发送消息时的前缀，发送到 /app/** 的消息会被路由到 @MessageMapping 方法
        registry.setApplicationDestinationPrefixes("/app");
        
        // 用户目的地前缀，用于点对点消息
        registry.setUserDestinationPrefix("/user");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // 纯 WebSocket 端点（推荐用于调试和原生 WebSocket 客户端）
        registry.addEndpoint("/ws")
                .setAllowedOriginPatterns("*");

        // SockJS 降级端点（用于不支持 WebSocket 的浏览器）
        registry.addEndpoint("/ws-sockjs")
                .setAllowedOriginPatterns("*")
                .withSockJS();
    }

    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        // 注册认证拦截器，处理 STOMP 消息级别的 JWT 认证
        registration.interceptors(webSocketAuthChannelInterceptor);
    }
}
