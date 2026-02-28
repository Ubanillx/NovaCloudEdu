package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeDocumentId;

import java.util.List;

/**
 * 知识库分块仓储接口
 */
public interface KnowledgeChunkRepository {

    /**
     * 保存分块
     */
    void saveChunk(KnowledgeBaseId knowledgeBaseId, KnowledgeDocumentId documentId,
                   String content, int chunkIndex, float[] embedding, String metadata);

    /**
     * 批量保存分块
     */
    void saveChunks(KnowledgeBaseId knowledgeBaseId, KnowledgeDocumentId documentId,
                    List<String> contents, List<float[]> embeddings, String metadata);

    /**
     * 相似度搜索
     */
    List<ChunkSearchResult> searchSimilar(KnowledgeBaseId knowledgeBaseId, float[] queryEmbedding, int topK);

    /**
     * 在多个知识库中搜索
     */
    List<ChunkSearchResult> searchSimilarInMultiple(List<Long> knowledgeBaseIds, float[] queryEmbedding, int topK);

    /**
     * 全文检索（BM25）在多个知识库中搜索
     */
    List<ChunkSearchResult> fullTextSearchInMultiple(List<Long> knowledgeBaseIds, String query, int topK);

    /**
     * 根据文档ID删除分块
     */
    void deleteByDocumentId(KnowledgeDocumentId documentId);

    /**
     * 根据知识库ID删除所有分块
     */
    void deleteByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId);

    /**
     * 根据文档ID查询分块列表（分页）
     */
    List<ChunkDetail> findByDocumentId(KnowledgeDocumentId documentId, int page, int size);

    /**
     * 统计文档的分块数量
     */
    long countByDocumentId(KnowledgeDocumentId documentId);

    /**
     * 统计知识库的分块数量
     */
    long countByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId);

    /**
     * 分块搜索结果
     */
    record ChunkSearchResult(
            Long chunkId,
            Long knowledgeBaseId,
            Long documentId,
            String content,
            double similarity,
            String metadata
    ) {}

    /**
     * 分块详情（不含向量数据）
     */
    record ChunkDetail(
            Long id,
            Long knowledgeBaseId,
            Long documentId,
            String content,
            Integer chunkIndex,
            Long parentChunkId,
            Boolean isParentChunk,
            String sectionTitle,
            String metadata,
            java.time.LocalDateTime createTime
    ) {}
}
