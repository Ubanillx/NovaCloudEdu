package com.novacloudedu.backend.infrastructure.ai;

import dev.langchain4j.data.message.*;
import dev.langchain4j.model.chat.StreamingChatModel;
import dev.langchain4j.model.chat.response.ChatResponse;
import dev.langchain4j.model.chat.response.StreamingChatResponseHandler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 基于 Langchain4j 的聊天服务
 * 
 * 支持多供应商、多模型的流式对话，包括多模态（图片+文本）。
 * 通过 ChatModelFactory 动态获取模型实例。
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class LangchainChatService {

    private final ChatModelFactory chatModelFactory;

    @FunctionalInterface
    public interface StreamCallback {
        void onToken(String token);
    }

    private static final long TEXT_CHAT_TIMEOUT_MS = 60_000L;
    private static final long VISION_CHAT_TIMEOUT_MS = 120_000L;
    private static final long MULTI_IMAGE_CHAT_TIMEOUT_MS = 180_000L;
    private static final long STREAM_CHAT_TIMEOUT_MS = 300_000L;

    /**
     * 流式对话（文本）
     *
     * @param modelId   模型ID（如 "dashscope/qwen-max"），null 则用默认模型
     * @param messages  对话消息列表 [{role, content}]
     * @param callback  流式回调
     */
    public void streamChat(String modelId, List<Map<String, String>> messages, StreamCallback callback) {
        StreamingChatModel model = resolveModel(modelId, false);
        List<ChatMessage> chatMessages = convertMessages(messages, null);

        log.info("Langchain4j 流式对话: modelId={}, 消息数={}", modelId, chatMessages.size());
        doStreamChat(model, chatMessages, callback);
    }

    /**
     * 流式对话（带自定义模型参数，用于 AI 助手）
     * 不走模型缓存，每次根据参数新建模型实例
     */
    public void streamChatWithParams(String modelId, List<Map<String, String>> messages,
                                      Double temperature, Double topP, Integer maxTokens,
                                      StreamCallback callback) {
        streamChatWithParams(modelId, messages, temperature, topP, maxTokens, false, callback);
    }

    /**
     * 流式对话（带自定义模型参数 + 联网搜索开关）
     *
     * @param enableSearch 是否启用联网搜索（仅 DashScope 模型支持）
     */
    public void streamChatWithParams(String modelId, List<Map<String, String>> messages,
                                      Double temperature, Double topP, Integer maxTokens,
                                      boolean enableSearch, StreamCallback callback) {
        StreamingChatModel model = chatModelFactory.createStreamingModelWithParams(
                modelId, temperature, topP, maxTokens, enableSearch);
        List<ChatMessage> chatMessages = convertMessages(messages, null);

        log.info("Langchain4j 流式对话(自定义参数): modelId={}, temperature={}, topP={}, maxTokens={}, enableSearch={}, 消息数={}",
                modelId, temperature, topP, maxTokens, enableSearch, chatMessages.size());
        doStreamChat(model, chatMessages, callback);
    }

    /**
     * 流式多模态对话（带自定义模型参数，用于 AI 助手）
     */
    public void streamChatWithImagesAndParams(String modelId, List<Map<String, String>> messages,
                                               List<String> imageUrls,
                                               Double temperature, Double topP, Integer maxTokens,
                                               StreamCallback callback) {
        StreamingChatModel model = chatModelFactory.createStreamingModelWithParams(
                modelId, temperature, topP, maxTokens);
        List<ChatMessage> chatMessages = convertMessages(messages, imageUrls);

        log.info("Langchain4j 多模态流式对话(自定义参数): modelId={}, temperature={}, topP={}, maxTokens={}, 消息数={}, 图片数={}",
                modelId, temperature, topP, maxTokens, chatMessages.size(), imageUrls != null ? imageUrls.size() : 0);
        doStreamChat(model, chatMessages, callback);
    }

    /**
     * 流式多模态对话（图片+文本）
     *
     * @param modelId   模型ID，null 则用默认视觉模型
     * @param messages  对话消息列表
     * @param imageUrls 图片URL列表（附加到最后一条 user 消息）
     * @param callback  流式回调
     */
    public void streamChatWithImages(String modelId, List<Map<String, String>> messages,
                                      List<String> imageUrls, StreamCallback callback) {
        StreamingChatModel model = resolveModel(modelId, true);
        List<ChatMessage> chatMessages = convertMessages(messages, imageUrls);

        log.info("Langchain4j 多模态流式对话: modelId={}, 消息数={}, 图片数={}",
                modelId, chatMessages.size(), imageUrls != null ? imageUrls.size() : 0);
        doStreamChat(model, chatMessages, callback);
    }

    /**
     * 同步对话（用于内部摘要/标题生成等场景）
     */
    public String chat(String modelId, String systemPrompt, String userMessage) {
        StreamingChatModel model = resolveModel(modelId, false);

        List<ChatMessage> messages = new ArrayList<>();
        if (systemPrompt != null && !systemPrompt.trim().isEmpty()) {
            messages.add(SystemMessage.from(systemPrompt));
        }
        messages.add(UserMessage.from(userMessage));

        StringBuilder result = new StringBuilder();
        final Object lock = new Object();
        final boolean[] done = {false};
        final Throwable[] error = {null};

        model.chat(messages, new StreamingChatResponseHandler() {
            @Override
            public void onPartialResponse(String token) {
                result.append(token);
            }

            @Override
            public void onCompleteResponse(ChatResponse response) {
                synchronized (lock) {
                    done[0] = true;
                    lock.notifyAll();
                }
            }

            @Override
            public void onError(Throwable throwable) {
                synchronized (lock) {
                    error[0] = throwable;
                    done[0] = true;
                    lock.notifyAll();
                }
            }
        });

        awaitCompletion(lock, done, TEXT_CHAT_TIMEOUT_MS, "LLM 对话超时（60秒）", "对话被中断");

        if (error[0] != null) {
            throw new RuntimeException("LLM 对话失败: " + error[0].getMessage(), error[0]);
        }

        return result.toString();
    }

    /**
     * 同步多模态对话（图片+文本，用于视觉模型场景）
     *
     * @param modelId      模型ID（如 "dashscope/qwen-vl-max"），null 则用默认视觉模型
     * @param systemPrompt 系统提示词
     * @param userMessage  用户消息文本
     * @param imageUrl     图片URL
     */
    public String chatWithImage(String modelId, String systemPrompt,
                                 String userMessage, String imageUrl) {
        StreamingChatModel model = resolveModel(modelId, true);

        List<ChatMessage> messages = new ArrayList<>();
        if (systemPrompt != null && !systemPrompt.trim().isEmpty()) {
            messages.add(SystemMessage.from(systemPrompt));
        }

        // 构建包含图片的 UserMessage
        List<Content> contents = new ArrayList<>();
        if (imageUrl != null && !imageUrl.isBlank()) {
            contents.add(ImageContent.from(URI.create(imageUrl)));
        }
        contents.add(TextContent.from(userMessage));
        messages.add(UserMessage.from(contents));

        StringBuilder result = new StringBuilder();
        final Object lock = new Object();
        final boolean[] done = {false};
        final Throwable[] error = {null};

        model.chat(messages, new StreamingChatResponseHandler() {
            @Override
            public void onPartialResponse(String token) {
                result.append(token);
            }

            @Override
            public void onCompleteResponse(ChatResponse response) {
                synchronized (lock) {
                    done[0] = true;
                    lock.notifyAll();
                }
            }

            @Override
            public void onError(Throwable throwable) {
                synchronized (lock) {
                    error[0] = throwable;
                    done[0] = true;
                    lock.notifyAll();
                }
            }
        });

        awaitCompletion(lock, done, VISION_CHAT_TIMEOUT_MS, "视觉模型对话超时（120秒）", "视觉对话被中断");

        if (error[0] != null) {
            throw new RuntimeException("视觉模型对话失败: " + error[0].getMessage(), error[0]);
        }

        return result.toString();
    }

    /**
     * 同步多图视觉对话（多张图片+文本，用于PPT多页视觉评估等场景）
     *
     * @param modelId      模型ID（如 "dashscope/qwen-vl-max"），null 则用默认视觉模型
     * @param systemPrompt 系统提示词
     * @param userMessage  用户消息文本
     * @param imageUrls    图片URL列表
     */
    public String chatWithImages(String modelId, String systemPrompt,
                                  String userMessage, List<String> imageUrls) {
        StreamingChatModel model = resolveModel(modelId, true);

        List<ChatMessage> messages = new ArrayList<>();
        if (systemPrompt != null && !systemPrompt.trim().isEmpty()) {
            messages.add(SystemMessage.from(systemPrompt));
        }

        List<Content> contents = new ArrayList<>();
        if (imageUrls != null) {
            for (String url : imageUrls) {
                if (url != null && !url.isBlank()) {
                    contents.add(ImageContent.from(URI.create(url)));
                }
            }
        }
        contents.add(TextContent.from(userMessage));
        messages.add(UserMessage.from(contents));

        StringBuilder result = new StringBuilder();
        final Object lock = new Object();
        final boolean[] done = {false};
        final Throwable[] error = {null};

        model.chat(messages, new StreamingChatResponseHandler() {
            @Override
            public void onPartialResponse(String token) {
                result.append(token);
            }

            @Override
            public void onCompleteResponse(ChatResponse response) {
                synchronized (lock) {
                    done[0] = true;
                    lock.notifyAll();
                }
            }

            @Override
            public void onError(Throwable throwable) {
                synchronized (lock) {
                    error[0] = throwable;
                    done[0] = true;
                    lock.notifyAll();
                }
            }
        });

        awaitCompletion(lock, done, MULTI_IMAGE_CHAT_TIMEOUT_MS, "多图视觉对话超时（180秒）", "多图视觉对话被中断");

        if (error[0] != null) {
            throw new RuntimeException("多图视觉对话失败: " + error[0].getMessage(), error[0]);
        }

        return result.toString();
    }

    /**
     * 获取可用模型列表（仅启用的）
     */
    public List<Map<String, Object>> listAvailableModels() {
        return chatModelFactory.listAvailableModels();
    }

    /**
     * 获取全量模型列表（含未启用的，标注状态）
     */
    public List<Map<String, Object>> listAllModels() {
        return chatModelFactory.listAllModels(false);
    }

    // ==================== 私有方法 ====================

    private StreamingChatModel resolveModel(String modelId, boolean isVision) {
        if (modelId != null && !modelId.trim().isEmpty()) {
            return chatModelFactory.getStreamingModel(modelId);
        }
        return isVision ? chatModelFactory.getDefaultVisionModel() : chatModelFactory.getDefaultModel();
    }

    private void doStreamChat(StreamingChatModel model, List<ChatMessage> messages,
                               StreamCallback callback) {
        final Object lock = new Object();
        final boolean[] done = {false};
        final Throwable[] error = {null};

        model.chat(messages, new StreamingChatResponseHandler() {
            @Override
            public void onPartialResponse(String token) {
                if (token != null && !token.isEmpty()) {
                    callback.onToken(token);
                }
            }

            @Override
            public void onCompleteResponse(ChatResponse response) {
                synchronized (lock) {
                    done[0] = true;
                    lock.notifyAll();
                }
            }

            @Override
            public void onError(Throwable throwable) {
                synchronized (lock) {
                    error[0] = throwable;
                    done[0] = true;
                    lock.notifyAll();
                }
            }
        });

        awaitCompletion(lock, done, STREAM_CHAT_TIMEOUT_MS, "流式对话超时（300秒）", "流式对话被中断");

        if (error[0] != null) {
            throw new RuntimeException("流式对话失败: " + error[0].getMessage(), error[0]);
        }
    }

    private void awaitCompletion(Object lock, boolean[] done, long timeoutMs,
                                 String timeoutMessage, String interruptedMessage) {
        long deadline = System.currentTimeMillis() + timeoutMs;
        synchronized (lock) {
            while (!done[0]) {
                long remaining = deadline - System.currentTimeMillis();
                if (remaining <= 0) {
                    throw new RuntimeException(timeoutMessage);
                }
                try {
                    lock.wait(remaining);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    throw new RuntimeException(interruptedMessage, e);
                }
            }
        }
    }

    /**
     * 将 Map 消息列表转换为 Langchain4j ChatMessage 列表
     * 如果提供了 imageUrls，则附加到最后一条 user 消息上
     */
    private List<ChatMessage> convertMessages(List<Map<String, String>> messages, List<String> imageUrls) {
        List<ChatMessage> result = new ArrayList<>();

        for (int i = 0; i < messages.size(); i++) {
            Map<String, String> msg = messages.get(i);
            String role = msg.get("role");
            String content = msg.get("content");

            // 跳过 role 或 content 为空的无效消息
            if (role == null || role.isBlank()) {
                log.warn("跳过无效消息: role 为空, content={}", content);
                continue;
            }
            if (content == null || content.isBlank()) {
                log.warn("跳过无效消息: content 为空, role={}", role);
                continue;
            }

            boolean isLastUser = (i == messages.size() - 1)
                    && "user".equalsIgnoreCase(role)
                    && imageUrls != null && !imageUrls.isEmpty();

            switch (role.toLowerCase()) {
                case "system" -> result.add(SystemMessage.from(content));
                case "assistant" -> result.add(AiMessage.from(content));
                case "user" -> {
                    if (isLastUser) {
                        List<Content> contents = new ArrayList<>();
                        for (String url : imageUrls) {
                            contents.add(ImageContent.from(URI.create(url)));
                        }
                        contents.add(TextContent.from(content));
                        result.add(UserMessage.from(contents));
                    } else {
                        result.add(UserMessage.from(content));
                    }
                }
                default -> {
                    log.warn("未知消息角色: {}, 按 user 处理", role);
                    result.add(UserMessage.from(content));
                }
            }
        }

        return result;
    }
}
