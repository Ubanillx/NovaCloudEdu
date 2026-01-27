package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.repository.KnowledgeChunkRepository;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 知识库检索节点执行器
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class KnowledgeRetrievalNodeExecutor implements NodeExecutor {

    private final VectorEmbeddingService embeddingService;
    private final KnowledgeChunkRepository chunkRepository;

    @Override
    public NodeType getNodeType() {
        return NodeType.KNOWLEDGE_RETRIEVAL;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        // 获取配置
        List<Long> knowledgeBaseIds = getKnowledgeBaseIds(config);
        String queryVariable = (String) config.getOrDefault("queryVariable", "userInput");
        int topK = (int) config.getOrDefault("topK", 5);
        double minScore = config.get("minScore") != null ? 
                ((Number) config.get("minScore")).doubleValue() : 0.5;
        
        // 获取查询文本
        String query = (String) input.get(queryVariable);
        if (query == null || query.isEmpty()) {
            query = (String) input.getOrDefault("query", "");
        }
        
        if (query.isEmpty()) {
            log.warn("知识库检索节点: 查询文本为空");
            return createEmptyResult();
        }

        log.info("知识库检索节点执行: knowledgeBaseIds={}, query长度={}, topK={}", 
                knowledgeBaseIds, query.length(), topK);

        try {
            // 向量化查询
            ChapterVector queryVector = embeddingService.embedText(query);
            
            // 在各知识库中检索
            List<Map<String, Object>> allResults = new ArrayList<>();
            
            // 使用多知识库搜索
            List<KnowledgeChunkRepository.ChunkSearchResult> searchResults = 
                    chunkRepository.searchSimilarInMultiple(knowledgeBaseIds, queryVector.getEmbedding(), topK);
            
            // 过滤低于最小相似度的结果
            for (KnowledgeChunkRepository.ChunkSearchResult chunk : searchResults) {
                if (chunk.similarity() >= minScore) {
                    Map<String, Object> chunkMap = new HashMap<>();
                    chunkMap.put("chunkId", chunk.chunkId());
                    chunkMap.put("knowledgeBaseId", chunk.knowledgeBaseId());
                    chunkMap.put("documentId", chunk.documentId());
                    chunkMap.put("content", chunk.content());
                    chunkMap.put("score", chunk.similarity());
                    chunkMap.put("metadata", chunk.metadata());
                    allResults.add(chunkMap);
                }
            }
            
            // 按相似度排序并取topK
            allResults.sort((a, b) -> {
                double scoreA = ((Number) a.getOrDefault("score", 0.0)).doubleValue();
                double scoreB = ((Number) b.getOrDefault("score", 0.0)).doubleValue();
                return Double.compare(scoreB, scoreA);
            });
            
            if (allResults.size() > topK) {
                allResults = allResults.subList(0, topK);
            }
            
            // 构建上下文
            StringBuilder contextBuilder = new StringBuilder();
            for (Map<String, Object> chunk : allResults) {
                String content = (String) chunk.get("content");
                if (content != null) {
                    contextBuilder.append(content).append("\n\n");
                }
            }
            
            Map<String, Object> result = new HashMap<>();
            result.put("retrievedChunks", allResults);
            result.put("retrievedContext", contextBuilder.toString().trim());
            result.put("retrievedCount", allResults.size());
            
            log.info("知识库检索完成: 检索到{}个相关片段", allResults.size());
            
            return result;
            
        } catch (Exception e) {
            log.error("知识库检索失败", e);
            throw new RuntimeException("知识库检索失败: " + e.getMessage(), e);
        }
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null) {
            throw new IllegalArgumentException("知识库检索节点缺少配置");
        }
        if (!node.getConfig().containsKey("knowledgeBaseIds")) {
            throw new IllegalArgumentException("知识库检索节点缺少knowledgeBaseIds配置");
        }
    }

    @SuppressWarnings("unchecked")
    private List<Long> getKnowledgeBaseIds(Map<String, Object> config) {
        Object ids = config.get("knowledgeBaseIds");
        if (ids instanceof List) {
            List<?> list = (List<?>) ids;
            List<Long> result = new ArrayList<>();
            for (Object id : list) {
                if (id instanceof Number) {
                    result.add(((Number) id).longValue());
                }
            }
            return result;
        }
        return new ArrayList<>();
    }

    private Map<String, Object> createEmptyResult() {
        Map<String, Object> result = new HashMap<>();
        result.put("retrievedChunks", new ArrayList<>());
        result.put("retrievedContext", "");
        result.put("retrievedCount", 0);
        return result;
    }
}
