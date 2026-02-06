package com.novacloudedu.backend.infrastructure.ai;

import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.dailylearning.service.ArticleAiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 文章 AI 处理服务实现
 * 使用 DashScope LLM 进行文章内容格式化和摘要生成
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ArticleAiServiceImpl implements ArticleAiService {

    private final LlmService llmService;

    private static final String MARKDOWN_FORMAT_PROMPT = """
            你是一个专业的文章排版助手。请将以下文章内容重新排版为清晰易读的 Markdown 格式。
            
            要求：
            1. 保持原文内容不变，不要添加或删除任何实质性内容
            2. 合理使用标题层级（##、###）来组织内容结构
            3. 使用段落分隔，每段之间空一行
            4. 重要内容可以使用 **加粗** 或 *斜体* 强调
            5. 如果有列表内容，使用 - 或 1. 格式化
            6. 如果有引用内容，使用 > 引用格式
            7. 不要使用代码块，除非原文确实包含代码
            8. 输出纯 Markdown 文本，不要包含任何解释说明
            
            文章标题：%s
            
            原文内容：
            %s
            """;

    private static final String SUMMARY_PROMPT = """
            你是一个专业的文章摘要助手。请为以下文章生成一段简洁精炼的摘要。
            
            要求：
            1. 摘要长度控制在 %d 字以内
            2. 准确概括文章的核心内容和主旨
            3. 使用流畅的中文表达
            4. 不要使用"本文"、"这篇文章"等开头
            5. 直接输出摘要内容，不要包含任何额外说明
            
            文章标题：%s
            
            文章内容：
            %s
            """;

    private static final String COMBINED_PROMPT = """
            你是一个专业的文章处理助手。请完成以下两个任务：
            
            任务1：将文章内容重新排版为清晰易读的 Markdown 格式
            - 保持原文内容不变
            - 合理使用标题层级、段落、列表等 Markdown 元素
            - 重要内容可适当强调
            
            任务2：生成一段 150 字以内的文章摘要
            - 准确概括核心内容和主旨
            - 使用流畅的中文表达
            
            请严格按照以下 JSON 格式输出，不要包含任何其他内容：
            {
              "formattedContent": "Markdown 格式化后的完整文章内容",
              "summary": "文章摘要"
            }
            
            文章标题：%s
            
            原文内容：
            %s
            """;

    @Override
    public AiProcessResult processArticle(String rawContent, String title) {
        if (rawContent == null || rawContent.isBlank()) {
            log.warn("文章内容为空，跳过 AI 处理");
            return new AiProcessResult(rawContent, "");
        }

        log.info("开始 AI 处理文章: {}", title);
        try {
            // 如果内容太长，截断处理
            String contentToProcess = truncateForLlm(rawContent, 6000);
            String prompt = String.format(COMBINED_PROMPT, title, contentToProcess);
            
            String response = llmService.chat(prompt);
            log.debug("AI 响应: {}", response);
            
            // 解析 JSON 响应
            return parseAiResponse(response, rawContent);
        } catch (Exception e) {
            log.error("AI 处理文章失败: {}", title, e);
            // 失败时返回原内容和空摘要
            return new AiProcessResult(rawContent, generateFallbackSummary(rawContent));
        }
    }

    @Override
    public String formatToMarkdown(String rawContent) {
        if (rawContent == null || rawContent.isBlank()) {
            return rawContent;
        }

        log.info("开始 AI 格式化文章内容");
        try {
            String contentToProcess = truncateForLlm(rawContent, 6000);
            String prompt = String.format(MARKDOWN_FORMAT_PROMPT, "", contentToProcess);
            
            String response = llmService.chat(prompt);
            return response.trim();
        } catch (Exception e) {
            log.error("AI 格式化失败", e);
            return rawContent;
        }
    }

    @Override
    public String generateSummary(String content, String title, int maxLength) {
        if (content == null || content.isBlank()) {
            return "";
        }

        log.info("开始 AI 生成摘要: {}", title);
        try {
            String contentToProcess = truncateForLlm(content, 4000);
            String prompt = String.format(SUMMARY_PROMPT, maxLength, title, contentToProcess);
            
            String response = llmService.chat(prompt);
            String summary = response.trim();
            
            // 确保不超过最大长度
            if (summary.length() > maxLength) {
                summary = summary.substring(0, maxLength - 3) + "...";
            }
            return summary;
        } catch (Exception e) {
            log.error("AI 生成摘要失败", e);
            return generateFallbackSummary(content);
        }
    }

    /**
     * 解析 AI JSON 响应
     */
    private AiProcessResult parseAiResponse(String response, String originalContent) {
        try {
            // 提取 JSON 部分
            String jsonStr = response.trim();
            if (jsonStr.startsWith("```json")) {
                jsonStr = jsonStr.substring(7);
            }
            if (jsonStr.startsWith("```")) {
                jsonStr = jsonStr.substring(3);
            }
            if (jsonStr.endsWith("```")) {
                jsonStr = jsonStr.substring(0, jsonStr.length() - 3);
            }
            jsonStr = jsonStr.trim();
            
            // 简单的 JSON 解析
            String formattedContent = extractJsonField(jsonStr, "formattedContent");
            String summary = extractJsonField(jsonStr, "summary");
            
            if (formattedContent == null || formattedContent.isBlank()) {
                formattedContent = originalContent;
            }
            if (summary == null) {
                summary = "";
            }
            
            return new AiProcessResult(formattedContent, summary);
        } catch (Exception e) {
            log.warn("解析 AI 响应失败，使用原内容", e);
            return new AiProcessResult(originalContent, generateFallbackSummary(originalContent));
        }
    }

    /**
     * 从 JSON 字符串中提取字段值
     */
    private String extractJsonField(String json, String fieldName) {
        try {
            String searchKey = "\"" + fieldName + "\"";
            int keyIndex = json.indexOf(searchKey);
            if (keyIndex == -1) return null;
            
            int colonIndex = json.indexOf(":", keyIndex);
            if (colonIndex == -1) return null;
            
            int valueStart = json.indexOf("\"", colonIndex);
            if (valueStart == -1) return null;
            valueStart++;
            
            // 找到结束引号，处理转义
            int valueEnd = valueStart;
            while (valueEnd < json.length()) {
                valueEnd = json.indexOf("\"", valueEnd);
                if (valueEnd == -1) break;
                // 检查是否是转义的引号
                int backslashCount = 0;
                int checkPos = valueEnd - 1;
                while (checkPos >= valueStart && json.charAt(checkPos) == '\\') {
                    backslashCount++;
                    checkPos--;
                }
                if (backslashCount % 2 == 0) {
                    break;
                }
                valueEnd++;
            }
            
            if (valueEnd == -1) return null;
            
            String value = json.substring(valueStart, valueEnd);
            // 处理转义字符
            value = value.replace("\\n", "\n")
                        .replace("\\\"", "\"")
                        .replace("\\\\", "\\");
            return value;
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 截断内容以适应 LLM 上下文限制
     */
    private String truncateForLlm(String content, int maxLength) {
        if (content == null) return "";
        if (content.length() <= maxLength) return content;
        return content.substring(0, maxLength) + "\n\n[内容已截断...]";
    }

    /**
     * 生成备用摘要（当 AI 失败时）
     */
    private String generateFallbackSummary(String content) {
        if (content == null || content.isBlank()) {
            return "";
        }
        // 取前 150 个字符作为简单摘要
        String summary = content.replaceAll("\\s+", " ").trim();
        if (summary.length() > 150) {
            summary = summary.substring(0, 147) + "...";
        }
        return summary;
    }
}
