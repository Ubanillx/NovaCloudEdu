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

    @Value("${ai.dashscope.embedding.model-name}")
    private String modelName;

    @Value("${ai.dashscope.embedding.dimension:1536}")
    private int dimension;

    @Value("${ai.dashscope.embedding.text-type:document}")
    private String textType;

    @Override
    public ChapterVector embedText(String text) {
        if (text == null || text.trim().isEmpty()) {
            throw new IllegalArgumentException("文本不能为空");
        }

        log.info("向量化文本，长度: {}", text.length());
        try {
            TextEmbeddingParam param = TextEmbeddingParam.builder()
                    .model(modelName)
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
            log.info("向量化完成，维度: {}", chapterVector.getDimension());
            return chapterVector;
        } catch (Exception e) {
            log.error("向量化失败", e);
            throw new RuntimeException("向量化失败: " + e.getMessage(), e);
        }
    }

    @Override
    public ChapterVector[] embedTexts(String[] texts) {
        if (texts == null || texts.length == 0) {
            throw new IllegalArgumentException("文本列表不能为空");
        }

        log.info("批量向量化文本，数量: {}", texts.length);
        try {
            TextEmbeddingParam param = TextEmbeddingParam.builder()
                    .model(modelName)
                    .texts(Arrays.asList(texts))
                    .build();

            TextEmbeddingResult result = textEmbedding.call(param);
            var embeddings = result.getOutput().getEmbeddings();
            
            ChapterVector[] vectors = new ChapterVector[embeddings.size()];
            for (int i = 0; i < embeddings.size(); i++) {
                List<Double> embedding = embeddings.get(i).getEmbedding();
                float[] vector = new float[embedding.size()];
                for (int j = 0; j < embedding.size(); j++) {
                    vector[j] = embedding.get(j).floatValue();
                }
                vectors[i] = ChapterVector.of(vector, modelName);
            }
            
            log.info("批量向量化完成，数量: {}", vectors.length);
            return vectors;
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
