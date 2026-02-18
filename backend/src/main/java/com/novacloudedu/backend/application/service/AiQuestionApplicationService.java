package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.book.entity.AiConversation;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.AiConversationRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.service.RagService;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * AI问答应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiQuestionApplicationService {

    private final AiConversationRepository conversationRepository;
    private final ChapterRepository chapterRepository;
    private final LlmService llmService;

    @Value("${ai.conversation.max-history:10}")
    private int maxHistory;

    @Value("${ai.rag.enabled:true}")
    private boolean ragEnabled;

    @Value("${ai.rag.top-k:5}")
    private int topK;

    /**
     * 提问（新对话）
     */
    @Transactional
    public Map<String, Object> askQuestion(Long userId, Long bookId, String question, Long chapterId) {
        log.info("用户提问: userId={}, bookId={}, question={}", userId, bookId, question);

        // 创建新对话
        AiConversation conversation = AiConversation.create(
                UserId.of(userId),
                BookId.of(bookId),
                chapterId != null ? ChapterId.of(chapterId) : null,
                ConversationType.QA
        );

        // 添加用户问题
        conversation.addUserMessage(question);

        // 生成回答
        String answer;
        List<Map<String, Object>> sources = new ArrayList<>();

        if (ragEnabled && chapterId != null) {
            // 使用RAG检索相关内容
            Map<String, Object> ragResult = answerWithRag(ChapterId.of(chapterId), question);
            answer = (String) ragResult.get("answer");
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> ragSources = (List<Map<String, Object>>) ragResult.get("sources");
            sources = ragSources;
        } else {
            // 直接使用LLM回答
            String systemPrompt = "你是一个专业的阅读助手，请根据用户的问题提供准确、有帮助的回答。";
            answer = llmService.chatWithSystemPrompt(systemPrompt, question);
        }

        // 添加AI回复
        conversation.addAssistantMessage(answer);

        // 保存对话
        AiConversation saved = conversationRepository.save(conversation);

        // 返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("conversationId", saved.getId().getValue());
        result.put("answer", answer);
        result.put("sources", sources);
        return result;
    }

    /**
     * 继续对话
     */
    @Transactional
    public Map<String, Object> continueConversation(Long conversationId, String question) {
        log.info("继续对话: conversationId={}, question={}", conversationId, question);

        // 获取对话
        AiConversation conversation = conversationRepository.findById(AiConversationId.of(conversationId))
                .orElseThrow(() -> new IllegalArgumentException("对话不存在: " + conversationId));

        // 添加用户问题
        conversation.addUserMessage(question);

        // 构建对话历史
        List<Map<String, String>> messages = buildConversationHistory(conversation);

        // 生成回答
        String answer = llmService.chat(messages);

        // 添加AI回复
        conversation.addAssistantMessage(answer);

        // 保存对话
        conversationRepository.save(conversation);

        // 返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("conversationId", conversationId);
        result.put("answer", answer);
        return result;
    }

    /**
     * 获取对话历史
     */
    public AiConversation getConversation(Long conversationId) {
        return conversationRepository.findById(AiConversationId.of(conversationId))
                .orElseThrow(() -> new IllegalArgumentException("对话不存在: " + conversationId));
    }

    /**
     * 获取用户的对话列表
     */
    public List<AiConversation> getUserConversations(Long userId, int page, int size) {
        return conversationRepository.findByUserId(UserId.of(userId), page, size);
    }

    /**
     * 使用RAG回答问题
     */
    private Map<String, Object> answerWithRag(ChapterId chapterId, String question) {
        // 获取章节内容
        Chapter chapter = chapterRepository.findById(chapterId)
                .orElseThrow(() -> new IllegalArgumentException("章节不存在"));

        // 简化版RAG：直接使用章节内容
        String systemPrompt = "你是一个专业的阅读助手。请根据提供的章节内容回答用户的问题。" +
                "如果问题的答案不在章节内容中，请明确告知用户。";

        String userMessage = String.format(
                "章节内容：\n%s\n\n用户问题：%s",
                chapter.getContent(),
                question
        );

        String answer = llmService.chatWithSystemPrompt(systemPrompt, userMessage);

        // 构建来源信息
        List<Map<String, Object>> sources = new ArrayList<>();
        Map<String, Object> source = new HashMap<>();
        source.put("chapterId", chapter.getId().value());
        source.put("chapterTitle", chapter.getTitle());
        source.put("excerpt", chapter.getContent().substring(0, Math.min(200, chapter.getContent().length())) + "...");
        sources.add(source);

        Map<String, Object> result = new HashMap<>();
        result.put("answer", answer);
        result.put("sources", sources);
        return result;
    }

    /**
     * 构建对话历史
     */
    private List<Map<String, String>> buildConversationHistory(AiConversation conversation) {
        List<AiConversation.ConversationMessage> recentMessages = 
                conversation.getRecentMessages(maxHistory * 2);

        List<Map<String, String>> messages = new ArrayList<>();
        
        // 添加系统提示
        Map<String, String> systemMsg = new HashMap<>();
        systemMsg.put("role", "system");
        systemMsg.put("content", "你是一个专业的阅读助手，请根据对话历史提供准确、有帮助的回答。");
        messages.add(systemMsg);

        // 添加历史消息
        for (AiConversation.ConversationMessage msg : recentMessages) {
            Map<String, String> message = new HashMap<>();
            message.put("role", msg.getRole());
            message.put("content", msg.getContent());
            messages.add(message);
        }

        return messages;
    }
}
