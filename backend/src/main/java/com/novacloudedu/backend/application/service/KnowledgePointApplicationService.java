package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.entity.KnowledgePoint;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.repository.KnowledgePointRepository;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.KnowledgePointType;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 知识点提取应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgePointApplicationService {

    private final ChapterRepository chapterRepository;
    private final KnowledgePointRepository knowledgePointRepository;
    private final LlmService llmService;
    private final Gson gson;

    @Value("${ai.knowledge.max-points:20}")
    private int maxPoints;

    /**
     * 提取章节知识点
     */
    @Transactional
    public List<KnowledgePoint> extractKnowledgePoints(Long chapterId) {
        ChapterId id = ChapterId.of(chapterId);
        
        log.info("开始提取章节知识点: chapterId={}", chapterId);

        // 检查是否已提取
        List<KnowledgePoint> existing = knowledgePointRepository.findByChapterId(id);
        if (!existing.isEmpty()) {
            log.info("章节已有知识点，返回缓存结果: count={}", existing.size());
            return existing;
        }

        // 获取章节内容
        Chapter chapter = chapterRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("章节不存在: " + chapterId));

        // 使用LLM提取知识点
        String systemPrompt = buildSystemPrompt();
        String userMessage = buildUserMessage(chapter);
        
        String response = llmService.chatWithSystemPrompt(systemPrompt, userMessage);
        
        // 解析LLM响应
        List<KnowledgePoint> points = parseKnowledgePoints(id, response);
        
        // 保存知识点
        List<KnowledgePoint> saved = knowledgePointRepository.saveAll(points);
        log.info("知识点提取完成: count={}", saved.size());
        
        return saved;
    }

    /**
     * 获取章节知识点
     */
    public List<KnowledgePoint> getKnowledgePoints(Long chapterId) {
        ChapterId id = ChapterId.of(chapterId);
        return knowledgePointRepository.findByChapterId(id);
    }

    /**
     * 按类型获取知识点
     */
    public List<KnowledgePoint> getKnowledgePointsByType(Long chapterId, String type) {
        ChapterId id = ChapterId.of(chapterId);
        KnowledgePointType pointType = KnowledgePointType.valueOf(type.toUpperCase());
        return knowledgePointRepository.findByChapterIdAndType(id, pointType);
    }

    /**
     * 搜索知识点
     */
    public List<KnowledgePoint> searchKnowledgePoints(String keyword, int page, int size) {
        return knowledgePointRepository.searchByName(keyword, page, size);
    }

    /**
     * 重新提取知识点
     */
    @Transactional
    public List<KnowledgePoint> regenerateKnowledgePoints(Long chapterId) {
        ChapterId id = ChapterId.of(chapterId);
        
        // 删除旧的知识点
        knowledgePointRepository.deleteByChapterId(id);
        
        // 重新提取
        return extractKnowledgePoints(chapterId);
    }

    /**
     * 构建系统提示词
     */
    private String buildSystemPrompt() {
        return String.format(
                "你是一个专业的知识点提取助手。请从给定的章节内容中提取关键知识点。\n" +
                "知识点类型包括：\n" +
                "- CONCEPT: 重要概念\n" +
                "- TERM: 专业术语\n" +
                "- FORMULA: 公式\n" +
                "- PRINCIPLE: 原理\n" +
                "- METHOD: 方法\n\n" +
                "请以JSON数组格式返回，每个知识点包含：\n" +
                "- type: 知识点类型\n" +
                "- name: 知识点名称\n" +
                "- description: 简要描述\n\n" +
                "最多提取%d个最重要的知识点。\n" +
                "示例格式：\n" +
                "[{\"type\":\"CONCEPT\",\"name\":\"领域驱动设计\",\"description\":\"一种软件开发方法论...\"}]",
                maxPoints
        );
    }

    /**
     * 构建用户消息
     */
    private String buildUserMessage(Chapter chapter) {
        return String.format(
                "章节标题：%s\n\n章节内容：\n%s",
                chapter.getTitle(),
                chapter.getContent()
        );
    }

    /**
     * 解析知识点
     */
    private List<KnowledgePoint> parseKnowledgePoints(ChapterId chapterId, String response) {
        List<KnowledgePoint> points = new ArrayList<>();
        
        try {
            // 尝试提取JSON数组
            String jsonStr = extractJsonArray(response);
            JsonArray jsonArray = gson.fromJson(jsonStr, JsonArray.class);
            
            int position = 0;
            for (JsonElement element : jsonArray) {
                JsonObject obj = element.getAsJsonObject();
                
                String typeStr = obj.get("type").getAsString();
                String name = obj.get("name").getAsString();
                String description = obj.has("description") ? 
                        obj.get("description").getAsString() : "";
                
                KnowledgePointType type;
                try {
                    type = KnowledgePointType.valueOf(typeStr.toUpperCase());
                } catch (IllegalArgumentException e) {
                    log.warn("未知的知识点类型: {}，使用CONCEPT", typeStr);
                    type = KnowledgePointType.CONCEPT;
                }
                
                KnowledgePoint point = KnowledgePoint.create(
                        chapterId,
                        type,
                        name,
                        description,
                        position++
                );
                points.add(point);
            }
        } catch (Exception e) {
            log.error("解析知识点失败，尝试使用简单解析", e);
            points = parseKnowledgePointsSimple(chapterId, response);
        }
        
        return points;
    }

    /**
     * 提取JSON数组
     */
    private String extractJsonArray(String text) {
        int start = text.indexOf('[');
        int end = text.lastIndexOf(']');
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return text;
    }

    /**
     * 简单解析（当JSON解析失败时）
     */
    private List<KnowledgePoint> parseKnowledgePointsSimple(ChapterId chapterId, String response) {
        List<KnowledgePoint> points = new ArrayList<>();
        
        String[] lines = response.split("\n");
        int position = 0;
        
        for (String line : lines) {
            String trimmed = line.trim();
            if (trimmed.isEmpty()) continue;
            
            // 尝试提取知识点名称
            String name = null;
            if (trimmed.startsWith("- ") || trimmed.startsWith("• ")) {
                name = trimmed.substring(2).trim();
            } else if (trimmed.matches("^\\d+\\.\\s+.*")) {
                name = trimmed.replaceFirst("^\\d+\\.\\s+", "").trim();
            }
            
            if (name != null && name.length() > 2) {
                KnowledgePoint point = KnowledgePoint.create(
                        chapterId,
                        KnowledgePointType.CONCEPT,
                        name,
                        "",
                        position++
                );
                points.add(point);
                
                if (points.size() >= maxPoints) {
                    break;
                }
            }
        }
        
        return points;
    }
}
