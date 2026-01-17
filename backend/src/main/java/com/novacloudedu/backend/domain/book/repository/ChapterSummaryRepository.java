package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.ChapterSummary;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterSummaryId;
import com.novacloudedu.backend.domain.book.valueobject.SummaryType;

import java.util.List;
import java.util.Optional;

/**
 * 章节总结仓储接口
 */
public interface ChapterSummaryRepository {

    /**
     * 保存总结
     */
    ChapterSummary save(ChapterSummary summary);

    /**
     * 根据ID查找总结
     */
    Optional<ChapterSummary> findById(ChapterSummaryId id);

    /**
     * 查找章节的特定类型总结
     */
    Optional<ChapterSummary> findByChapterIdAndType(ChapterId chapterId, SummaryType type);

    /**
     * 查找章节的所有总结
     */
    List<ChapterSummary> findByChapterId(ChapterId chapterId);

    /**
     * 删除总结
     */
    void delete(ChapterSummaryId id);

    /**
     * 检查总结是否存在
     */
    boolean existsByChapterIdAndType(ChapterId chapterId, SummaryType type);
}
