package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.ai.repository.KnowledgeChunkRepository;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeDocumentId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.KnowledgeChunkMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 知识库分块仓储实现
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class KnowledgeChunkRepositoryImpl implements KnowledgeChunkRepository {

    private final KnowledgeChunkMapper mapper;

    @Override
    public void saveChunk(KnowledgeBaseId knowledgeBaseId, KnowledgeDocumentId documentId,
                          String content, int chunkIndex, float[] embedding, String metadata) {
        String embeddingStr = floatArrayToString(embedding);
        mapper.insertChunk(knowledgeBaseId.value(), documentId.value(), content, chunkIndex, embeddingStr, metadata);
    }

    @Override
    public void saveChunks(KnowledgeBaseId knowledgeBaseId, KnowledgeDocumentId documentId,
                           List<String> contents, List<float[]> embeddings, String metadata) {
        for (int i = 0; i < contents.size(); i++) {
            saveChunk(knowledgeBaseId, documentId, contents.get(i), i, embeddings.get(i), metadata);
        }
    }

    @Override
    public List<ChunkSearchResult> searchSimilar(KnowledgeBaseId knowledgeBaseId, float[] queryEmbedding, int topK) {
        String embeddingStr = floatArrayToString(queryEmbedding);
        List<Map<String, Object>> results = mapper.searchSimilar(knowledgeBaseId.value(), embeddingStr, topK);
        return results.stream()
                .map(this::mapToResult)
                .collect(Collectors.toList());
    }

    @Override
    public List<ChunkSearchResult> searchSimilarInMultiple(List<Long> knowledgeBaseIds, float[] queryEmbedding, int topK) {
        if (knowledgeBaseIds == null || knowledgeBaseIds.isEmpty()) {
            return new ArrayList<>();
        }
        String embeddingStr = floatArrayToString(queryEmbedding);
        List<Map<String, Object>> results = mapper.searchSimilarInMultiple(knowledgeBaseIds, embeddingStr, topK);
        return results.stream()
                .map(this::mapToResult)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteByDocumentId(KnowledgeDocumentId documentId) {
        mapper.deleteByDocumentId(documentId.value());
    }

    @Override
    public void deleteByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId) {
        mapper.deleteByKnowledgeBaseId(knowledgeBaseId.value());
    }

    @Override
    public long countByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId) {
        return mapper.countByKnowledgeBaseId(knowledgeBaseId.value());
    }

    private String floatArrayToString(float[] array) {
        if (array == null) {
            return null;
        }
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < array.length; i++) {
            if (i > 0) {
                sb.append(",");
            }
            sb.append(array[i]);
        }
        sb.append("]");
        return sb.toString();
    }

    private ChunkSearchResult mapToResult(Map<String, Object> map) {
        return new ChunkSearchResult(
                ((Number) map.get("id")).longValue(),
                ((Number) map.get("knowledge_base_id")).longValue(),
                ((Number) map.get("document_id")).longValue(),
                (String) map.get("content"),
                ((Number) map.get("similarity")).doubleValue(),
                (String) map.get("metadata")
        );
    }
}
