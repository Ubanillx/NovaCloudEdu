package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.KnowledgeDocument;
import com.novacloudedu.backend.domain.ai.valueobject.DocumentStatus;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeDocumentId;

import java.util.List;
import java.util.Optional;

/**
 * 知识库文档仓储接口
 */
public interface KnowledgeDocumentRepository {

    /**
     * 保存文档
     */
    KnowledgeDocument save(KnowledgeDocument document);

    /**
     * 根据ID查找
     */
    Optional<KnowledgeDocument> findById(KnowledgeDocumentId id);

    /**
     * 根据知识库ID查找文档列表
     */
    List<KnowledgeDocument> findByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId, int page, int size);

    /**
     * 根据状态查找
     */
    List<KnowledgeDocument> findByStatus(DocumentStatus status, int page, int size);

    /**
     * 查找待处理的文档
     */
    List<KnowledgeDocument> findPendingDocuments(int limit);

    /**
     * 根据知识库ID查找待处理的文档
     */
    List<KnowledgeDocument> findPendingByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId);

    /**
     * 统计知识库的文档数量
     */
    long countByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId);

    /**
     * 按状态统计知识库的文档数量
     */
    java.util.Map<String, Long> countByKnowledgeBaseIdGroupByStatus(KnowledgeBaseId knowledgeBaseId);

    /**
     * 删除文档
     */
    void delete(KnowledgeDocumentId id);

    /**
     * 根据知识库ID删除所有文档
     */
    void deleteByKnowledgeBaseId(KnowledgeBaseId knowledgeBaseId);
}
