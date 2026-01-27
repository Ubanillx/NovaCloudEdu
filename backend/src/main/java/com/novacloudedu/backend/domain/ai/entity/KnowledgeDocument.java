package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.ai.valueobject.DocumentStatus;
import com.novacloudedu.backend.domain.ai.valueobject.DocumentType;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeDocumentId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 知识库文档实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class KnowledgeDocument {

    private KnowledgeDocumentId id;
    private KnowledgeBaseId knowledgeBaseId;
    
    // 文档信息
    private String name;
    private DocumentType fileType;
    private String fileUrl;
    private Long fileSize;
    
    // 内容
    private String content;
    private String contentHash;
    
    // 处理状态
    private Integer chunkCount;
    private DocumentStatus status;
    private String errorMessage;
    
    // 审计
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新文档
     */
    public static KnowledgeDocument create(KnowledgeBaseId knowledgeBaseId, String name, 
                                           DocumentType fileType, String fileUrl, 
                                           Long fileSize, UserId creatorId) {
        if (knowledgeBaseId == null) {
            throw new IllegalArgumentException("知识库ID不能为空");
        }
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("文档名称不能为空");
        }
        if (creatorId == null) {
            throw new IllegalArgumentException("创建者ID不能为空");
        }

        KnowledgeDocument doc = new KnowledgeDocument();
        doc.knowledgeBaseId = knowledgeBaseId;
        doc.name = name.trim();
        doc.fileType = fileType != null ? fileType : DocumentType.TXT;
        doc.fileUrl = fileUrl;
        doc.fileSize = fileSize != null ? fileSize : 0L;
        doc.chunkCount = 0;
        doc.status = DocumentStatus.PENDING;
        doc.creatorId = creatorId;
        doc.createTime = LocalDateTime.now();
        doc.updateTime = LocalDateTime.now();
        return doc;
    }

    /**
     * 从数据库重构
     */
    public static KnowledgeDocument reconstruct(
            KnowledgeDocumentId id,
            KnowledgeBaseId knowledgeBaseId,
            String name,
            DocumentType fileType,
            String fileUrl,
            Long fileSize,
            String content,
            String contentHash,
            Integer chunkCount,
            DocumentStatus status,
            String errorMessage,
            UserId creatorId,
            LocalDateTime createTime,
            LocalDateTime updateTime) {
        
        KnowledgeDocument doc = new KnowledgeDocument();
        doc.id = id;
        doc.knowledgeBaseId = knowledgeBaseId;
        doc.name = name;
        doc.fileType = fileType;
        doc.fileUrl = fileUrl;
        doc.fileSize = fileSize;
        doc.content = content;
        doc.contentHash = contentHash;
        doc.chunkCount = chunkCount;
        doc.status = status;
        doc.errorMessage = errorMessage;
        doc.creatorId = creatorId;
        doc.createTime = createTime;
        doc.updateTime = updateTime;
        return doc;
    }

    /**
     * 设置内容
     */
    public void setContent(String content, String contentHash) {
        this.content = content;
        this.contentHash = contentHash;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 开始处理
     */
    public void startProcessing() {
        this.status = DocumentStatus.PROCESSING;
        this.errorMessage = null;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 处理完成
     */
    public void completeProcessing(int chunkCount) {
        this.status = DocumentStatus.COMPLETED;
        this.chunkCount = chunkCount;
        this.errorMessage = null;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 处理失败
     */
    public void failProcessing(String errorMessage) {
        this.status = DocumentStatus.FAILED;
        this.errorMessage = errorMessage;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 重置为待处理
     */
    public void resetToPending() {
        this.status = DocumentStatus.PENDING;
        this.chunkCount = 0;
        this.errorMessage = null;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 是否已完成处理
     */
    public boolean isCompleted() {
        return this.status == DocumentStatus.COMPLETED;
    }

    /**
     * 是否处理失败
     */
    public boolean isFailed() {
        return this.status == DocumentStatus.FAILED;
    }

    /**
     * 是否正在处理
     */
    public boolean isProcessing() {
        return this.status == DocumentStatus.PROCESSING;
    }
}
