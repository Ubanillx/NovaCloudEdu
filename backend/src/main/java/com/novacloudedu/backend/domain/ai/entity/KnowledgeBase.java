package com.novacloudedu.backend.domain.ai.entity;

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
        kb.embeddingModel = "text-embedding-v2";
        kb.embeddingDimension = 1536;
        kb.chunkSize = 500;
        kb.chunkOverlap = 50;
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
    public void updateEmbeddingConfig(Integer chunkSize, Integer chunkOverlap) {
        if (chunkSize != null && chunkSize > 0) {
            this.chunkSize = chunkSize;
        }
        if (chunkOverlap != null && chunkOverlap >= 0) {
            this.chunkOverlap = chunkOverlap;
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
