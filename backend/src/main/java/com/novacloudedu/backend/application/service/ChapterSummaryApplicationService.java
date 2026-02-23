package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.entity.ChapterSummary;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterSummaryRepository;
import com.novacloudedu.backend.domain.book.service.ContentSecurityService;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.SummaryType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

/**
 * 章节总结应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChapterSummaryApplicationService {

    private final ChapterRepository chapterRepository;
    private final ChapterSummaryRepository summaryRepository;
    private final LlmService llmService;
    private final ContentSecurityService contentSecurityService;

    @Value("${ai.summary.cache-enabled:true}")
    private boolean cacheEnabled;

    @Value("${book.content.encryption.enabled:false}")
    private boolean encryptionEnabled;

    @Value("${book.content.encryption.secret-key:NovaCloudEduBookKey1}")
    private String encryptionSecretKey;

    /**
     * 生成章节总结
     */
    @Transactional
    public ChapterSummary generateSummary(Long chapterId, String summaryType) {
        ChapterId id = ChapterId.of(chapterId);
        SummaryType type = SummaryType.valueOf(summaryType.toUpperCase());

        // 检查缓存
        if (cacheEnabled) {
            Optional<ChapterSummary> cached = summaryRepository.findByChapterIdAndType(id, type);
            if (cached.isPresent()) {
                log.info("使用缓存的章节总结: chapterId={}, type={}", chapterId, type);
                return cached.get();
            }
        }

        // 获取章节内容
        Chapter chapter = chapterRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("章节不存在: " + chapterId));

        // 生成总结
        log.info("开始生成章节总结: chapterId={}, type={}", chapterId, type);
        String systemPrompt = buildSystemPrompt(type);
        String userMessage = buildUserMessage(chapter, type);
        
        String summaryContent = llmService.chatWithSystemPrompt(systemPrompt, userMessage);
        
        // 提取关键要点
        List<String> keyPoints = extractKeyPoints(summaryContent, type);

        // 创建并保存总结
        ChapterSummary summary = ChapterSummary.create(
                id,
                type,
                summaryContent,
                keyPoints,
                llmService.getModelName()
        );

        ChapterSummary saved = summaryRepository.save(summary);
        log.info("章节总结生成完成: summaryId={}", saved.getId());
        return saved;
    }

    /**
     * 获取章节总结
     */
    public Optional<ChapterSummary> getSummary(Long chapterId, String summaryType) {
        ChapterId id = ChapterId.of(chapterId);
        SummaryType type = SummaryType.valueOf(summaryType.toUpperCase());
        return summaryRepository.findByChapterIdAndType(id, type);
    }

    /**
     * 获取章节所有类型的总结
     */
    public List<ChapterSummary> getAllSummaries(Long chapterId) {
        ChapterId id = ChapterId.of(chapterId);
        return summaryRepository.findByChapterId(id);
    }

    /**
     * 重新生成总结（清除缓存）
     */
    @Transactional
    public ChapterSummary regenerateSummary(Long chapterId, String summaryType) {
        ChapterId id = ChapterId.of(chapterId);
        SummaryType type = SummaryType.valueOf(summaryType.toUpperCase());
        
        // 删除旧的总结
        summaryRepository.findByChapterIdAndType(id, type)
                .ifPresent(summary -> summaryRepository.delete(summary.getId()));
        
        // 生成新的总结
        return generateSummary(chapterId, summaryType);
    }

    /**
     * 构建系统提示词
     */
    private String buildSystemPrompt(SummaryType type) {
        switch (type) {
            case BRIEF:
                return "你是一个专业的文本总结助手。请用简洁的语言总结章节内容，控制在200字以内。";
            case DETAILED:
                return "你是一个专业的文本总结助手。请详细总结章节内容，包括主要观点、论据和结论。";
            case KEYPOINTS:
                return "你是一个专业的文本总结助手。请提取章节的关键要点，以条目形式列出，每个要点一行。";
            default:
                return "你是一个专业的文本总结助手。";
        }
    }

    /**
     * 构建用户消息
     */
    private String getDecryptedContent(Chapter chapter) {
        String content = chapter.getContent();
        if (encryptionEnabled && chapter.isEncrypted()) {
            try {
                content = contentSecurityService.decrypt(content, encryptionSecretKey, chapter.getEncryptionIv());
            } catch (Exception e) {
                log.error("章节内容解密失败: chapterId={}", chapter.getId(), e);
                throw new RuntimeException("内容解密失败", e);
            }
        }
        return content;
    }

    private String buildUserMessage(Chapter chapter, SummaryType type) {
        StringBuilder message = new StringBuilder();
        message.append("请总结以下章节内容：\n\n");
        message.append("章节标题：").append(chapter.getTitle()).append("\n\n");
        message.append("章节内容：\n").append(truncateForLlm(getDecryptedContent(chapter)));
        
        if (type == SummaryType.KEYPOINTS) {
            message.append("\n\n请以要点形式输出，每个要点以\"- \"开头。");
        }
        
        return message.toString();
    }

    private static final int MAX_CONTENT_LENGTH = 28000;

    private String truncateForLlm(String content) {
        if (content == null || content.isEmpty()) return "";
        String plain = content.replaceAll("<[^>]*>", " ").replaceAll("\\s+", " ").trim();
        if (plain.length() <= MAX_CONTENT_LENGTH) return plain;
        log.warn("章节内容过长({} 字符)，截断至 {} 字符", plain.length(), MAX_CONTENT_LENGTH);
        return plain.substring(0, MAX_CONTENT_LENGTH) + "\n\n[注意：内容过长，已截断]";
    }

    /**
     * 从总结中提取关键要点
     */
    private List<String> extractKeyPoints(String content, SummaryType type) {
        List<String> keyPoints = new ArrayList<>();
        
        if (type == SummaryType.KEYPOINTS) {
            // 按行分割，提取以"- "或"• "开头的要点
            String[] lines = content.split("\n");
            for (String line : lines) {
                String trimmed = line.trim();
                if (trimmed.startsWith("- ") || trimmed.startsWith("• ")) {
                    keyPoints.add(trimmed.substring(2).trim());
                } else if (trimmed.matches("^\\d+\\.\\s+.*")) {
                    // 处理 "1. xxx" 格式
                    String cleaned = trimmed.replaceFirst("^\\d+\\.\\s+", "");
                    keyPoints.add(cleaned);
                }
            }
        } else {
            // 对于其他类型，尝试提取句子作为要点
            String[] sentences = content.split("[。！？]");
            for (int i = 0; i < Math.min(5, sentences.length); i++) {
                String sentence = sentences[i].trim();
                if (sentence.length() > 10) {
                    keyPoints.add(sentence);
                }
            }
        }
        
        return keyPoints;
    }
}
