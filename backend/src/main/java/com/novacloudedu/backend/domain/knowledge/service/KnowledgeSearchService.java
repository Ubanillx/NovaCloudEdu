package com.novacloudedu.backend.domain.knowledge.service;

import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * 知识库搜索服务接口
 */
public interface KnowledgeSearchService {

    /**
     * 搜索知识库
     */
    SearchResult search(SearchRequest request);

    @Data
    @Builder
    class SearchRequest {
        private List<Long> knowledgeBaseIds;
        private String query;
        private Integer topK;
        private Double similarityThreshold;
        private String retrievalMode;
        private Boolean includeMetadata;
        private Boolean includeScore;
    }

    @Data
    @Builder
    class SearchResult {
        private List<DocumentChunk> documents;
        private int totalCount;
        private long searchTimeMs;
    }

    @Data
    @Builder
    class DocumentChunk {
        private Long id;
        private Long documentId;
        private String documentName;
        private String content;
        private Double score;
        private Integer chunkIndex;
        private java.util.Map<String, Object> metadata;
    }
}
