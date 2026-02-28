package com.novacloudedu.backend.infrastructure.ai;

import com.novacloudedu.backend.application.service.QueryRewriteService;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeChunkRepository;
import com.novacloudedu.backend.domain.ai.service.RerankService;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import com.novacloudedu.backend.domain.knowledge.service.KnowledgeSearchService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 知识库搜索服务实现 — 企业级多路召回 + RRF 融合
 * 
 * 完整 RAG 检索流程：
 * 1. Query 理解与改写（可选，LLM辅助）
 * 2. 动态 topK 计算
 * 3. 多路并行召回：向量召回 + BM25 全文检索
 * 4. RRF (Reciprocal Rank Fusion) 结果融合
 * 5. Rerank 模型精排（可选）
 * 6. 返回 top-K 结果
 * 
 * 支持三种检索模式（通过 SearchRequest.retrievalMode 控制）：
 * - VECTOR_ONLY:  纯向量召回
 * - HYBRID:       向量 + BM25 混合召回（RRF融合）
 * - HYBRID_RERANK: 混合召回 + Rerank 精排（推荐，默认）
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgeSearchServiceImpl implements KnowledgeSearchService {

    private final VectorEmbeddingService embeddingService;
    private final KnowledgeChunkRepository chunkRepository;
    private final RerankService rerankService;
    private final QueryRewriteService queryRewriteService;

    @Value("${ai.dashscope.rerank.enabled:true}")
    private boolean rerankEnabled;

    private static final com.google.gson.Gson GSON = new com.google.gson.Gson();

    /** RRF 常数 k，工业界通常取 60 */
    private static final int RRF_K = 60;

    @Override
    public SearchResult search(SearchRequest request) {
        long startTime = System.currentTimeMillis();

        List<Long> knowledgeBaseIds = request.getKnowledgeBaseIds();
        String query = request.getQuery();
        int baseTopK = request.getTopK() != null ? request.getTopK() : 5;
        double threshold = request.getSimilarityThreshold() != null ? request.getSimilarityThreshold() : 0.3;
        String mode = request.getRetrievalMode() != null ? request.getRetrievalMode() : "HYBRID_RERANK";
        boolean enableQueryRewrite = request.getEnableQueryRewrite() != null && request.getEnableQueryRewrite();
        boolean useDynamicTopK = request.getUseDynamicTopK() != null ? request.getUseDynamicTopK() : true;
        String queryRewriteModelId = request.getQueryRewriteModelId();
        String rerankModel = request.getRerankModel();

        if (knowledgeBaseIds == null || knowledgeBaseIds.isEmpty() || query == null || query.trim().isEmpty()) {
            log.warn("知识库搜索参数无效: knowledgeBaseIds={}, query为空={}", knowledgeBaseIds, query == null || query.trim().isEmpty());
            return SearchResult.builder()
                    .documents(new ArrayList<>())
                    .totalCount(0)
                    .searchTimeMs(0)
                    .build();
        }

        // 动态 topK
        int topK = useDynamicTopK ? queryRewriteService.computeDynamicTopK(query, baseTopK) : baseTopK;

        // 召回阶段取更多候选
        boolean isHybrid = "HYBRID".equals(mode) || "HYBRID_RERANK".equals(mode);
        boolean useRerank = rerankEnabled && "HYBRID_RERANK".equals(mode);
        int recallTopK = useRerank ? Math.max(topK * 4, 30) : (isHybrid ? Math.max(topK * 3, 20) : topK);

        log.info("知识库搜索: ids={}, query长度={}, mode={}, topK={}/base{}, rerank={}, hybrid={}, queryRewrite={}",
                knowledgeBaseIds, query.length(), mode, topK, baseTopK, useRerank, isHybrid, enableQueryRewrite);

        try {
            // 1. Query 改写（可选）
            List<String> queries;
            if (enableQueryRewrite) {
                queries = queryRewriteService.rewriteQuery(query, queryRewriteModelId);
            } else {
                queries = List.of(query);
            }

            // 2. 多路召回
            List<KnowledgeChunkRepository.ChunkSearchResult> vectorResults = vectorRecall(knowledgeBaseIds, queries, recallTopK);
            List<KnowledgeChunkRepository.ChunkSearchResult> bm25Results = new ArrayList<>();
            if (isHybrid) {
                bm25Results = bm25Recall(knowledgeBaseIds, queries, recallTopK);
            }

            log.info("多路召回: 向量{}个, BM25 {}个", vectorResults.size(), bm25Results.size());

            // 3. 融合
            List<KnowledgeChunkRepository.ChunkSearchResult> fusedResults;
            if (isHybrid && !bm25Results.isEmpty()) {
                fusedResults = rrfFusion(vectorResults, bm25Results, recallTopK);
                log.info("RRF融合: {}个候选", fusedResults.size());
            } else {
                fusedResults = vectorResults;
            }

            // 4. 阈值过滤
            // RRF 归一化后分数在 [~0.5, 1.0] 区间，原始 cosine-similarity 阈值（如 0.3）无法有效过滤
            // 对 hybrid 模式使用映射后的阈值；当后续有 Rerank 精排时跳过粗阈值过滤
            List<KnowledgeChunkRepository.ChunkSearchResult> filtered;
            if (useRerank) {
                // Rerank 会处理质量控制，此处不做粗阈值过滤
                filtered = fusedResults;
            } else {
                double effectiveThreshold = isHybrid
                        ? Math.max(threshold, 0.5 + (threshold * 0.5))  // 映射: 0.3 → 0.65, 0.5 → 0.75
                        : threshold;
                filtered = new ArrayList<>();
                for (KnowledgeChunkRepository.ChunkSearchResult chunk : fusedResults) {
                    if (chunk.similarity() >= effectiveThreshold) {
                        filtered.add(chunk);
                    }
                }
                log.info("阈值过滤: 融合{}个 → 过滤后{}个 (threshold={}, effective={})",
                        fusedResults.size(), filtered.size(), threshold, effectiveThreshold);
            }

            // 5. Rerank 精排
            List<DocumentChunk> resultDocs;
            if (useRerank && !filtered.isEmpty()) {
                resultDocs = rerankAndBuild(query, filtered, topK, rerankModel);
            } else {
                resultDocs = buildDirectResults(filtered, topK);
            }

            long elapsed = System.currentTimeMillis() - startTime;
            log.info("知识库搜索完成: 返回{}个结果, 耗时{}ms, mode={}", resultDocs.size(), elapsed, mode);

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

    // ==================== 多路召回 ====================

    /**
     * 向量召回（支持多查询）
     */
    private List<KnowledgeChunkRepository.ChunkSearchResult> vectorRecall(
            List<Long> knowledgeBaseIds, List<String> queries, int topK) {
        Map<Long, KnowledgeChunkRepository.ChunkSearchResult> deduped = new LinkedHashMap<>();

        for (String q : queries) {
            try {
                ChapterVector queryVector = embeddingService.embedQuery(q);
                List<KnowledgeChunkRepository.ChunkSearchResult> results =
                        chunkRepository.searchSimilarInMultiple(knowledgeBaseIds, queryVector.getEmbedding(), topK);
                for (KnowledgeChunkRepository.ChunkSearchResult r : results) {
                    // 保留最高分
                    deduped.merge(r.chunkId(), r, (old, nw) ->
                            nw.similarity() > old.similarity() ? nw : old);
                }
            } catch (Exception e) {
                log.warn("向量召回失败(query='{}'): {}", q.substring(0, Math.min(30, q.length())), e.getMessage());
            }
        }

        // 按相似度降序
        return deduped.values().stream()
                .sorted(Comparator.comparingDouble(KnowledgeChunkRepository.ChunkSearchResult::similarity).reversed())
                .collect(Collectors.toList());
    }

    /**
     * BM25 全文检索召回（支持多查询）
     */
    private List<KnowledgeChunkRepository.ChunkSearchResult> bm25Recall(
            List<Long> knowledgeBaseIds, List<String> queries, int topK) {
        Map<Long, KnowledgeChunkRepository.ChunkSearchResult> deduped = new LinkedHashMap<>();

        for (String q : queries) {
            try {
                List<KnowledgeChunkRepository.ChunkSearchResult> results =
                        chunkRepository.fullTextSearchInMultiple(knowledgeBaseIds, q, topK);
                for (KnowledgeChunkRepository.ChunkSearchResult r : results) {
                    deduped.merge(r.chunkId(), r, (old, nw) ->
                            nw.similarity() > old.similarity() ? nw : old);
                }
            } catch (Exception e) {
                log.warn("BM25召回失败(query='{}'): {}", q.substring(0, Math.min(30, q.length())), e.getMessage());
            }
        }

        return deduped.values().stream()
                .sorted(Comparator.comparingDouble(KnowledgeChunkRepository.ChunkSearchResult::similarity).reversed())
                .collect(Collectors.toList());
    }

    // ==================== RRF 融合 ====================

    /**
     * Reciprocal Rank Fusion (RRF)
     * 
     * 公式: score(d) = sum( 1 / (k + rank_i(d)) ) 对每个检索通道 i
     * k = 60（工业标准值）
     * 
     * 优点：无需训练、稳定、工程友好，是很多生产系统的默认融合方案
     */
    private List<KnowledgeChunkRepository.ChunkSearchResult> rrfFusion(
            List<KnowledgeChunkRepository.ChunkSearchResult> vectorResults,
            List<KnowledgeChunkRepository.ChunkSearchResult> bm25Results,
            int limit) {

        Map<Long, Double> rrfScores = new HashMap<>();
        Map<Long, KnowledgeChunkRepository.ChunkSearchResult> chunkMap = new HashMap<>();

        // 向量通道 RRF 分数
        for (int rank = 0; rank < vectorResults.size(); rank++) {
            KnowledgeChunkRepository.ChunkSearchResult r = vectorResults.get(rank);
            double score = 1.0 / (RRF_K + rank + 1);
            rrfScores.merge(r.chunkId(), score, Double::sum);
            chunkMap.putIfAbsent(r.chunkId(), r);
        }

        // BM25 通道 RRF 分数
        for (int rank = 0; rank < bm25Results.size(); rank++) {
            KnowledgeChunkRepository.ChunkSearchResult r = bm25Results.get(rank);
            double score = 1.0 / (RRF_K + rank + 1);
            rrfScores.merge(r.chunkId(), score, Double::sum);
            chunkMap.putIfAbsent(r.chunkId(), r);
        }

        // 按 RRF 分数降序排列，将 RRF 分数归一化后放入 similarity 字段
        double maxScore = rrfScores.values().stream().mapToDouble(Double::doubleValue).max().orElse(1.0);

        return rrfScores.entrySet().stream()
                .sorted(Map.Entry.<Long, Double>comparingByValue().reversed())
                .limit(limit)
                .map(entry -> {
                    KnowledgeChunkRepository.ChunkSearchResult original = chunkMap.get(entry.getKey());
                    double normalizedScore = entry.getValue() / maxScore;
                    return new KnowledgeChunkRepository.ChunkSearchResult(
                            original.chunkId(),
                            original.knowledgeBaseId(),
                            original.documentId(),
                            original.content(),
                            normalizedScore,
                            original.metadata()
                    );
                })
                .collect(Collectors.toList());
    }

    // ==================== Rerank & Build ====================

    /**
     * 使用 Rerank 精排后构建结果
     */
    private List<DocumentChunk> rerankAndBuild(String query,
                                                List<KnowledgeChunkRepository.ChunkSearchResult> chunks,
                                                int topK, String rerankModel) {
        List<String> documents = new ArrayList<>();
        for (KnowledgeChunkRepository.ChunkSearchResult chunk : chunks) {
            documents.add(chunk.content());
        }

        List<RerankService.RerankResult> rerankResults = rerankService.rerank(query, documents, topK, rerankModel);

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
     * 不使用 Rerank，直接按分数排序
     */
    private List<DocumentChunk> buildDirectResults(List<KnowledgeChunkRepository.ChunkSearchResult> chunks, int topK) {
        List<DocumentChunk> results = new ArrayList<>();
        int limit = Math.min(topK, chunks.size());
        for (int i = 0; i < limit; i++) {
            results.add(buildDocumentChunk(chunks.get(i), chunks.get(i).similarity()));
        }
        return results;
    }

    private DocumentChunk buildDocumentChunk(KnowledgeChunkRepository.ChunkSearchResult chunk, double score) {
        Map<String, Object> metadataMap = new HashMap<>();
        if (chunk.metadata() != null && !chunk.metadata().isEmpty()) {
            try {
                @SuppressWarnings("unchecked")
                Map<String, Object> parsed = GSON.fromJson(chunk.metadata(), Map.class);
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
