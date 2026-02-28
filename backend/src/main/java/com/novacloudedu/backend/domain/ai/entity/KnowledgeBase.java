package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.ChunkStrategy;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 知识库聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class KnowledgeBase {

    private KnowledgeBaseId id;
    private String name;
    private String description;
    
    // 向量化配置
    private String embeddingModel;
    private Integer embeddingDimension;
    private Integer chunkSize;
    private Integer chunkOverlap;
    private ChunkStrategy chunkStrategy;
    private Boolean parentChildMode;
    private Integer parentChunkSize;
    private Boolean preserveMetadata;
    private Double semanticThreshold;
    
    // RAG 检索配置
    private String retrievalMode;
    private Boolean enableQueryRewrite;
    private Boolean useDynamicTopK;
    private Integer defaultTopK;
    private String queryRewriteModelId;
    private String rerankModel;
    
    // 统计
    private Integer documentCount;
    private Integer chunkCount;
    
    // 状态
    private String status;
    
    // 审计
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新的知识库
     */
    public static KnowledgeBase create(String name, String description, UserId creatorId) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("知识库名称不能为空");
        }
        if (creatorId == null) {
            throw new IllegalArgumentException("创建者ID不能为空");
        }

        KnowledgeBase kb = new KnowledgeBase();
        kb.name = name.trim();
        kb.description = description;
        kb.creatorId = creatorId;
        kb.embeddingModel = "text-embedding-v4";
        kb.embeddingDimension = 1024;
        kb.chunkSize = 500;
        kb.chunkOverlap = 50;
        kb.chunkStrategy = ChunkStrategy.SEMANTIC;
        kb.parentChildMode = false;
        kb.parentChunkSize = 1500;
        kb.preserveMetadata = true;
        kb.semanticThreshold = 0.5;
        kb.retrievalMode = "HYBRID_RERANK";
        kb.enableQueryRewrite = false;
        kb.useDynamicTopK = true;
        kb.defaultTopK = 5;
        kb.queryRewriteModelId = "dashscope/qwen-turbo";
        kb.rerankModel = "qwen3-rerank";
        kb.documentCount = 0;
        kb.chunkCount = 0;
        kb.status = "ACTIVE";
        kb.createTime = LocalDateTime.now();
        kb.updateTime = LocalDateTime.now();
        return kb;
    }

    /**
     * 从数据库重构
     */
    public static KnowledgeBase reconstruct(
            KnowledgeBaseId id,
            String name,
            String description,
            String embeddingModel,
            Integer embeddingDimension,
            Integer chunkSize,
            Integer chunkOverlap,
            ChunkStrategy chunkStrategy,
            Boolean parentChildMode,
            Integer parentChunkSize,
            Boolean preserveMetadata,
            Double semanticThreshold,
            String retrievalMode,
            Boolean enableQueryRewrite,
            Boolean useDynamicTopK,
            Integer defaultTopK,
            String queryRewriteModelId,
            String rerankModel,
            Integer documentCount,
            Integer chunkCount,
            String status,
            UserId creatorId,
            LocalDateTime createTime,
            LocalDateTime updateTime) {
        
        KnowledgeBase kb = new KnowledgeBase();
        kb.id = id;
        kb.name = name;
        kb.description = description;
        kb.embeddingModel = embeddingModel;
        kb.embeddingDimension = embeddingDimension;
        kb.chunkSize = chunkSize;
        kb.chunkOverlap = chunkOverlap;
        kb.chunkStrategy = chunkStrategy != null ? chunkStrategy : ChunkStrategy.SEMANTIC;
        kb.parentChildMode = parentChildMode != null ? parentChildMode : false;
        kb.parentChunkSize = parentChunkSize != null ? parentChunkSize : 1500;
        kb.preserveMetadata = preserveMetadata != null ? preserveMetadata : true;
        kb.semanticThreshold = semanticThreshold != null ? semanticThreshold : 0.5;
        kb.retrievalMode = retrievalMode != null ? retrievalMode : "HYBRID_RERANK";
        kb.enableQueryRewrite = enableQueryRewrite != null ? enableQueryRewrite : false;
        kb.useDynamicTopK = useDynamicTopK != null ? useDynamicTopK : true;
        kb.defaultTopK = defaultTopK != null ? defaultTopK : 5;
        kb.queryRewriteModelId = queryRewriteModelId != null ? queryRewriteModelId : "dashscope/qwen-turbo";
        kb.rerankModel = rerankModel != null ? rerankModel : "qwen3-rerank";
        kb.documentCount = documentCount;
        kb.chunkCount = chunkCount;
        kb.status = status;
        kb.creatorId = creatorId;
        kb.createTime = createTime;
        kb.updateTime = updateTime;
        return kb;
    }

    /**
     * 更新基本信息
     */
    public void updateBasicInfo(String name, String description) {
        if (name != null && !name.trim().isEmpty()) {
            this.name = name.trim();
        }
        this.description = description;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新向量化配置
     */
    public void updateEmbeddingConfig(String embeddingModel, Integer embeddingDimension, Integer chunkSize, Integer chunkOverlap) {
        if (embeddingModel != null && !embeddingModel.isBlank()) {
            this.embeddingModel = embeddingModel;
        }
        if (embeddingDimension != null && embeddingDimension > 0) {
            this.embeddingDimension = embeddingDimension;
        }
        if (chunkSize != null && chunkSize > 0) {
            this.chunkSize = chunkSize;
        }
        if (chunkOverlap != null && chunkOverlap >= 0) {
            this.chunkOverlap = chunkOverlap;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新切分配置
     */
    public void updateChunkConfig(ChunkStrategy chunkStrategy, Boolean parentChildMode,
                                   Integer parentChunkSize, Boolean preserveMetadata,
                                   Double semanticThreshold) {
        if (chunkStrategy != null) {
            this.chunkStrategy = chunkStrategy;
        }
        if (parentChildMode != null) {
            this.parentChildMode = parentChildMode;
        }
        if (parentChunkSize != null && parentChunkSize > 0) {
            this.parentChunkSize = parentChunkSize;
        }
        if (preserveMetadata != null) {
            this.preserveMetadata = preserveMetadata;
        }
        if (semanticThreshold != null && semanticThreshold >= 0 && semanticThreshold <= 1) {
            this.semanticThreshold = semanticThreshold;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新RAG检索配置
     */
    public void updateRetrievalConfig(String retrievalMode, Boolean enableQueryRewrite, Boolean useDynamicTopK, Integer defaultTopK, String queryRewriteModelId, String rerankModel) {
        if (retrievalMode != null) {
            this.retrievalMode = retrievalMode;
        }
        if (enableQueryRewrite != null) {
            this.enableQueryRewrite = enableQueryRewrite;
        }
        if (useDynamicTopK != null) {
            this.useDynamicTopK = useDynamicTopK;
        }
        if (defaultTopK != null && defaultTopK > 0 && defaultTopK <= 20) {
            this.defaultTopK = defaultTopK;
        }
        if (queryRewriteModelId != null && !queryRewriteModelId.isBlank()) {
            this.queryRewriteModelId = queryRewriteModelId;
        }
        if (rerankModel != null && !rerankModel.isBlank()) {
            this.rerankModel = rerankModel;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加文档数量
     */
    public void incrementDocumentCount() {
        this.documentCount++;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 减少文档数量
     */
    public void decrementDocumentCount() {
        if (this.documentCount > 0) {
            this.documentCount--;
            this.updateTime = LocalDateTime.now();
        }
    }

    /**
     * 更新分块数量
     */
    public void updateChunkCount(int chunkCount) {
        this.chunkCount = chunkCount;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加分块数量
     */
    public void addChunkCount(int count) {
        this.chunkCount += count;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 归档
     */
    public void archive() {
        this.status = "ARCHIVED";
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 激活
     */
    public void activate() {
        this.status = "ACTIVE";
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 是否活跃
     */
    public boolean isActive() {
        return "ACTIVE".equals(this.status);
    }
}
