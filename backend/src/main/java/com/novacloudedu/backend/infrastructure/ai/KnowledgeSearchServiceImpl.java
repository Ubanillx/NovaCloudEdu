package com.novacloudedu.backend.infrastructure.ai;

import com.novacloudedu.backend.domain.ai.repository.KnowledgeChunkRepository;
import com.novacloudedu.backend.domain.ai.service.RerankService;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import com.novacloudedu.backend.domain.knowledge.service.KnowledgeSearchService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * 知识库搜索服务实现
 * 
 * 标准 RAG 检索流程：
 * 1. 向量化查询文本（Embedding）
 * 2. 向量相似度召回候选文档（Recall）
 * 3. Rerank 模型精排（Rerank）
 * 4. 返回 top-K 结果
 * 
 * 供 AI Assistant、Workflow 等上层服务统一调用
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgeSearchServiceImpl implements KnowledgeSearchService {

    private final VectorEmbeddingService embeddingService;
    private final KnowledgeChunkRepository chunkRepository;
    private final RerankService rerankService;

    @Value("${ai.dashscope.rerank.enabled:true}")
    private boolean rerankEnabled;

    @Override
    public SearchResult search(SearchRequest request) {
        long startTime = System.currentTimeMillis();

        List<Long> knowledgeBaseIds = request.getKnowledgeBaseIds();
        String query = request.getQuery();
        int topK = request.getTopK() != null ? request.getTopK() : 5;
        double threshold = request.getSimilarityThreshold() != null ? request.getSimilarityThreshold() : 0.5;
        boolean useRerank = rerankEnabled && !"vector_only".equals(request.getRetrievalMode());

        if (knowledgeBaseIds == null || knowledgeBaseIds.isEmpty() || query == null || query.trim().isEmpty()) {
            log.warn("知识库搜索参数无效: knowledgeBaseIds={}, query为空={}", knowledgeBaseIds, query == null || query.trim().isEmpty());
            return SearchResult.builder()
                    .documents(new ArrayList<>())
                    .totalCount(0)
                    .searchTimeMs(0)
                    .build();
        }

        // 召回阶段取更多候选
        int recallTopK = useRerank ? Math.max(topK * 3, 20) : topK;

        log.info("知识库搜索: knowledgeBaseIds={}, query长度={}, topK={}, rerank={}", 
                knowledgeBaseIds, query.length(), topK, useRerank);

        try {
            // 1. 向量化查询（使用 query 类型 embedding，区别于文档入库的 document 类型）
            ChapterVector queryVector = embeddingService.embedQuery(query);

            // 2. 向量相似度召回
            List<KnowledgeChunkRepository.ChunkSearchResult> searchResults = 
                    chunkRepository.searchSimilarInMultiple(knowledgeBaseIds, queryVector.getEmbedding(), recallTopK);

            // 3. 过滤低分
            List<KnowledgeChunkRepository.ChunkSearchResult> filtered = new ArrayList<>();
            for (KnowledgeChunkRepository.ChunkSearchResult chunk : searchResults) {
                if (chunk.similarity() >= threshold) {
                    filtered.add(chunk);
                }
            }

            log.info("向量召回: 原始{}个, 过滤后{}个", searchResults.size(), filtered.size());

            // 4. Rerank 精排
            List<DocumentChunk> resultDocs;
            if (useRerank && !filtered.isEmpty()) {
                resultDocs = rerankAndBuild(query, filtered, topK);
            } else {
                resultDocs = buildDirectResults(filtered, topK);
            }

            long elapsed = System.currentTimeMillis() - startTime;
            log.info("知识库搜索完成: 返回{}个结果, 耗时{}ms", resultDocs.size(), elapsed);

            return SearchResult.builder()
                    .documents(resultDocs)
                    .totalCount(resultDocs.size())
                    .searchTimeMs(elapsed)
                    .build();

        } catch (Exception e) {
            log.error("知识库搜索失败", e);
            throw new RuntimeException("知识库搜索失败: " + e.getMessage(), e);
        }
    }

    /**
     * 使用 Rerank 精排后构建结果
     */
    private List<DocumentChunk> rerankAndBuild(String query,
                                                List<KnowledgeChunkRepository.ChunkSearchResult> chunks,
                                                int topK) {
        List<String> documents = new ArrayList<>();
        for (KnowledgeChunkRepository.ChunkSearchResult chunk : chunks) {
            documents.add(chunk.content());
        }

        List<RerankService.RerankResult> rerankResults = rerankService.rerank(query, documents, topK);

        log.info("Rerank 精排: 输入{}个, 输出{}个", chunks.size(), rerankResults.size());

        List<DocumentChunk> results = new ArrayList<>();
        for (RerankService.RerankResult rr : rerankResults) {
            int idx = rr.index();
            if (idx >= 0 && idx < chunks.size()) {
                KnowledgeChunkRepository.ChunkSearchResult original = chunks.get(idx);
                results.add(buildDocumentChunk(original, rr.relevanceScore()));
            }
        }
        return results;
    }

    /**
     * 不使用 Rerank，直接按向量相似度排序
     */
    private List<DocumentChunk> buildDirectResults(List<KnowledgeChunkRepository.ChunkSearchResult> chunks, int topK) {
        List<DocumentChunk> results = new ArrayList<>();
        // chunks 已按相似度降序排列（数据库查询保证）
        int limit = Math.min(topK, chunks.size());
        for (int i = 0; i < limit; i++) {
            results.add(buildDocumentChunk(chunks.get(i), chunks.get(i).similarity()));
        }
        return results;
    }

    private DocumentChunk buildDocumentChunk(KnowledgeChunkRepository.ChunkSearchResult chunk, double score) {
        java.util.Map<String, Object> metadataMap = new HashMap<>();
        if (chunk.metadata() != null && !chunk.metadata().isEmpty()) {
            try {
                com.google.gson.Gson gson = new com.google.gson.Gson();
                @SuppressWarnings("unchecked")
                java.util.Map<String, Object> parsed = gson.fromJson(chunk.metadata(), java.util.Map.class);
                if (parsed != null) {
                    metadataMap = parsed;
                }
            } catch (Exception e) {
                metadataMap.put("raw", chunk.metadata());
            }
        }

        String docName = metadataMap.containsKey("documentName") 
                ? String.valueOf(metadataMap.get("documentName")) : null;

        return DocumentChunk.builder()
                .id(chunk.chunkId())
                .documentId(chunk.documentId())
                .documentName(docName)
                .content(chunk.content())
                .score(score)
                .metadata(metadataMap)
                .build();
    }
}
