package com.novacloudedu.backend.application.dailylearning.command;

import java.time.LocalDate;
import java.util.List;

/**
 * 创建每日文章命令
 */
public record CreateDailyArticleCommand(
        String title,
        String content,
        String summary,
        String coverImage,
        String author,
        String source,
        String sourceUrl,
        String category,
        List<String> tags,
        Integer difficulty,
        Integer readTime,
        LocalDate publishDate
) {}
