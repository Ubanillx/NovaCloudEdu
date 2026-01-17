package com.novacloudedu.backend.domain.book.valueobject;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Arrays;

/**
 * 章节向量值对象
 * 用于 RAG (Retrieval-Augmented Generation) 对话
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ChapterVector {

    private float[] embedding;
    private int dimension;
    private String model;

    public static ChapterVector of(float[] embedding, String model) {
        if (embedding == null || embedding.length == 0) {
            throw new IllegalArgumentException("向量不能为空");
        }
        if (model == null || model.trim().isEmpty()) {
            throw new IllegalArgumentException("模型名称不能为空");
        }

        ChapterVector vector = new ChapterVector();
        vector.embedding = Arrays.copyOf(embedding, embedding.length);
        vector.dimension = embedding.length;
        vector.model = model;
        return vector;
    }

    /**
     * 计算与另一个向量的余弦相似度
     */
    public double cosineSimilarity(ChapterVector other) {
        if (other == null || this.dimension != other.dimension) {
            throw new IllegalArgumentException("向量维度不匹配");
        }

        double dotProduct = 0.0;
        double normA = 0.0;
        double normB = 0.0;

        for (int i = 0; i < dimension; i++) {
            dotProduct += this.embedding[i] * other.embedding[i];
            normA += this.embedding[i] * this.embedding[i];
            normB += other.embedding[i] * other.embedding[i];
        }

        if (normA == 0.0 || normB == 0.0) {
            return 0.0;
        }

        return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
    }

    /**
     * 转换为数组用于存储
     */
    public float[] toArray() {
        return Arrays.copyOf(embedding, embedding.length);
    }

    /**
     * 转换为 PostgreSQL pgvector 格式的字符串
     */
    public String toPgVector() {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < embedding.length; i++) {
            if (i > 0) sb.append(",");
            sb.append(embedding[i]);
        }
        sb.append("]");
        return sb.toString();
    }
}
