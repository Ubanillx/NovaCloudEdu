package com.novacloudedu.backend.infrastructure.ai.agent;

import dev.langchain4j.agent.tool.P;
import dev.langchain4j.agent.tool.Tool;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 内容组织工具 — 供 Agent 自主调用
 *
 * 对已收集的原始素材进行结构化整理，提取关键信息，
 * 转化为适合PPT展示的精炼内容。
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ContentResearchTool {

    private final LangchainChatService langchainChatService;

    @Tool("将原始研究素材整理为适合PPT展示的结构化内容。提取关键数据、核心观点和要点列表。")
    public String organizeContent(
            @P("原始研究素材文本") String rawMaterial,
            @P("目标幻灯片的主题/标题") String slideTitle,
            @P("内容类型：overview/detail/data/comparison/conclusion") String contentType) {

        log.info("Agent ContentResearchTool 调用: slideTitle={}, contentType={}", slideTitle, contentType);

        String systemPrompt = """
                你是一个PPT内容组织专家。将原始研究素材精炼为适合PPT展示的结构化内容。
                
                要求：
                1. 提取最有价值的信息，删除冗余
                2. 每个要点不超过20个字
                3. 使用数据支撑论点
                4. 内容层次分明，逻辑清晰
                5. 适合PPT幻灯片的简洁风格
                
                输出格式：
                - 主标题：（简短有力）
                - 副标题：（补充说明，可选）
                - 要点列表：（3-5个精炼要点）
                - 关键数据：（如有，列出2-3个关键数字）
                - 配图建议：（用英文描述适合的配图）
                """;

        String userMessage = String.format(
                "幻灯片标题：%s\n内容类型：%s\n\n原始素材：\n%s",
                slideTitle, contentType, rawMaterial);

        try {
            return langchainChatService.chat(null, systemPrompt, userMessage);
        } catch (Exception e) {
            log.error("内容组织失败: slideTitle={}", slideTitle, e);
            return "内容组织失败: " + e.getMessage();
        }
    }

    @Tool("评估一段PPT内容的质量，给出改进建议。用于Agent自我反思和内容优化。")
    public String evaluateContent(
            @P("待评估的PPT内容") String content,
            @P("评估维度：accuracy/clarity/conciseness/visual_appeal") String dimension) {

        log.info("Agent evaluateContent 调用: dimension={}", dimension);

        String systemPrompt = """
                你是一个PPT内容质量评审专家。对给定内容进行评估并提出改进建议。
                
                评分维度说明：
                - accuracy: 内容准确性和专业性
                - clarity: 表达清晰度和逻辑性
                - conciseness: 简洁度，是否适合PPT展示
                - visual_appeal: 视觉呈现建议（配图、图表、布局）
                
                输出格式：
                - 评分（1-10）：
                - 优点：
                - 改进建议：
                - 修改后的内容（如需要）：
                """;

        String userMessage = String.format("评估维度：%s\n\n待评估内容：\n%s", dimension, content);

        try {
            return langchainChatService.chat(null, systemPrompt, userMessage);
        } catch (Exception e) {
            log.error("内容评估失败", e);
            return "评估失败: " + e.getMessage();
        }
    }
}
