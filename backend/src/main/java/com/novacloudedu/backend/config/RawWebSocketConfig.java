package com.novacloudedu.backend.config;

import com.novacloudedu.backend.infrastructure.websocket.SpeechRecognitionWebSocketHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * 原生 WebSocket 配置类
 * 用于需要处理二进制数据的场景（如语音识别）
 */
@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class RawWebSocketConfig implements WebSocketConfigurer {

    private final SpeechRecognitionWebSocketHandler speechRecognitionWebSocketHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        // 实时语音识别 WebSocket 端点
        // 客户端连接: ws://host:port/ws/speech?token=xxx
        registry.addHandler(speechRecognitionWebSocketHandler, "/ws/speech")
                .setAllowedOriginPatterns("*");
    }
}
