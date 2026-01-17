package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.KnowledgePoint;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.KnowledgePointId;
import com.novacloudedu.backend.domain.book.valueobject.KnowledgePointType;

import java.util.List;
import java.util.Optional;

/**
 * 知识点仓储接口
 */
public interface KnowledgePointRepository {

    /**
     * 保存知识点
     */
    KnowledgePoint save(KnowledgePoint point);

    /**
     * 批量保存知识点
     */
    List<KnowledgePoint> saveAll(List<KnowledgePoint> points);

    /**
     * 根据ID查找知识点
     */
    Optional<KnowledgePoint> findById(KnowledgePointId id);

    /**
     * 查找章节的所有知识点
     */
    List<KnowledgePoint> findByChapterId(ChapterId chapterId);

    /**
     * 查找特定类型的知识点
     */
    List<KnowledgePoint> findByChapterIdAndType(ChapterId chapterId, KnowledgePointType type);

    /**
     * 根据名称搜索知识点
     */
    List<KnowledgePoint> searchByName(String keyword, int page, int size);

    /**
     * 删除知识点
     */
    void delete(KnowledgePointId id);

    /**
     * 删除章节的所有知识点
     */
    void deleteByChapterId(ChapterId chapterId);
}
