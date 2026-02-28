package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Query 理解与改写服务
 * 
 * 使用 LLM 对用户查询进行理解和改写，生成多个检索查询以提升召回率：
 * 1. 原始查询保留
 * 2. LLM 生成关键词提取版本
 * 3. LLM 生成同义扩展版本
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class QueryRewriteService {

    private final LangchainChatService chatService;

    private static final String REWRITE_PROMPT = 
        "你是一个搜索查询优化器。给定用户查询，生成2个优化后的搜索查询，每行一个。\n" +
        "第1行：提取核心关键词（去除停用词和冗余修饰）\n" +
        "第2行：用同义词或相关表述改写查询\n" +
        "只输出2行文本，不要编号、不要解释。\n\n" +
        "用户查询：%s";

    /**
     * 改写查询，返回包含原始查询和改写后查询的列表
     * 
     * @param originalQuery 原始查询
     * @return 查询列表（第一个始终是原始查询）
     */
    public List<String> rewriteQuery(String originalQuery) {
        return rewriteQuery(originalQuery, null);
    }

    /**
     * 改写查询（指定LLM模型）
     * 
     * @param originalQuery 原始查询
     * @param modelId LLM 模型ID（如 "dashscope/qwen-turbo"），null 使用默认模型
     * @return 查询列表（第一个始终是原始查询）
     */
    public List<String> rewriteQuery(String originalQuery, String modelId) {
        List<String> queries = new ArrayList<>();
        queries.add(originalQuery);

        if (originalQuery == null || originalQuery.trim().length() < 4) {
            return queries;
        }

        try {
            String prompt = String.format(REWRITE_PROMPT, originalQuery);
            StringBuilder sb = new StringBuilder();

            chatService.streamChat(modelId, 
                List.of(Map.of("role", "user", "content", prompt)), 
                sb::append);

            String result = sb.toString().trim();
            if (!result.isEmpty()) {
                String[] lines = result.split("\n");
                for (String line : lines) {
                    String trimmed = line.trim();
                    // 去除可能的编号前缀
                    trimmed = trimmed.replaceAll("^\\d+[.、)）:：]\\s*", "");
                    if (!trimmed.isEmpty() && !trimmed.equals(originalQuery)) {
                        queries.add(trimmed);
                    }
                }
            }
            log.info("Query改写: 原始='{}', 改写后{}个查询", originalQuery, queries.size());
        } catch (Exception e) {
            log.warn("Query改写失败，使用原始查询: {}", e.getMessage());
        }

        return queries;
    }

    /**
     * 计算动态 topK
     * 
     * 根据查询特征动态调节 topK：
     * - 短查询（<10字）：倾向更多召回
     * - 长查询（>50字）：倾向精确匹配，减少召回
     * - 包含问号：问答型查询，适中召回
     * 
     * @param query 查询文本
     * @param baseTopK 基础 topK
     * @return 动态调整后的 topK
     */
    public int computeDynamicTopK(String query, int baseTopK) {
        if (query == null || query.isEmpty()) return baseTopK;

        int len = query.trim().length();
        double factor;

        if (len < 10) {
            // 短查询：扩大召回
            factor = 1.5;
        } else if (len < 30) {
            // 中等查询：标准召回
            factor = 1.0;
        } else if (len < 80) {
            // 长查询：适度减少
            factor = 0.8;
        } else {
            // 超长查询：精确匹配
            factor = 0.6;
        }

        // 包含问号的问答型查询，微调增加
        if (query.contains("?") || query.contains("？")) {
            factor += 0.2;
        }

        int dynamicTopK = Math.max(3, (int) Math.round(baseTopK * factor));
        log.debug("动态topK: query长度={}, baseTopK={}, factor={}, dynamicTopK={}", len, baseTopK, factor, dynamicTopK);
        return dynamicTopK;
    }
}
