package com.novacloudedu.backend.domain.dailylearning.service;

/**
 * 文章 AI 处理服务接口
 * 提供文章内容的 AI 排版和摘要生成功能
 */
public interface ArticleAiService {

    /**
     * AI 处理结果
     */
    record AiProcessResult(
            String formattedContent,  // Markdown 格式化后的内容
            String summary            // AI 生成的摘要
    ) {}

    /**
     * 处理文章内容：格式化为 Markdown 并生成摘要
     *
     * @param rawContent 原始文章内容
     * @param title      文章标题（用于上下文）
     * @return AI 处理结果
     */
    AiProcessResult processArticle(String rawContent, String title);

    /**
     * 仅格式化文章内容为 Markdown
     *
     * @param rawContent 原始文章内容
     * @return Markdown 格式化后的内容
     */
    String formatToMarkdown(String rawContent);

    /**
     * 仅生成文章摘要
     *
     * @param content 文章内容
     * @param title   文章标题
     * @param maxLength 摘要最大长度
     * @return AI 生成的摘要
     */
    String generateSummary(String content, String title, int maxLength);
}
