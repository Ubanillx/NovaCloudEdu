package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.KnowledgeBase;
import com.novacloudedu.backend.domain.ai.valueobject.KnowledgeBaseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 知识库仓储接口
 */
public interface KnowledgeBaseRepository {

    /**
     * 保存知识库
     */
    KnowledgeBase save(KnowledgeBase knowledgeBase);

    /**
     * 根据ID查找
     */
    Optional<KnowledgeBase> findById(KnowledgeBaseId id);

    /**
     * 根据创建者查找
     */
    List<KnowledgeBase> findByCreatorId(UserId creatorId, int page, int size);

    /**
     * 查找活跃的知识库
     */
    List<KnowledgeBase> findActiveByCreatorId(UserId creatorId, int page, int size);

    /**
     * 搜索知识库
     */
    List<KnowledgeBase> search(String keyword, UserId creatorId, int page, int size);

    /**
     * 统计创建者的知识库数量
     */
    long countByCreatorId(UserId creatorId);

    /**
     * 删除知识库
     */
    void delete(KnowledgeBaseId id);

    /**
     * 更新分块数量
     */
    void updateChunkCount(KnowledgeBaseId id, int chunkCount);
}
