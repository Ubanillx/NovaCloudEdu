package com.novacloudedu.backend.infrastructure.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.infrastructure.security.JwtTokenProvider;
import com.novacloudedu.backend.infrastructure.speech.NlsSpeechRecognitionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 实时语音识别 WebSocket Handler
 * 处理客户端发送的音频流，返回实时识别结果
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class SpeechRecognitionWebSocketHandler extends AbstractWebSocketHandler {

    private final NlsSpeechRecognitionService speechRecognitionService;
    private final JwtTokenProvider jwtTokenProvider;
    private final ObjectMapper objectMapper;

    private final ConcurrentHashMap<String, Long> sessionUserMap = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String sessionId = session.getId();
        log.info("语音识别 WebSocket 连接建立: sessionId={}", sessionId);
        
        // 从 URI 参数中获取 token 进行认证
        String token = extractToken(session);
        if (token == null || !jwtTokenProvider.validateToken(token)) {
            log.warn("语音识别 WebSocket 认证失败: sessionId={}", sessionId);
            session.close(CloseStatus.NOT_ACCEPTABLE.withReason("认证失败"));
            return;
        }
        
        Long userId = jwtTokenProvider.getUserIdFromToken(token);
        sessionUserMap.put(sessionId, userId);
        
        // 启动语音转写会话
        boolean started = speechRecognitionService.startTranscription(
                sessionId,
                // 句子开始回调
                sentenceIndex -> {
                    sendMessage(session, Map.of(
                            "type", "sentence_begin",
                            "sentenceIndex", sentenceIndex
                    ));
                },
                // 句子结束回调（最终结果）
                result -> {
                    sendMessage(session, Map.of(
                            "type", "sentence_end",
                            "sentenceIndex", result.sentenceIndex(),
                            "text", result.text(),
                            "beginTime", result.beginTime(),
                            "endTime", result.endTime(),
                            "isFinal", true
                    ));
                },
                // 中间结果回调
                result -> {
                    sendMessage(session, Map.of(
                            "type", "transcription",
                            "sentenceIndex", result.sentenceIndex(),
                            "text", result.text(),
                            "isFinal", false
                    ));
                },
                // 错误回调
                error -> {
                    sendMessage(session, Map.of(
                            "type", "error",
                            "message", error
                    ));
                }
        );
        
        if (started) {
            sendMessage(session, Map.of(
                    "type", "ready",
                    "message", "语音识别服务已就绪，请开始发送音频数据"
            ));
        } else {
            session.close(CloseStatus.SERVER_ERROR.withReason("语音识别服务启动失败"));
        }
    }

    @Override
    protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) throws Exception {
        String sessionId = session.getId();
        byte[] audioData = message.getPayload().array();
        
        // 发送音频数据到 NLS 服务
        speechRecognitionService.sendAudio(sessionId, audioData);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String sessionId = session.getId();
        String payload = message.getPayload();
        
        try {
            @SuppressWarnings("unchecked")
            Map<String, Object> data = objectMapper.readValue(payload, Map.class);
            String type = (String) data.get("type");
            
            if ("stop".equals(type)) {
                // 客户端请求停止识别
                speechRecognitionService.stopTranscription(sessionId);
                sendMessage(session, Map.of(
                        "type", "stopped",
                        "message", "语音识别已停止"
                ));
            } else if ("ping".equals(type)) {
                // 心跳
                sendMessage(session, Map.of("type", "pong"));
            }
        } catch (Exception e) {
            log.error("处理文本消息失败: sessionId={}", sessionId, e);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String sessionId = session.getId();
        log.info("语音识别 WebSocket 连接关闭: sessionId={}, status={}", sessionId, status);
        
        // 清理资源
        speechRecognitionService.stopTranscription(sessionId);
        sessionUserMap.remove(sessionId);
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        String sessionId = session.getId();
        log.error("语音识别 WebSocket 传输错误: sessionId={}", sessionId, exception);
        
        // 清理资源
        speechRecognitionService.stopTranscription(sessionId);
        sessionUserMap.remove(sessionId);
    }

    /**
     * 从 WebSocket 会话中提取 Token
     */
    private String extractToken(WebSocketSession session) {
        String query = session.getUri() != null ? session.getUri().getQuery() : null;
        if (query != null) {
            for (String param : query.split("&")) {
                String[] keyValue = param.split("=");
                if (keyValue.length == 2 && "token".equals(keyValue[0])) {
                    return keyValue[1];
                }
            }
        }
        return null;
    }

    /**
     * 发送 JSON 消息
     */
    private void sendMessage(WebSocketSession session, Map<String, Object> data) {
        if (session.isOpen()) {
            try {
                String json = objectMapper.writeValueAsString(data);
                session.sendMessage(new TextMessage(json));
            } catch (IOException e) {
                log.error("发送消息失败: sessionId={}", session.getId(), e);
            }
        }
    }
}
