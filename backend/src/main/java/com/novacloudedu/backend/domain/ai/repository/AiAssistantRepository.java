package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.AiAssistant;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantId;
import com.novacloudedu.backend.domain.ai.valueobject.AiAssistantStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * AI助手仓储接口
 */
public interface AiAssistantRepository {

    /**
     * 保存AI助手
     */
    AiAssistant save(AiAssistant assistant);

    /**
     * 根据ID查找
     */
    Optional<AiAssistant> findById(AiAssistantId id);

    /**
     * 根据创建者查找
     */
    List<AiAssistant> findByCreatorId(UserId creatorId, int page, int size);

    /**
     * 根据状态查找
     */
    List<AiAssistant> findByStatus(AiAssistantStatus status, int page, int size);

    /**
     * 查找公开的AI助手
     */
    List<AiAssistant> findPublicAssistants(int page, int size);

    /**
     * 根据分类查找
     */
    List<AiAssistant> findByCategory(String category, int page, int size);

    /**
     * 搜索AI助手
     */
    List<AiAssistant> search(String keyword, int page, int size);

    /**
     * 统计创建者的AI助手数量
     */
    long countByCreatorId(UserId creatorId);

    /**
     * 删除AI助手
     */
    void delete(AiAssistantId id);

    /**
     * 绑定知识库
     */
    void bindKnowledgeBase(AiAssistantId assistantId, Long knowledgeBaseId);

    /**
     * 解绑知识库
     */
    void unbindKnowledgeBase(AiAssistantId assistantId, Long knowledgeBaseId);

    /**
     * 获取AI助手绑定的知识库ID列表
     */
    List<Long> findKnowledgeBaseIds(AiAssistantId assistantId);
}
