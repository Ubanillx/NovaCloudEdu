package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ai.entity.AiChatMessage;
import com.novacloudedu.backend.domain.ai.entity.AiChatSession;
import com.novacloudedu.backend.domain.ai.repository.AiChatMessageRepository;
import com.novacloudedu.backend.domain.ai.repository.AiChatSessionRepository;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatMessageId;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.ai.DocumentParseService;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

/**
 * AI聊天应用服务
 * 
 * 记忆策略：滑动窗口 + 摘要压缩
 * - 保留最近 N 轮消息原文（滑动窗口）
 * - 当未摘要消息超过阈值时，将窗口外的旧消息压缩为摘要
 * - 摘要作为 system 消息注入，保持长对话的上下文连贯性
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiChatApplicationService {

    private final LangchainChatService langchainChatService;
    private final AiChatSessionRepository sessionRepository;
    private final AiChatMessageRepository messageRepository;
    private final DocumentParseService documentParseService;
    private final ExecutorService executor = Executors.newCachedThreadPool();

    /** 滑动窗口大小：保留最近多少条消息原文发送给LLM */
    @Value("${ai.conversation.window-size:20}")
    private int windowSize;

    /** 触发摘要压缩的消息数阈值 */
    @Value("${ai.conversation.summarize-threshold:30}")
    private int summarizeThreshold;

    /** 最大历史条数上限（防止极端情况） */
    @Value("${ai.conversation.max-history:10}")
    private int maxHistory;

    // ==================== 会话管理 ====================

    /**
     * 创建新会话
     */
    @Transactional
    public AiChatSession createSession(Long userId) {
        AiChatSession session = AiChatSession.create(UserId.of(userId));
        return sessionRepository.save(session);
    }

    /**
     * 获取用户的会话列表
     */
    public List<AiChatSession> listSessions(Long userId, int page, int size) {
        return sessionRepository.findByUserId(UserId.of(userId), page, size);
    }

    /**
     * 获取会话详情（含消息列表）
     */
    public Map<String, Object> getSessionDetail(Long sessionId, Long userId) {
        AiChatSession session = getSessionAndVerifyOwner(sessionId, userId);
        List<AiChatMessage> messages = messageRepository.findBySessionId(AiChatSessionId.of(sessionId));

        Map<String, Object> result = new HashMap<>();
        result.put("session", session);
        result.put("messages", messages);
        return result;
    }

    /**
     * 删除会话
     */
    @Transactional
    public void deleteSession(Long sessionId, Long userId) {
        getSessionAndVerifyOwner(sessionId, userId);
        messageRepository.deleteBySessionId(AiChatSessionId.of(sessionId));
        sessionRepository.delete(AiChatSessionId.of(sessionId));
    }

    // ==================== 会话级流式对话（带记忆） ====================

    /**
     * 基于会话的流式对话（核心方法）
     * 
     * 流程：
     * 1. 保存用户消息到数据库
     * 2. 构建带记忆的上下文（摘要 + 滑动窗口内的近期消息）
     * 3. 流式调用LLM
     * 4. 保存AI回复到数据库
     * 5. 异步检查是否需要摘要压缩 + 自动生成标题
     */
    public SseEmitter sessionStreamChat(Long sessionId, Long userId, String message,
                                         String systemPrompt, List<String> imageUrls,
                                         List<String> documentUrls, String modelId) {
        AiChatSession session = getSessionAndVerifyOwner(sessionId, userId);
        boolean hasImages = imageUrls != null && !imageUrls.isEmpty();
        // hasDocuments 在 lambda 内通过 safeDocUrls 判断

        // 1. 先保存用户消息（附件包含图片URL + 文档URL）
        List<String> allAttachments = new ArrayList<>();
        if (imageUrls != null) allAttachments.addAll(imageUrls);
        if (documentUrls != null) allAttachments.addAll(documentUrls);
        AiChatMessage userMsg = AiChatMessage.create(
                AiChatSessionId.of(sessionId), UserId.of(userId),
                "user", message, allAttachments.isEmpty() ? null : allAttachments
        );
        messageRepository.save(userMsg);
        session.incrementMessageCount(1);

        SseEmitter emitter = new SseEmitter(300000L);

        executor.execute(() -> {
            try {
                // 2. 解析文档内容（如果有）
                final List<String> safeDocUrls = documentUrls != null ? documentUrls : List.of();
                String documentContext = null;
                if (!safeDocUrls.isEmpty()) {
                    log.info("会话[{}] 开始解析{}个文档", sessionId, safeDocUrls.size());
                    List<DocumentParseService.ParsedDocument> parsedDocs = new ArrayList<>();
                    for (String docUrl : safeDocUrls) {
                        parsedDocs.add(documentParseService.parseFromUrl(docUrl));
                    }
                    documentContext = documentParseService.formatForAiContext(parsedDocs);
                    log.info("会话[{}] 文档解析完成，上下文长度: {}", sessionId, documentContext.length());
                }

                // 3. 构建带记忆的上下文
                List<Map<String, String>> contextMessages = buildContextWithMemory(session, systemPrompt, documentContext);

                StringBuilder fullResponse = new StringBuilder();

                LangchainChatService.StreamCallback callback = (token) -> {
                    try {
                        fullResponse.append(token);
                        emitter.send(SseEmitter.event()
                                .name("message")
                                .data(token));
                    } catch (IOException e) {
                        log.error("SSE发送失败", e);
                        emitter.completeWithError(e);
                    }
                };

                // 4. 调用LLM
                final List<String> safeImageUrls = imageUrls != null ? imageUrls : List.of();
                if (hasImages) {
                    log.info("会话[{}] 使用多模态模型，图片数: {}, modelId={}", sessionId, safeImageUrls.size(), modelId);
                    langchainChatService.streamChatWithImages(modelId, contextMessages, safeImageUrls, callback);
                } else {
                    langchainChatService.streamChat(modelId, contextMessages, callback);
                }

                // 4. 保存AI回复
                String aiResponse = fullResponse.toString();
                AiChatMessage assistantMsg = AiChatMessage.create(
                        AiChatSessionId.of(sessionId), UserId.of(userId),
                        "assistant", aiResponse, null
                );
                messageRepository.save(assistantMsg);
                session.incrementMessageCount(1);
                sessionRepository.save(session);

                emitter.send(SseEmitter.event()
                        .name("done")
                        .data("[DONE]"));
                emitter.complete();

                log.info("会话[{}] 流式对话完成，回复字符数: {}", sessionId, aiResponse.length());

                // 5. 异步检查是否需要摘要压缩 + 自动生成标题
                executor.execute(() -> postProcessSession(session));

            } catch (Exception e) {
                log.error("会话[{}] 流式对话异常", sessionId, e);
                try {
                    emitter.send(SseEmitter.event()
                            .name("error")
                            .data("对话失败: " + e.getMessage()));
                } catch (IOException ioException) {
                    log.error("发送错误消息失败", ioException);
                }
                emitter.completeWithError(e);
            }
        });

        return emitter;
    }

    // ==================== 无状态流式对话（向后兼容） ====================

    /**
     * 无状态流式对话（不使用会话，前端自行管理历史）
     */
    public SseEmitter streamChat(String message, List<Map<String, String>> history,
                                  String systemPrompt, List<String> imageUrls,
                                  String modelId) {
        SseEmitter emitter = new SseEmitter(300000L);
        boolean hasImages = imageUrls != null && !imageUrls.isEmpty();

        executor.execute(() -> {
            try {
                List<Map<String, String>> messages = buildStatelessMessages(message, history, systemPrompt);
                StringBuilder fullResponse = new StringBuilder();

                LangchainChatService.StreamCallback callback = (token) -> {
                    try {
                        fullResponse.append(token);
                        emitter.send(SseEmitter.event()
                                .name("message")
                                .data(token));
                    } catch (IOException e) {
                        log.error("SSE发送失败", e);
                        emitter.completeWithError(e);
                    }
                };

                if (hasImages) {
                    langchainChatService.streamChatWithImages(modelId, messages, imageUrls, callback);
                } else {
                    langchainChatService.streamChat(modelId, messages, callback);
                }

                emitter.send(SseEmitter.event().name("done").data("[DONE]"));
                emitter.complete();
                log.info("无状态流式对话完成，总字符数: {}", fullResponse.length());

            } catch (Exception e) {
                log.error("无状态流式对话异常", e);
                try {
                    emitter.send(SseEmitter.event()
                            .name("error")
                            .data("对话失败: " + e.getMessage()));
                } catch (IOException ioException) {
                    log.error("发送错误消息失败", ioException);
                }
                emitter.completeWithError(e);
            }
        });

        return emitter;
    }

    // ==================== 记忆策略核心逻辑 ====================

    /**
     * 构建带记忆的上下文消息列表
     * 
     * 结构：
     * [system（用户自定义提示词）]
     * [system（记忆摘要，如果有的话）]
     * [最近 windowSize 条未摘要消息]
     */
    private List<Map<String, String>> buildContextWithMemory(AiChatSession session, String systemPrompt, String documentContext) {
        List<Map<String, String>> messages = new ArrayList<>();

        // 1. 用户自定义 system prompt
        if (systemPrompt != null && !systemPrompt.trim().isEmpty()) {
            messages.add(makeMsg("system", systemPrompt));
        }

        // 2. 注入文档上下文（如果有）
        if (documentContext != null && !documentContext.isBlank()) {
            messages.add(makeMsg("system", documentContext));
        }

        // 3. 注入记忆摘要
        if (session.getMemorySummary() != null && !session.getMemorySummary().trim().isEmpty()) {
            String summaryPrompt = "以下是之前对话的摘要，请结合这些上下文继续对话：\n" + session.getMemorySummary();
            messages.add(makeMsg("system", summaryPrompt));
        }

        // 4. 取滑动窗口内的未摘要消息
        List<AiChatMessage> unsummarized = messageRepository.findUnsummarizedBySessionId(session.getId());

        // 如果未摘要消息太多，只取最近 windowSize 条
        int startIndex = Math.max(0, unsummarized.size() - windowSize);
        List<AiChatMessage> windowMessages = unsummarized.subList(startIndex, unsummarized.size());

        for (AiChatMessage msg : windowMessages) {
            messages.add(makeMsg(msg.getRole(), msg.getContent()));
        }

        log.debug("会话[{}] 上下文构建: 摘要={}, 窗口消息数={}, 未摘要总数={}",
                session.getId().value(),
                session.getMemorySummary() != null ? "有" : "无",
                windowMessages.size(),
                unsummarized.size());

        return messages;
    }

    /**
     * 会话后处理：检查摘要压缩 + 自动生成标题
     */
    private void postProcessSession(AiChatSession session) {
        try {
            // 1. 检查是否需要摘要压缩
            List<AiChatMessage> unsummarized = messageRepository.findUnsummarizedBySessionId(session.getId());
            if (unsummarized.size() > summarizeThreshold) {
                summarizeOldMessages(session, unsummarized);
            }

            // 2. 自动生成标题（仅在首次对话后）
            if (session.getTitle() == null && session.getMessageCount() >= 2) {
                generateTitle(session);
            }
        } catch (Exception e) {
            log.error("会话[{}] 后处理失败", session.getId().value(), e);
        }
    }

    /**
     * 摘要压缩旧消息
     * 
     * 策略：
     * 1. 将窗口外的旧消息提取出来
     * 2. 调用LLM生成摘要
     * 3. 将摘要存入 session.memorySummary（与原有摘要合并）
     * 4. 将这些旧消息标记为已摘要
     */
    private void summarizeOldMessages(AiChatSession session, List<AiChatMessage> unsummarized) {
        // 保留最近 windowSize 条，压缩其余的
        int toSummarizeCount = unsummarized.size() - windowSize;
        if (toSummarizeCount <= 0) {
            return;
        }

        List<AiChatMessage> toSummarize = unsummarized.subList(0, toSummarizeCount);

        // 构建要压缩的对话文本
        StringBuilder conversationText = new StringBuilder();
        for (AiChatMessage msg : toSummarize) {
            String roleLabel = "user".equals(msg.getRole()) ? "用户" : "AI";
            conversationText.append(roleLabel).append(": ").append(msg.getContent()).append("\n");
        }

        // 如果已有旧摘要，合并进去
        String existingSummary = session.getMemorySummary();
        String prompt;
        if (existingSummary != null && !existingSummary.trim().isEmpty()) {
            prompt = String.format(
                    "以下是之前对话的旧摘要和新的对话内容。请将它们合并为一份简洁的综合摘要，" +
                    "保留关键信息、用户偏好和重要结论，去除冗余。控制在300字以内。\n\n" +
                    "【旧摘要】\n%s\n\n【新对话】\n%s",
                    existingSummary, conversationText
            );
        } else {
            prompt = String.format(
                    "请将以下对话内容压缩为一份简洁的摘要，" +
                    "保留关键信息、用户偏好和重要结论。控制在300字以内。\n\n%s",
                    conversationText
            );
        }

        try {
            String summary = langchainChatService.chat(
                    null,
                    "你是一个对话摘要助手，擅长提取对话中的关键信息并生成简洁摘要。",
                    prompt
            );

            // 更新会话摘要
            session.updateMemorySummary(summary);
            sessionRepository.save(session);

            // 标记旧消息为已摘要
            List<AiChatMessageId> ids = toSummarize.stream()
                    .map(AiChatMessage::getId)
                    .collect(Collectors.toList());
            messageRepository.markAsSummarized(ids);

            log.info("会话[{}] 摘要压缩完成: 压缩{}条消息, 摘要长度={}",
                    session.getId().value(), toSummarizeCount, summary.length());
        } catch (Exception e) {
            log.error("会话[{}] 摘要压缩失败", session.getId().value(), e);
        }
    }

    /**
     * 自动生成会话标题
     */
    private void generateTitle(AiChatSession session) {
        try {
            List<AiChatMessage> recentMessages = messageRepository.findRecentBySessionId(session.getId(), 4);

            StringBuilder conversationText = new StringBuilder();
            for (AiChatMessage msg : recentMessages) {
                String roleLabel = "user".equals(msg.getRole()) ? "用户" : "AI";
                conversationText.append(roleLabel).append(": ").append(msg.getContent()).append("\n");
            }

            String title = langchainChatService.chat(
                    null,
                    "根据以下对话内容，生成一个简短的标题（10字以内），不要加引号和标点。",
                    conversationText.toString()
            );

            // 清理标题
            title = title.trim().replaceAll("[\"'\\u201c\\u201d\\u2018\\u2019\\u300c\\u300d]", "");
            if (title.length() > 50) {
                title = title.substring(0, 50);
            }

            session.updateTitle(title);
            sessionRepository.save(session);

            log.info("会话[{}] 自动生成标题: {}", session.getId().value(), title);
        } catch (Exception e) {
            log.error("会话[{}] 标题生成失败", session.getId().value(), e);
        }
    }

    // ==================== 工具方法 ====================

    private AiChatSession getSessionAndVerifyOwner(Long sessionId, Long userId) {
        AiChatSession session = sessionRepository.findById(AiChatSessionId.of(sessionId))
                .orElseThrow(() -> new BusinessException(40400, "会话不存在"));
        if (!session.belongsTo(UserId.of(userId))) {
            throw new BusinessException(40300, "无权访问此会话");
        }
        return session;
    }

    private Map<String, String> makeMsg(String role, String content) {
        Map<String, String> msg = new HashMap<>();
        msg.put("role", role);
        msg.put("content", content);
        return msg;
    }

    private List<Map<String, String>> buildStatelessMessages(String message,
                                                              List<Map<String, String>> history,
                                                              String systemPrompt) {
        List<Map<String, String>> messages = new ArrayList<>();

        if (systemPrompt != null && !systemPrompt.trim().isEmpty()) {
            messages.add(makeMsg("system", systemPrompt));
        }

        if (history != null && !history.isEmpty()) {
            messages.addAll(history);
        }

        messages.add(makeMsg("user", message));
        return messages;
    }
}
