package com.novacloudedu.backend.infrastructure.ai;

import com.alibaba.dashscope.embeddings.TextEmbedding;
import com.alibaba.dashscope.embeddings.TextEmbeddingParam;
import com.alibaba.dashscope.embeddings.TextEmbeddingResult;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 基于阿里云灵积平台的向量嵌入服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DashScopeEmbeddingService implements VectorEmbeddingService {

    private final TextEmbedding textEmbedding;

    @Value("${ai.dashscope.api-key}")
    private String apiKey;

    @Value("${ai.dashscope.embedding.model-name}")
    private String modelName;

    @Value("${ai.dashscope.embedding.dimension:1536}")
    private int dimension;

    @Value("${ai.dashscope.embedding.text-type:document}")
    private String textType;

    @Override
    public ChapterVector embedText(String text) {
        return doEmbed(text, TextEmbeddingParam.TextType.DOCUMENT);
    }

    @Override
    public ChapterVector embedQuery(String query) {
        return doEmbed(query, TextEmbeddingParam.TextType.QUERY);
    }

    /**
     * 通用向量化方法，区分 text_type（query 用于检索，document 用于入库）
     */
    private ChapterVector doEmbed(String text, TextEmbeddingParam.TextType type) {
        if (text == null || text.trim().isEmpty()) {
            throw new IllegalArgumentException("文本不能为空");
        }

        log.info("向量化文本，长度: {}, textType: {}", text.length(), type);
        try {
            TextEmbeddingParam param = TextEmbeddingParam.builder()
                    .apiKey(apiKey)
                    .model(modelName)
                    .textType(type)
                    .texts(Arrays.asList(text))
                    .build();

            TextEmbeddingResult result = textEmbedding.call(param);
            List<Double> embedding = result.getOutput().getEmbeddings().get(0).getEmbedding();
            
            // 转换为 float[]
            float[] vector = new float[embedding.size()];
            for (int i = 0; i < embedding.size(); i++) {
                vector[i] = embedding.get(i).floatValue();
            }
            
            ChapterVector chapterVector = ChapterVector.of(vector, modelName);
            log.info("向量化完成，维度: {}, textType: {}", chapterVector.getDimension(), type);
            return chapterVector;
        } catch (Exception e) {
            log.error("向量化失败, textType: {}", type, e);
            throw new RuntimeException("向量化失败: " + e.getMessage(), e);
        }
    }

    private static final int MAX_BATCH_SIZE = 25;

    @Override
    public ChapterVector[] embedTexts(String[] texts) {
        if (texts == null || texts.length == 0) {
            throw new IllegalArgumentException("文本列表不能为空");
        }

        log.info("批量向量化文本，数量: {}", texts.length);
        try {
            List<ChapterVector> allVectors = new ArrayList<>();

            for (int start = 0; start < texts.length; start += MAX_BATCH_SIZE) {
                int end = Math.min(start + MAX_BATCH_SIZE, texts.length);
                List<String> batch = Arrays.asList(Arrays.copyOfRange(texts, start, end));
                log.info("处理批次 {}-{}/{}", start + 1, end, texts.length);

                TextEmbeddingParam param = TextEmbeddingParam.builder()
                        .apiKey(apiKey)
                        .model(modelName)
                        .textType(TextEmbeddingParam.TextType.DOCUMENT)
                        .texts(batch)
                        .build();

                TextEmbeddingResult result = textEmbedding.call(param);
                var embeddings = result.getOutput().getEmbeddings();

                for (int i = 0; i < embeddings.size(); i++) {
                    List<Double> embedding = embeddings.get(i).getEmbedding();
                    float[] vector = new float[embedding.size()];
                    for (int j = 0; j < embedding.size(); j++) {
                        vector[j] = embedding.get(j).floatValue();
                    }
                    allVectors.add(ChapterVector.of(vector, modelName));
                }
            }

            log.info("批量向量化完成，数量: {}", allVectors.size());
            return allVectors.toArray(new ChapterVector[0]);
        } catch (Exception e) {
            log.error("批量向量化失败", e);
            throw new RuntimeException("批量向量化失败: " + e.getMessage(), e);
        }
    }

    @Override
    public int getDimension() {
        return dimension;
    }

    @Override
    public String getModelName() {
        return modelName;
    }
}
