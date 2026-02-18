package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.infrastructure.ai.DashScopeLlmService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 文章 AI 对话服务
 * 提供用户与文章内容进行 AI 对话的功能
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ArticleChatService {

    private final DailyArticleRepository dailyArticleRepository;
    private final DashScopeLlmService llmService;

    private static final String ARTICLE_CHAT_SYSTEM_PROMPT = """
            你是一个智能阅读助手，帮助用户理解和讨论文章内容。
            
            当前文章标题：%s
            
            文章内容摘要：
            %s
            
            请基于以上文章内容回答用户的问题。要求：
            1. 回答要准确、简洁、有帮助
            2. 如果问题超出文章范围，可以结合你的知识适当扩展，但要说明
            3. 使用友好的语气交流
            4. 可以引用文章中的具体内容来支持你的回答
            """;

    /**
     * 流式对话（SSE）
     */
    public void streamChat(Long articleId, String userMessage, List<Map<String, String>> history, 
                          SseEmitter emitter) {
        try {
            // 获取文章信息
            DailyArticle article = dailyArticleRepository.findById(DailyArticleId.of(articleId))
                    .orElseThrow(() -> new IllegalArgumentException("文章不存在: " + articleId));

            // 构建消息列表
            List<Map<String, String>> messages = buildMessages(article, userMessage, history);

            log.info("开始文章对话流式输出: articleId={}, userMessage={}", articleId, userMessage);

            // 调用流式 LLM
            llmService.streamChatWithMessages(messages, token -> {
                try {
                    emitter.send(SseEmitter.event()
                            .name("message")
                            .data(Map.of("content", token)));
                } catch (IOException e) {
                    log.warn("SSE 发送失败", e);
                }
            });

            // 完成
            emitter.send(SseEmitter.event().name("done").data("[DONE]"));
            emitter.complete();
            log.info("文章对话流式输出完成: articleId={}", articleId);

        } catch (Exception e) {
            log.error("文章对话失败: articleId={}", articleId, e);
            try {
                emitter.send(SseEmitter.event()
                        .name("error")
                        .data(Map.of("error", e.getMessage())));
                emitter.completeWithError(e);
            } catch (IOException ex) {
                log.warn("SSE 错误发送失败", ex);
            }
        }
    }

    /**
     * 非流式对话
     */
    public String chat(Long articleId, String userMessage, List<Map<String, String>> history) {
        // 获取文章信息
        DailyArticle article = dailyArticleRepository.findById(DailyArticleId.of(articleId))
                .orElseThrow(() -> new IllegalArgumentException("文章不存在: " + articleId));

        // 构建消息列表
        List<Map<String, String>> messages = buildMessages(article, userMessage, history);

        log.info("开始文章对话: articleId={}, userMessage={}", articleId, userMessage);
        String response = llmService.chat(messages);
        log.info("文章对话完成: articleId={}", articleId);

        return response;
    }

    /**
     * 构建消息列表
     */
    private List<Map<String, String>> buildMessages(DailyArticle article, String userMessage, 
                                                     List<Map<String, String>> history) {
        List<Map<String, String>> messages = new ArrayList<>();

        // 系统提示词
        String contentSummary = truncateContent(article.getContent(), 2000);
        String systemPrompt = String.format(ARTICLE_CHAT_SYSTEM_PROMPT, 
                article.getTitle(), contentSummary);
        messages.add(Map.of("role", "system", "content", systemPrompt));

        // 历史消息
        if (history != null && !history.isEmpty()) {
            messages.addAll(history);
        }

        // 当前用户消息
        messages.add(Map.of("role", "user", "content", userMessage));

        return messages;
    }

    /**
     * 截断内容
     */
    private String truncateContent(String content, int maxLength) {
        if (content == null) return "";
        if (content.length() <= maxLength) return content;
        return content.substring(0, maxLength) + "...";
    }
}
