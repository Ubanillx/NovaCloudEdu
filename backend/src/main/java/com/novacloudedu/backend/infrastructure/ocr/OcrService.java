package com.novacloudedu.backend.infrastructure.ocr;

import java.util.List;
import java.util.Map;

/**
 * OCR 识别服务接口
 */
public interface OcrService {

    /**
     * 识别作业图片，返回结构化数据
     *
     * @param imageUrls 作业图片 OSS URL 列表
     * @return OCR 识别结果
     */
    OcrResult recognize(List<String> imageUrls);

    /**
     * OCR 识别结果
     */
    record OcrResult(
            String rawText,
            List<QuestionBlock> questions,
            double confidence
    ) {}

    /**
     * 结构化题目块
     */
    record QuestionBlock(
            int index,
            String questionContent,
            String studentAnswer,
            String questionType,
            Map<String, Object> metadata
    ) {}
}
