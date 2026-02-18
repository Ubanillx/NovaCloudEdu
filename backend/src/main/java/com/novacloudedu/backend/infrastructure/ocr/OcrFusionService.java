package com.novacloudedu.backend.infrastructure.ocr;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * OCR 双通道融合服务
 * <p>
 * 融合百度OCR（通道A：打印体识别）和多模态大模型（通道B：结构化识别）的结果。
 * <ul>
 *   <li>百度OCR — 基础文字识别，提供原始文本、置信度和坐标</li>
 *   <li>多模态模型 — 结构化理解，识别题号、题型、学生答案</li>
 *   <li>融合策略：以多模态模型的结构化输出为主，百度OCR 提供原始文本和布局信息辅助</li>
 * </ul>
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class OcrFusionService implements OcrService {

    private final BaiduOcrClient baiduOcrClient;
    private final MultiModalOcrService multiModalOcrService;

    @Override
    public OcrResult recognize(List<String> imageUrls) {
        if (imageUrls == null || imageUrls.isEmpty()) {
            return new OcrResult("", List.of(), 0.0);
        }

        log.info("OCR融合识别开始: {} 张图片", imageUrls.size());

        // 通道A-1: 百度OCR 识别原始文本
        StringBuilder rawTextBuilder = new StringBuilder();
        double ocrConfidence = 0.0;
        int ocrBlockCount = 0;
        try {
            for (String url : imageUrls) {
                List<BaiduOcrClient.TextBlock> textBlocks = baiduOcrClient.recognizeFromUrl(url);
                for (BaiduOcrClient.TextBlock block : textBlocks) {
                    rawTextBuilder.append(block.text()).append("\n");
                    ocrConfidence += block.confidence();
                    ocrBlockCount++;
                }
                rawTextBuilder.append("\n---\n");
            }
        } catch (Exception e) {
            log.warn("百度OCR通道异常，继续使用多模态通道: {}", e.getMessage());
        }

        String rawText = rawTextBuilder.toString().trim();
        double avgOcrConfidence = ocrBlockCount > 0 ? ocrConfidence / ocrBlockCount : 0.0;

        // 通道B: 多模态大模型结构化识别
        List<QuestionBlock> questions;
        try {
            questions = multiModalOcrService.recognizeImages(imageUrls);
        } catch (Exception e) {
            log.error("多模态OCR通道异常: {}", e.getMessage(), e);
            questions = List.of();
        }

        // 融合：以多模态结果为主体结构，百度OCR 提供原始文本参考
        double overallConfidence;
        if (!questions.isEmpty() && avgOcrConfidence > 0) {
            overallConfidence = avgOcrConfidence * 0.3 + 0.7 * 0.85;
        } else if (!questions.isEmpty()) {
            overallConfidence = 0.75;
        } else if (!rawText.isEmpty()) {
            overallConfidence = avgOcrConfidence * 0.5;
        } else {
            overallConfidence = 0.0;
        }

        log.info("OCR融合完成: 百度OCR文本块={}, 多模态识别题目={}, 综合置信度={}",
                ocrBlockCount, questions.size(), String.format("%.2f", overallConfidence));

        return new OcrResult(rawText, questions, overallConfidence);
    }
}
