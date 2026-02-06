package com.novacloudedu.backend.application.dailylearning.service;

import com.novacloudedu.backend.application.dailylearning.command.AiProcessArticleCommand;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.service.ArticleAiService;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 文章 AI 处理应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ArticleAiApplicationService {

    private final ArticleAiService articleAiService;
    private final DailyArticleRepository dailyArticleRepository;

    /**
     * AI 处理已有文章
     * 
     * @param command AI 处理命令
     * @return 处理后的文章
     */
    @Transactional
    public DailyArticle processExistingArticle(AiProcessArticleCommand command) {
        DailyArticle article = dailyArticleRepository.findById(DailyArticleId.of(command.getArticleId()))
                .orElseThrow(() -> new IllegalArgumentException("文章不存在: " + command.getArticleId()));

        log.info("开始 AI 处理文章: {} (ID: {})", article.getTitle(), command.getArticleId());

        String newContent = article.getContent();
        String newSummary = article.getSummary();

        if (command.isFormatContent() && command.isGenerateSummary()) {
            // 同时处理内容和摘要
            ArticleAiService.AiProcessResult result = articleAiService.processArticle(
                    article.getContent(), article.getTitle());
            newContent = result.formattedContent();
            newSummary = result.summary();
        } else {
            if (command.isFormatContent()) {
                newContent = articleAiService.formatToMarkdown(article.getContent());
            }
            if (command.isGenerateSummary()) {
                newSummary = articleAiService.generateSummary(
                        article.getContent(), article.getTitle(), command.getSummaryMaxLength());
            }
        }

        // 更新文章
        article.updateContentAndSummary(newContent, newSummary);
        article = dailyArticleRepository.save(article);

        log.info("AI 处理文章完成: {} (ID: {})", article.getTitle(), command.getArticleId());
        return article;
    }

    /**
     * 批量 AI 处理文章
     * 
     * @param articleIds 文章ID列表
     * @return 成功处理的数量
     */
    @Transactional
    public int batchProcessArticles(java.util.List<Long> articleIds, boolean formatContent, boolean generateSummary) {
        int successCount = 0;
        for (Long articleId : articleIds) {
            try {
                AiProcessArticleCommand command = AiProcessArticleCommand.builder()
                        .articleId(articleId)
                        .formatContent(formatContent)
                        .generateSummary(generateSummary)
                        .build();
                processExistingArticle(command);
                successCount++;
            } catch (Exception e) {
                log.error("AI 处理文章失败: ID={}", articleId, e);
            }
        }
        return successCount;
    }

    /**
     * 预览 AI 处理结果（不保存）
     */
    public ArticleAiService.AiProcessResult previewAiProcess(String content, String title) {
        return articleAiService.processArticle(content, title);
    }
}
