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

    private static final int DB_BATCH_SIZE = 1000;

    @Override
    public void saveChunks(KnowledgeBaseId knowledgeBaseId, KnowledgeDocumentId documentId,
                           List<String> contents, List<float[]> embeddings, String metadata) {
        List<Map<String, Object>> allRows = new ArrayList<>();
        for (int i = 0; i < contents.size(); i++) {
            Map<String, Object> row = new java.util.HashMap<>();
            row.put("knowledgeBaseId", knowledgeBaseId.value());
            row.put("documentId", documentId.value());
            row.put("content", contents.get(i));
            row.put("chunkIndex", i);
            row.put("embedding", floatArrayToString(embeddings.get(i)));
            row.put("metadata", metadata);
            allRows.add(row);
        }

        for (int start = 0; start < allRows.size(); start += DB_BATCH_SIZE) {
            int end = Math.min(start + DB_BATCH_SIZE, allRows.size());
            List<Map<String, Object>> batch = allRows.subList(start, end);
            log.info("批量插入分块 {}-{}/{}", start + 1, end, allRows.size());
            mapper.batchInsertChunks(batch);
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
    public List<ChunkDetail> findByDocumentId(KnowledgeDocumentId documentId, int page, int size) {
        int offset = page * size;
        List<Map<String, Object>> results = mapper.findByDocumentId(documentId.value(), offset, size);
        return results.stream()
                .map(this::mapToChunkDetail)
                .collect(Collectors.toList());
    }

    @Override
    public long countByDocumentId(KnowledgeDocumentId documentId) {
        return mapper.countByDocumentId(documentId.value());
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

    private ChunkDetail mapToChunkDetail(Map<String, Object> map) {
        return new ChunkDetail(
                ((Number) map.get("id")).longValue(),
                ((Number) map.get("knowledge_base_id")).longValue(),
                ((Number) map.get("document_id")).longValue(),
                (String) map.get("content"),
                map.get("chunk_index") != null ? ((Number) map.get("chunk_index")).intValue() : 0,
                convertMetadataToString(map.get("metadata")),
                map.get("create_time") != null ? ((java.sql.Timestamp) map.get("create_time")).toLocalDateTime() : null
        );
    }

    private ChunkSearchResult mapToResult(Map<String, Object> map) {
        return new ChunkSearchResult(
                ((Number) map.get("id")).longValue(),
                ((Number) map.get("knowledge_base_id")).longValue(),
                ((Number) map.get("document_id")).longValue(),
                (String) map.get("content"),
                ((Number) map.get("similarity")).doubleValue(),
                convertMetadataToString(map.get("metadata"))
        );
    }

    /**
     * 将 metadata 转为 String（PostgreSQL jsonb 类型被 MyBatis 解析为 LinkedHashMap）
     */
    private String convertMetadataToString(Object metadata) {
        if (metadata == null) {
            return null;
        }
        if (metadata instanceof String) {
            return (String) metadata;
        }
        // jsonb 被 MyBatis 解析为 Map/List，需要序列化为 JSON 字符串
        try {
            return new com.google.gson.Gson().toJson(metadata);
        } catch (Exception e) {
            return metadata.toString();
        }
    }
}
