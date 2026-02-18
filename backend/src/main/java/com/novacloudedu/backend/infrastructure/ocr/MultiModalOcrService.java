package com.novacloudedu.backend.infrastructure.ocr;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * 多模态大模型 OCR 服务（通道B：手写+公式+结构化识别）
 * <p>
 * 使用视觉模型（如 qwen-vl-max）对作业图片进行结构化理解，
 * 识别题号、题型、题干、学生作答内容，输出结构化 JSON。
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class MultiModalOcrService {

    private final LangchainChatService langchainChatService;
    private final ObjectMapper objectMapper;

    private static final String SYSTEM_PROMPT = """
            你是一个专业的作业识别助手。请仔细观察图片中的作业内容，识别出每道题目的信息。
            
            请严格按以下 JSON 数组格式输出，不要添加任何额外文字或 markdown 标记：
            [
              {
                "index": 1,
                "questionContent": "题干内容（完整抄录，数学公式用文字描述）",
                "studentAnswer": "学生的作答内容（完整抄录，包括计算过程）",
                "questionType": "SINGLE_CHOICE / MULTI_CHOICE / FILL_BLANK / TRUE_FALSE / SHORT_ANSWER / CALCULATION / ESSAY",
                "maxScore": 该题分值（如果能从图片中看到，否则为0）
              }
            ]
            
            识别规则：
            1. 按题号顺序排列，题号从1开始
            2. questionContent 必须完整抄录题干，不要省略
            3. studentAnswer 必须完整抄录学生的手写/打印作答内容
            4. 如果学生未作答某题，studentAnswer 填空字符串 ""
            5. 数学公式尽量用文字+符号表达，如 "x^2 + 2x + 1 = 0"
            6. 如果图片模糊无法识别，在对应字段标注 "[无法识别]"
            7. questionType 根据题目格式推断：有选项的是选择题，有横线的是填空题，需要计算的是计算题等
            """;

    /**
     * 使用多模态视觉模型识别单张作业图片
     *
     * @param imageUrl 图片 OSS URL
     * @return 结构化题目列表
     */
    public List<OcrService.QuestionBlock> recognizeImage(String imageUrl) {
        try {
            log.info("多模态OCR识别开始: {}", imageUrl);

            String response = langchainChatService.chatWithImage(
                    null,
                    SYSTEM_PROMPT,
                    "请识别这张作业图片中的所有题目和学生作答内容。",
                    imageUrl
            );

            return parseResponse(response);
        } catch (Exception e) {
            log.error("多模态OCR识别失败: url={}, error={}", imageUrl, e.getMessage(), e);
            return List.of();
        }
    }

    /**
     * 识别多张作业图片
     */
    public List<OcrService.QuestionBlock> recognizeImages(List<String> imageUrls) {
        List<OcrService.QuestionBlock> allBlocks = new ArrayList<>();
        int globalIndex = 1;

        for (String imageUrl : imageUrls) {
            List<OcrService.QuestionBlock> blocks = recognizeImage(imageUrl);
            // 重新编排全局题号
            for (OcrService.QuestionBlock block : blocks) {
                allBlocks.add(new OcrService.QuestionBlock(
                        globalIndex++,
                        block.questionContent(),
                        block.studentAnswer(),
                        block.questionType(),
                        block.metadata()
                ));
            }
        }

        return allBlocks;
    }

    private List<OcrService.QuestionBlock> parseResponse(String response) {
        String json = extractJson(response);
        if (json == null) {
            log.warn("多模态OCR: 无法从响应中提取JSON");
            return List.of();
        }

        try {
            List<Map<String, Object>> items = objectMapper.readValue(json, new TypeReference<>() {});
            List<OcrService.QuestionBlock> blocks = new ArrayList<>();

            for (Map<String, Object> item : items) {
                int index = item.get("index") instanceof Number n ? n.intValue() : blocks.size() + 1;
                String content = getStr(item, "questionContent");
                String answer = getStr(item, "studentAnswer");
                String type = getStr(item, "questionType");

                Map<String, Object> metadata = new HashMap<>();
                Object maxScore = item.get("maxScore");
                if (maxScore instanceof Number n && n.intValue() > 0) {
                    metadata.put("maxScore", n.intValue());
                }

                blocks.add(new OcrService.QuestionBlock(index, content, answer, type, metadata));
            }

            log.info("多模态OCR识别完成: 识别到 {} 道题", blocks.size());
            return blocks;
        } catch (Exception e) {
            log.error("多模态OCR JSON解析失败: {}", e.getMessage());
            return List.of();
        }
    }

    private String extractJson(String text) {
        if (text == null || text.isBlank()) return null;
        String trimmed = text.trim();
        if (trimmed.startsWith("[")) return trimmed;

        // 从 markdown 代码块中提取
        int start = text.indexOf("```json");
        if (start >= 0) {
            start = text.indexOf('\n', start) + 1;
        } else {
            start = text.indexOf("```");
            if (start >= 0) {
                start = text.indexOf('\n', start) + 1;
            }
        }
        if (start > 0) {
            int end = text.indexOf("```", start);
            if (end > start) return text.substring(start, end).trim();
        }

        // 查找 [ ... ]
        int bracketStart = text.indexOf('[');
        int bracketEnd = text.lastIndexOf(']');
        if (bracketStart >= 0 && bracketEnd > bracketStart) {
            return text.substring(bracketStart, bracketEnd + 1);
        }
        return null;
    }

    private String getStr(Map<String, Object> map, String key) {
        Object val = map.get(key);
        return val != null ? val.toString().trim() : "";
    }
}
