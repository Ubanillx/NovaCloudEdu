package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("章节向量值对象测试")
class ChapterVectorTest {

    @Test
    @DisplayName("创建向量成功")
    void createVector_Success() {
        float[] embedding = new float[]{0.1f, 0.2f, 0.3f, 0.4f, 0.5f};
        ChapterVector vector = ChapterVector.of(embedding, "text-embedding-3-small");

        assertNotNull(vector);
        assertEquals(5, vector.getDimension());
        assertEquals("text-embedding-3-small", vector.getModel());
        assertArrayEquals(embedding, vector.toArray());
    }

    @Test
    @DisplayName("创建向量时向量为空应抛出异常")
    void createVector_NullEmbedding_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ChapterVector.of(null, "text-embedding-3-small")
        );
    }

    @Test
    @DisplayName("创建向量时向量长度为0应抛出异常")
    void createVector_EmptyEmbedding_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ChapterVector.of(new float[]{}, "text-embedding-3-small")
        );
    }

    @Test
    @DisplayName("创建向量时模型名称为空应抛出异常")
    void createVector_NullModel_ThrowsException() {
        float[] embedding = new float[]{0.1f, 0.2f, 0.3f};
        assertThrows(IllegalArgumentException.class, () ->
                ChapterVector.of(embedding, null)
        );
    }

    @Test
    @DisplayName("计算余弦相似度 - 相同向量")
    void cosineSimilarity_SameVector() {
        float[] embedding = new float[]{1.0f, 0.0f, 0.0f};
        ChapterVector vector1 = ChapterVector.of(embedding, "model");
        ChapterVector vector2 = ChapterVector.of(embedding, "model");

        double similarity = vector1.cosineSimilarity(vector2);

        assertEquals(1.0, similarity, 0.0001);
    }

    @Test
    @DisplayName("计算余弦相似度 - 正交向量")
    void cosineSimilarity_OrthogonalVectors() {
        float[] embedding1 = new float[]{1.0f, 0.0f, 0.0f};
        float[] embedding2 = new float[]{0.0f, 1.0f, 0.0f};
        
        ChapterVector vector1 = ChapterVector.of(embedding1, "model");
        ChapterVector vector2 = ChapterVector.of(embedding2, "model");

        double similarity = vector1.cosineSimilarity(vector2);

        assertEquals(0.0, similarity, 0.0001);
    }

    @Test
    @DisplayName("计算余弦相似度 - 相反向量")
    void cosineSimilarity_OppositeVectors() {
        float[] embedding1 = new float[]{1.0f, 0.0f, 0.0f};
        float[] embedding2 = new float[]{-1.0f, 0.0f, 0.0f};
        
        ChapterVector vector1 = ChapterVector.of(embedding1, "model");
        ChapterVector vector2 = ChapterVector.of(embedding2, "model");

        double similarity = vector1.cosineSimilarity(vector2);

        assertEquals(-1.0, similarity, 0.0001);
    }

    @Test
    @DisplayName("计算余弦相似度 - 维度不匹配应抛出异常")
    void cosineSimilarity_DimensionMismatch_ThrowsException() {
        float[] embedding1 = new float[]{1.0f, 0.0f, 0.0f};
        float[] embedding2 = new float[]{1.0f, 0.0f};
        
        ChapterVector vector1 = ChapterVector.of(embedding1, "model");
        ChapterVector vector2 = ChapterVector.of(embedding2, "model");

        assertThrows(IllegalArgumentException.class, () ->
                vector1.cosineSimilarity(vector2)
        );
    }

    @Test
    @DisplayName("转换为PostgreSQL pgvector格式")
    void toPgVector_Success() {
        float[] embedding = new float[]{0.1f, 0.2f, 0.3f};
        ChapterVector vector = ChapterVector.of(embedding, "model");

        String pgVector = vector.toPgVector();

        assertEquals("[0.1,0.2,0.3]", pgVector);
    }

    @Test
    @DisplayName("toArray应返回向量副本")
    void toArray_ReturnsCopy() {
        float[] embedding = new float[]{0.1f, 0.2f, 0.3f};
        ChapterVector vector = ChapterVector.of(embedding, "model");

        float[] array = vector.toArray();
        array[0] = 999.0f; // 修改副本

        // 原向量不应受影响
        assertEquals(0.1f, vector.toArray()[0], 0.0001);
    }

    @Test
    @DisplayName("计算高维向量相似度")
    void cosineSimilarity_HighDimensional() {
        // 模拟1536维向量
        float[] embedding1 = new float[1536];
        float[] embedding2 = new float[1536];
        
        for (int i = 0; i < 1536; i++) {
            embedding1[i] = (float) Math.sin(i * 0.1);
            embedding2[i] = (float) Math.sin(i * 0.1 + 0.1);
        }
        
        ChapterVector vector1 = ChapterVector.of(embedding1, "text-embedding-3-small");
        ChapterVector vector2 = ChapterVector.of(embedding2, "text-embedding-3-small");

        double similarity = vector1.cosineSimilarity(vector2);

        // 相似但不完全相同的向量
        assertTrue(similarity > 0.9 && similarity < 1.0);
    }
}
