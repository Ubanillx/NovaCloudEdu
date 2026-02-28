package com.novacloudedu.backend.application.ai.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 知识库视图对象
 */
@Data
public class KnowledgeBaseVO {

    private Long id;
    private String name;
    private String description;

    private String embeddingModel;
    private Integer embeddingDimension;
    private Integer chunkSize;
    private Integer chunkOverlap;
    private String chunkStrategy;
    private Boolean parentChildMode;
    private Integer parentChunkSize;
    private Boolean preserveMetadata;
    private Double semanticThreshold;

    private String retrievalMode;
    private Boolean enableQueryRewrite;
    private Boolean useDynamicTopK;
    private Integer defaultTopK;
    private String queryRewriteModelId;
    private String rerankModel;

    private Integer documentCount;
    private Integer chunkCount;

    private String status;

    private Long creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
