package com.novacloudedu.backend.domain.book.service;

import java.util.List;
import java.util.Map;

/**
 * 大语言模型服务接口
 */
public interface LlmService {

    /**
     * 发送单条消息并获取回复
     * 
     * @param message 用户消息
     * @return AI回复
     */
    String chat(String message);

    /**
     * 发送多轮对话消息并获取回复
     * 
     * @param messages 对话历史，格式: [{role: "user/assistant/system", content: "..."}]
     * @return AI回复
     */
    String chat(List<Map<String, String>> messages);

    /**
     * 使用系统提示词进行对话
     * 
     * @param systemPrompt 系统提示词
     * @param userMessage 用户消息
     * @return AI回复
     */
    String chatWithSystemPrompt(String systemPrompt, String userMessage);

    /**
     * 流式对话（用于实时显示）
     * 
     * @param message 用户消息
     * @param callback 回调函数，接收每个token
     */
    void streamChat(String message, StreamCallback callback);

    /**
     * 流式回调接口
     */
    @FunctionalInterface
    interface StreamCallback {
        void onToken(String token);
    }

    /**
     * 获取模型名称
     */
    String getModelName();

    /**
     * 获取最大token数
     */
    int getMaxTokens();
}
