package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ai.entity.AiAssistant;
import com.novacloudedu.backend.domain.ai.entity.AiChatMessage;
import com.novacloudedu.backend.domain.ai.entity.AiChatSession;
import com.novacloudedu.backend.domain.ai.repository.AiAssistantRepository;
import com.novacloudedu.backend.domain.ai.repository.AiChatMessageRepository;
import com.novacloudedu.backend.domain.ai.repository.AiChatSessionRepository;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantId;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatMessageId;
import com.novacloudedu.backend.domain.ai.valueobject.AiChatSessionId;
import com.novacloudedu.backend.domain.ai.valueobject.ModelConfig;
import com.novacloudedu.backend.domain.knowledge.service.KnowledgeSearchService;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.ai.DocumentParseService;
import com.novacloudedu.backend.infrastructure.ai.ImageGenerationService;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.infrastructure.ai.VideoGenerationService;
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
    private final ImageGenerationService imageGenerationService;
    private final VideoGenerationService videoGenerationService;
    private final AiAssistantRepository assistantRepository;
    private final KnowledgeSearchService knowledgeSearchService;
    private final AiAssistantWorkflowService workflowSkillService;
    private final ExecutorService executor = Executors.newCachedThreadPool();

    /** 多模态生成能力的系统提示词（根据启用状态动态拼装） */
    private static final String IMAGE_GEN_PROMPT_SECTION = """
            【文生图能力】当用户明确要求你生成、绘制、画一张图片时，使用：
            <<IMAGE_GEN:详细的英文图片描述>>
            示例：<<IMAGE_GEN:A cute fluffy cat playing in a beautiful garden, digital art style, vibrant colors>>
            """;

    private static final String IMAGE_REF_PROMPT_SECTION = """
            【图参生图能力】当用户提供了参考图片并要求基于它修改、变换、风格迁移等时，使用：
            <<IMAGE_REF:详细的英文描述，说明如何基于参考图修改>>
            说明：系统会自动使用用户上传的最新一张图片作为参考图。
            示例：<<IMAGE_REF:Transform to watercolor painting style, soft pastel colors, artistic brush strokes>>
            """;

    private static final String VIDEO_GEN_PROMPT_SECTION = """
            【文生视频能力】当用户明确要求你生成、制作一段视频时，使用：
            <<VIDEO_GEN:详细的英文视频描述>>
            示例：<<VIDEO_GEN:A cat walking through a sunny garden with butterflies flying around, smooth camera movement, cinematic style>>
            """;

    private static final String GENERATION_RULES = """
            
            通用规则：
            1. 只有当用户明确要求时才使用以上标记
            2. 标记内的描述必须用英文，要尽量详细
            3. 你可以在一次回复中包含多个标记
            4. 在标记前后可以有正常的中文文字说明
            5. 如果用户只是在讨论而非要求生成，不要使用标记
            """;

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

                // 4.5 处理生成标记（文生图 / 图参生图 / 文生视频）
                String aiResponse = fullResponse.toString();
                aiResponse = processGenerationMarkers(aiResponse, emitter, safeImageUrls);

                // 5. 保存AI回复（已替换图片标记为实际URL）
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

                // 处理生成标记
                String aiResponse = fullResponse.toString();
                final List<String> imgUrls = imageUrls != null ? imageUrls : List.of();
                processGenerationMarkers(aiResponse, emitter, imgUrls);

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

        // 1. 用户自定义 system prompt（融合多模态生成能力提示词）
        String enhancedPrompt = buildSystemPromptWithGenerations(systemPrompt);
        if (enhancedPrompt != null && !enhancedPrompt.trim().isEmpty()) {
            messages.add(makeMsg("system", enhancedPrompt));
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

    // ==================== 多模态生成处理 ====================

    /**
     * 构建系统提示词，根据各功能启用状态动态注入能力描述
     */
    private String buildSystemPromptWithGenerations(String userSystemPrompt) {
        boolean imgEnabled = imageGenerationService.isEnabled();
        boolean vidEnabled = videoGenerationService.isEnabled();

        if (!imgEnabled && !vidEnabled) {
            return userSystemPrompt;
        }

        StringBuilder genPrompt = new StringBuilder("你具备以下多媒体生成能力：\n");
        if (imgEnabled) {
            genPrompt.append(IMAGE_GEN_PROMPT_SECTION);
            genPrompt.append(IMAGE_REF_PROMPT_SECTION);
        }
        if (vidEnabled) {
            genPrompt.append(VIDEO_GEN_PROMPT_SECTION);
        }
        genPrompt.append(GENERATION_RULES);

        if (userSystemPrompt == null || userSystemPrompt.isBlank()) {
            return genPrompt.toString();
        }
        return userSystemPrompt + "\n\n" + genPrompt;
    }

    /**
     * 统一处理 AI 回复中的生成标记：
     * - <<IMAGE_GEN:prompt>> 文生图
     * - <<IMAGE_REF:prompt>> 图参生图（使用用户上传的最新图片作为参考）
     * - <<VIDEO_GEN:prompt>> 文生视频
     *
     * @param aiResponse AI 回复原文
     * @param emitter    SSE 发射器
     * @param imageUrls  用户当前消息中上传的图片URL（用于图参生图）
     * @return 替换标记后的最终回复文本
     */
    private String processGenerationMarkers(String aiResponse, SseEmitter emitter, List<String> imageUrls) {
        // 匹配三种标记
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(
                "<<(IMAGE_GEN|IMAGE_REF|VIDEO_GEN):(.+?)>>");
        java.util.regex.Matcher matcher = pattern.matcher(aiResponse);

        if (!matcher.find()) {
            return aiResponse;
        }

        matcher.reset();
        StringBuilder result = new StringBuilder();
        int imageIndex = 0;
        int videoIndex = 0;

        while (matcher.find()) {
            String markerType = matcher.group(1);
            String prompt = matcher.group(2).trim();

            try {
                switch (markerType) {
                    case "IMAGE_GEN" -> {
                        if (!imageGenerationService.isEnabled()) {
                            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(
                                    "\n[文生图功能未启用]\n"));
                            continue;
                        }
                        imageIndex++;
                        emitter.send(SseEmitter.event()
                                .name("image_generating")
                                .data(Map.of("index", imageIndex, "prompt", prompt)));

                        ImageGenerationService.ImageResult imgResult = imageGenerationService.generateImage(prompt);
                        appendImageResult(matcher, result, emitter, imgResult, imageIndex, prompt);
                    }
                    case "IMAGE_REF" -> {
                        if (!imageGenerationService.isEnabled()) {
                            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(
                                    "\n[图参生图功能未启用]\n"));
                            continue;
                        }
                        imageIndex++;
                        // 取用户上传的第一张图片作为参考图
                        String refImgUrl = (imageUrls != null && !imageUrls.isEmpty()) ? imageUrls.get(0) : null;
                        if (refImgUrl == null) {
                            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(
                                    "\n[图参生图失败: 未提供参考图片]\n"));
                            try {
                                emitter.send(SseEmitter.event()
                                        .name("image_error")
                                        .data(Map.of("index", imageIndex, "prompt", prompt,
                                                "error", "未提供参考图片")));
                            } catch (IOException ignored) {}
                            continue;
                        }
                        emitter.send(SseEmitter.event()
                                .name("image_generating")
                                .data(Map.of("index", imageIndex, "prompt", prompt)));

                        ImageGenerationService.ImageResult refResult =
                                imageGenerationService.generateImageWithReference(prompt, refImgUrl);
                        appendImageResult(matcher, result, emitter, refResult, imageIndex, prompt);
                    }
                    case "VIDEO_GEN" -> {
                        if (!videoGenerationService.isEnabled()) {
                            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(
                                    "\n[文生视频功能未启用]\n"));
                            continue;
                        }
                        videoIndex++;
                        emitter.send(SseEmitter.event()
                                .name("video_generating")
                                .data(Map.of("index", videoIndex, "prompt", prompt)));

                        VideoGenerationService.VideoResult vidResult = videoGenerationService.generateVideo(prompt);

                        if (vidResult.success()) {
                            String markdownVideo = "\n<video controls src=\"" + vidResult.videoUrl() + "\" style=\"max-width:100%;border-radius:12px\"></video>\n";
                            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(markdownVideo));
                            emitter.send(SseEmitter.event()
                                    .name("video_generated")
                                    .data(Map.of("index", videoIndex, "url", vidResult.videoUrl(), "prompt", prompt)));
                        } else {
                            String errorText = "\n[视频生成失败: " + vidResult.errorMessage() + "]\n";
                            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(errorText));
                            emitter.send(SseEmitter.event()
                                    .name("video_error")
                                    .data(Map.of("index", videoIndex, "prompt", prompt,
                                            "error", vidResult.errorMessage())));
                        }
                    }
                }
            } catch (Exception e) {
                log.error("处理生成标记异常: type={}, prompt={}", markerType, prompt, e);
                String errorText = "\n[" + markerType + " 生成异常]\n";
                matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(errorText));
            }
        }

        matcher.appendTail(result);
        log.info("生成标记处理完成: 图片{}个, 视频{}个", imageIndex, videoIndex);
        return result.toString();
    }

    /**
     * 将图片生成结果写入 matcher 并发送 SSE 事件
     */
    private void appendImageResult(java.util.regex.Matcher matcher, StringBuilder result,
                                    SseEmitter emitter, ImageGenerationService.ImageResult imgResult,
                                    int index, String prompt) throws IOException {
        if (imgResult.success()) {
            String markdownImage = "\n![AI生成图片](" + imgResult.imageUrl() + ")\n";
            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(markdownImage));
            emitter.send(SseEmitter.event()
                    .name("image_generated")
                    .data(Map.of("index", index, "url", imgResult.imageUrl(), "prompt", prompt)));
        } else {
            String errorText = "\n[图片生成失败: " + imgResult.errorMessage() + "]\n";
            matcher.appendReplacement(result, java.util.regex.Matcher.quoteReplacement(errorText));
            emitter.send(SseEmitter.event()
                    .name("image_error")
                    .data(Map.of("index", index, "prompt", prompt, "error", imgResult.errorMessage())));
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

        // 融合多模态生成能力提示词
        String enhancedPrompt = buildSystemPromptWithGenerations(systemPrompt);
        if (enhancedPrompt != null && !enhancedPrompt.trim().isEmpty()) {
            messages.add(makeMsg("system", enhancedPrompt));
        }

        if (history != null && !history.isEmpty()) {
            messages.addAll(history);
        }

        messages.add(makeMsg("user", message));
        return messages;
    }

    // ==================== AI助手对话（核心新增） ====================

    /** RAG 检索结果（上下文 + 引用来源） */
    private record RagResult(
            String context,
            List<Map<String, Object>> references
    ) {}

    /** RAG 重排序 Top-N */
    @Value("${ai.assistant.rag.rerank-top-n:3}")
    private int rerankTopN;

    /** RAG 相似度阈值 */
    @Value("${ai.assistant.rag.similarity-threshold:0.3}")
    private double ragSimilarityThreshold;

    /**
     * AI助手流式对话（核心方法）
     *
     * 流程：
     * 1. 加载助手配置（systemPrompt、modelConfig、knowledgeBaseIds）
     * 2. 获取或创建会话
     * 3. 保存用户消息
     * 4. RAG：从助手绑定的知识库中检索相关内容
     * 5. 构建带记忆的上下文（助手提示词 + RAG上下文 + 文档解析 + 摘要 + 滑动窗口）
     * 6. 流式调用LLM（支持多模态）
     * 7. 处理生成标记（文生图/图参生图/文生视频）
     * 8. 保存AI回复 + 异步后处理（摘要压缩、标题生成）
     * 9. 增加助手使用次数
     *
     * @param assistantId 助手ID
     * @param userId      用户ID
     * @param sessionId   会话ID（为空则自动创建）
     * @param message     用户消息
     * @param imageUrls   图片URL列表（多模态）
     * @param documentUrls 文档URL列表
     * @return 创建的会话ID和SSE发射器
     */
    public Map<String, Object> assistantStreamChat(Long assistantId, Long userId, Long sessionId,
                                                    String message, List<String> imageUrls,
                                                    List<String> documentUrls) {
        // 1. 加载助手配置
        AiAssistant assistant = assistantRepository.findById(AiAssistantId.of(assistantId))
                .orElseThrow(() -> new BusinessException(40400, "AI助手不存在"));

        ModelConfig modelConfig = assistant.getModelConfig();
        String assistantSystemPrompt = assistant.getSystemPrompt();
        // 使用助手配置的模型和参数
        String modelId = modelConfig != null ? modelConfig.getModelName() : null;
        Double temperature = modelConfig != null && modelConfig.getTemperature() != null
                ? modelConfig.getTemperature().doubleValue() : null;
        Double topP = modelConfig != null && modelConfig.getTopP() != null
                ? modelConfig.getTopP().doubleValue() : null;
        Integer maxTokens = modelConfig != null ? modelConfig.getMaxTokens() : null;
        log.info("助手[{}] 模型配置: modelId={}, temperature={}, topP={}, maxTokens={}",
                assistantId, modelId, temperature, topP, maxTokens);

        // 1.5 加载工作流技能
        List<AiAssistantWorkflowService.WorkflowSkillVO> workflowSkills = workflowSkillService.getWorkflowSkills(assistantId);
        String skillsPrompt = workflowSkillService.buildSkillsPrompt(workflowSkills);
        log.info("助手[{}] 加载工作流技能: {} 个", assistantId, workflowSkills.size());

        // 2. 获取或创建会话
        AiChatSession session;
        boolean isNewSession = false;
        if (sessionId != null) {
            session = getSessionAndVerifyOwner(sessionId, userId);
        } else {
            session = AiChatSession.create(UserId.of(userId));
            session = sessionRepository.save(session);
            isNewSession = true;
        }
        final Long finalSessionId = session.getId().value();

        boolean hasImages = imageUrls != null && !imageUrls.isEmpty();

        // 3. 保存用户消息
        List<String> allAttachments = new ArrayList<>();
        if (imageUrls != null) allAttachments.addAll(imageUrls);
        if (documentUrls != null) allAttachments.addAll(documentUrls);
        AiChatMessage userMsg = AiChatMessage.create(
                AiChatSessionId.of(finalSessionId), UserId.of(userId),
                "user", message, allAttachments.isEmpty() ? null : allAttachments
        );
        messageRepository.save(userMsg);
        session.incrementMessageCount(1);

        SseEmitter emitter = new SseEmitter(300000L);

        // 发送会话ID（便于前端获取新建会话的ID）
        final AiChatSession finalSession = session;
        final boolean finalIsNewSession = isNewSession;

        executor.execute(() -> {
            try {
                // 发送会话元数据
                emitter.send(SseEmitter.event()
                        .name("session")
                        .data(Map.of(
                                "sessionId", finalSessionId,
                                "isNew", finalIsNewSession,
                                "assistantId", assistantId
                        )));

                // 4. RAG 知识库检索
                List<Long> knowledgeBaseIds = assistantRepository.findKnowledgeBaseIds(AiAssistantId.of(assistantId));
                log.info("助手[{}] 绑定知识库IDs: {}", assistantId, knowledgeBaseIds);
                String ragContext = null;
                if (!knowledgeBaseIds.isEmpty()) {
                    emitter.send(SseEmitter.event()
                            .name("rag_searching")
                            .data(Map.of("knowledgeBaseCount", knowledgeBaseIds.size(),
                                    "query", message)));
                    RagResult ragResult = retrieveFromKnowledgeBases(knowledgeBaseIds, message);
                    if (ragResult != null) {
                        ragContext = ragResult.context();
                        log.info("助手[{}] RAG检索完成，上下文长度: {}, 引用{}条", assistantId,
                                ragContext.length(), ragResult.references().size());
                        Map<String, Object> ragCompletedData = new LinkedHashMap<>();
                        ragCompletedData.put("found", true);
                        ragCompletedData.put("contextLength", ragContext.length());
                        ragCompletedData.put("references", ragResult.references());
                        emitter.send(SseEmitter.event()
                                .name("rag_completed")
                                .data(ragCompletedData));
                    } else {
                        log.warn("助手[{}] RAG检索无相关结果", assistantId);
                        emitter.send(SseEmitter.event()
                                .name("rag_completed")
                                .data(Map.of("found", false)));
                    }
                }

                // 5. 解析文档内容（如果有）
                final List<String> safeDocUrls = documentUrls != null ? documentUrls : List.of();
                String documentContext = null;
                if (!safeDocUrls.isEmpty()) {
                    log.info("助手[{}] 开始解析{}个文档", assistantId, safeDocUrls.size());
                    List<DocumentParseService.ParsedDocument> parsedDocs = new ArrayList<>();
                    for (String docUrl : safeDocUrls) {
                        parsedDocs.add(documentParseService.parseFromUrl(docUrl));
                    }
                    documentContext = documentParseService.formatForAiContext(parsedDocs);
                    log.info("助手[{}] 文档解析完成，上下文长度: {}", assistantId, documentContext.length());
                }

                // 6. 构建带记忆的上下文（注入助手提示词 + RAG + 文档 + 工作流技能）
                List<Map<String, String>> contextMessages = buildAssistantContext(
                        finalSession, assistantSystemPrompt, ragContext, documentContext, skillsPrompt);

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

                // 7. 调用LLM（使用助手配置的模型参数）
                final List<String> safeImageUrls = imageUrls != null ? imageUrls : List.of();
                if (hasImages) {
                    log.info("助手[{}] 使用多模态模型，图片数: {}, modelId={}", assistantId, safeImageUrls.size(), modelId);
                    langchainChatService.streamChatWithImagesAndParams(
                            modelId, contextMessages, safeImageUrls,
                            temperature, topP, maxTokens, callback);
                } else {
                    langchainChatService.streamChatWithParams(
                            modelId, contextMessages,
                            temperature, topP, maxTokens, callback);
                }

                // 8. 处理生成标记（文生图 / 图参生图 / 文生视频）
                String aiResponse = fullResponse.toString();
                aiResponse = processGenerationMarkers(aiResponse, emitter, safeImageUrls);

                // 8.5 处理工作流技能调用标记
                aiResponse = processWorkflowCallMarkers(aiResponse, assistantId, userId, emitter);

                // 9. 保存AI回复
                AiChatMessage assistantMsg = AiChatMessage.create(
                        AiChatSessionId.of(finalSessionId), UserId.of(userId),
                        "assistant", aiResponse, null
                );
                messageRepository.save(assistantMsg);
                finalSession.incrementMessageCount(1);
                sessionRepository.save(finalSession);

                emitter.send(SseEmitter.event()
                        .name("done")
                        .data("[DONE]"));
                emitter.complete();

                log.info("助手[{}] 会话[{}] 流式对话完成，回复字符数: {}", assistantId, finalSessionId, aiResponse.length());

                // 10. 异步后处理：摘要压缩 + 标题生成 + 使用次数
                executor.execute(() -> {
                    postProcessSession(finalSession);
                    // 增加助手使用次数
                    try {
                        assistant.incrementUsageCount();
                        assistantRepository.save(assistant);
                    } catch (Exception e) {
                        log.warn("更新助手使用次数失败: assistantId={}", assistantId, e);
                    }
                });

            } catch (Exception e) {
                log.error("助手[{}] 会话[{}] 流式对话异常", assistantId, finalSessionId, e);
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

        Map<String, Object> result = new HashMap<>();
        result.put("emitter", emitter);
        result.put("sessionId", finalSessionId);
        result.put("isNewSession", isNewSession);
        return result;
    }

    /**
     * 构建AI助手对话上下文
     * 
     * 结构：
     * [system（助手配置的提示词 + 多模态能力提示词 + 工作流技能提示词）]
     * [system（RAG知识库检索结果）]
     * [system（文档解析内容）]
     * [system（记忆摘要）]
     * [最近 windowSize 条未摘要消息]
     */
    private List<Map<String, String>> buildAssistantContext(AiChatSession session,
                                                            String assistantSystemPrompt,
                                                            String ragContext,
                                                            String documentContext,
                                                            String skillsPrompt) {
        List<Map<String, String>> messages = new ArrayList<>();

        // 1. 助手的 system prompt（融合多模态生成能力提示词 + 工作流技能提示词）
        String enhancedPrompt = buildSystemPromptWithGenerations(assistantSystemPrompt);
        if (skillsPrompt != null && !skillsPrompt.isBlank()) {
            enhancedPrompt = (enhancedPrompt != null ? enhancedPrompt : "") + skillsPrompt;
        }
        if (enhancedPrompt != null && !enhancedPrompt.trim().isEmpty()) {
            messages.add(makeMsg("system", enhancedPrompt));
        }

        // 2. RAG 知识库检索结果
        if (ragContext != null && !ragContext.isBlank()) {
            String ragPrompt = "以下是从知识库中检索到的相关参考资料，请优先基于这些内容回答用户问题。" +
                    "如果参考资料不足以回答，可以结合你的知识适当补充，但需说明。\n\n" + ragContext;
            messages.add(makeMsg("system", ragPrompt));
        }

        // 3. 注入文档上下文（如果有）
        if (documentContext != null && !documentContext.isBlank()) {
            messages.add(makeMsg("system", documentContext));
        }

        // 4. 注入记忆摘要
        if (session.getMemorySummary() != null && !session.getMemorySummary().trim().isEmpty()) {
            String summaryPrompt = "以下是之前对话的摘要，请结合这些上下文继续对话：\n" + session.getMemorySummary();
            messages.add(makeMsg("system", summaryPrompt));
        }

        // 5. 取滑动窗口内的未摘要消息
        List<AiChatMessage> unsummarized = messageRepository.findUnsummarizedBySessionId(session.getId());
        int startIndex = Math.max(0, unsummarized.size() - windowSize);
        List<AiChatMessage> windowMessages = unsummarized.subList(startIndex, unsummarized.size());

        for (AiChatMessage msg : windowMessages) {
            messages.add(makeMsg(msg.getRole(), msg.getContent()));
        }

        log.info("助手对话上下文构建: 摘要={}, RAG={}, 文档={}, 技能={}, 窗口消息数={}",
                session.getMemorySummary() != null ? "有" : "无",
                ragContext != null ? "有" : "无",
                documentContext != null ? "有" : "无",
                skillsPrompt != null ? "有" : "无",
                windowMessages.size());

        return messages;
    }

    /**
     * 从多个知识库中检索相关内容（RAG）
     * 
     * 委托给 KnowledgeSearchService 执行标准 RAG 管线：
     * 1. embedQuery（text_type=query，区别于文档入库的 document 类型）
     * 2. 向量召回（recall topK = finalTopK × 3，至少20条候选）
     * 3. 相似度阈值过滤
     * 4. Rerank 精排
     * 5. 返回 top-N 结果
     */
    private RagResult retrieveFromKnowledgeBases(List<Long> knowledgeBaseIds, String query) {
        try {
            log.info("RAG检索开始: query=[{}], 知识库IDs={}, topK={}, threshold={}",
                    query, knowledgeBaseIds, rerankTopN, ragSimilarityThreshold);

            KnowledgeSearchService.SearchRequest request = KnowledgeSearchService.SearchRequest.builder()
                    .knowledgeBaseIds(knowledgeBaseIds)
                    .query(query)
                    .topK(rerankTopN)
                    .similarityThreshold(ragSimilarityThreshold)
                    .retrievalMode("hybrid")
                    .build();

            KnowledgeSearchService.SearchResult result = knowledgeSearchService.search(request);

            if (result.getDocuments() == null || result.getDocuments().isEmpty()) {
                log.warn("RAG检索无结果: knowledgeBaseIds={}, 耗时{}ms", knowledgeBaseIds, result.getSearchTimeMs());
                return null;
            }

            // 格式化为上下文 + 构建引用来源
            StringBuilder context = new StringBuilder("【知识库参考资料】\n\n");
            List<Map<String, Object>> references = new ArrayList<>();
            int idx = 1;
            for (KnowledgeSearchService.DocumentChunk doc : result.getDocuments()) {
                context.append(String.format("参考 %d（相关度: %.2f）：\n%s\n\n",
                        idx, doc.getScore(), doc.getContent()));

                Map<String, Object> ref = new LinkedHashMap<>();
                ref.put("index", idx);
                ref.put("score", doc.getScore());
                ref.put("documentId", doc.getDocumentId());
                ref.put("documentName", doc.getDocumentName());
                ref.put("contentPreview", doc.getContent().substring(0, Math.min(100, doc.getContent().length())));
                if (doc.getMetadata() != null) {
                    ref.put("metadata", doc.getMetadata());
                }
                references.add(ref);

                log.info("RAG结果[{}]: score={}, docName={}, content前50字=[{}]",
                        idx, doc.getScore(),
                        doc.getDocumentName() != null ? doc.getDocumentName() : "unknown",
                        doc.getContent().substring(0, Math.min(50, doc.getContent().length())));
                idx++;
            }

            log.info("RAG检索完成: {}条参考资料, 上下文长度={}, 耗时{}ms",
                    result.getDocuments().size(), context.length(), result.getSearchTimeMs());
            return new RagResult(context.toString(), references);

        } catch (Exception e) {
            log.error("RAG知识库检索异常: knowledgeBaseIds={}, query=[{}]", knowledgeBaseIds, query, e);
            return null;
        }
    }

    /**
     * 处理工作流技能调用标记
     * 检测 LLM 回复中的 [CALL_WORKFLOW:{...}] 标记，执行对应工作流并将结果追加到回复中
     */
    private String processWorkflowCallMarkers(String response, Long assistantId, Long userId, SseEmitter emitter) {
        // 匹配 [CALL_WORKFLOW:{"workflowId":xxx, "params":{...}}]
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(
                "\\[CALL_WORKFLOW:\\s*(\\{.*?\\})\\s*\\]", 
                java.util.regex.Pattern.DOTALL);
        java.util.regex.Matcher matcher = pattern.matcher(response);

        if (!matcher.find()) {
            return response;
        }

        String jsonStr = matcher.group(1);
        log.info("助手[{}] 检测到工作流调用标记: {}", assistantId, jsonStr);

        try {
            // 发送工作流调用开始事件
            emitter.send(SseEmitter.event()
                    .name("workflow_calling")
                    .data(Map.of("json", jsonStr)));

            // 解析 JSON
            com.fasterxml.jackson.databind.ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper();
            @SuppressWarnings("unchecked")
            Map<String, Object> callSpec = objectMapper.readValue(jsonStr, Map.class);

            Object wfIdObj = callSpec.get("workflowId");
            Long workflowId = null;
            if (wfIdObj instanceof Number) {
                workflowId = ((Number) wfIdObj).longValue();
            } else if (wfIdObj instanceof String) {
                workflowId = Long.parseLong((String) wfIdObj);
            }

            if (workflowId == null) {
                log.warn("工作流调用缺少 workflowId");
                return response;
            }

            @SuppressWarnings("unchecked")
            Map<String, Object> params = (Map<String, Object>) callSpec.getOrDefault("params", Map.of());

            // 执行工作流
            log.info("助手[{}] 执行工作流: workflowId={}, params={}", assistantId, workflowId, params);
            Map<String, Object> workflowResult = workflowSkillService.executeWorkflow(assistantId, workflowId, params, userId);

            // 发送工作流执行完成事件
            emitter.send(SseEmitter.event()
                    .name("workflow_completed")
                    .data(Map.of(
                            "workflowId", workflowId,
                            "result", workflowResult
                    )));

            // 将工作流结果追加到回复中（替换原标记）
            String resultJson = objectMapper.writeValueAsString(workflowResult);
            String replacement = "\n\n**工作流执行结果：**\n```json\n" + resultJson + "\n```\n";
            String newResponse = matcher.replaceFirst(java.util.regex.Matcher.quoteReplacement(replacement));

            log.info("助手[{}] 工作流执行成功: workflowId={}, resultKeys={}", 
                    assistantId, workflowId, workflowResult.keySet());
            return newResponse;

        } catch (Exception e) {
            log.error("助手[{}] 工作流调用失败: json={}", assistantId, jsonStr, e);
            try {
                emitter.send(SseEmitter.event()
                        .name("workflow_error")
                        .data(Map.of("error", e.getMessage())));
            } catch (Exception ignored) {}
            // 调用失败时保留原文
            return response;
        }
    }
}
