package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.ReadingQuiz;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.ReadingQuizId;

import java.util.List;
import java.util.Optional;

/**
 * 阅读测试仓储接口
 */
public interface ReadingQuizRepository {

    /**
     * 保存测试
     */
    ReadingQuiz save(ReadingQuiz quiz);

    /**
     * 根据ID查找测试
     */
    Optional<ReadingQuiz> findById(ReadingQuizId id);

    /**
     * 查找章节的所有测试
     */
    List<ReadingQuiz> findByChapterId(ChapterId chapterId);

    /**
     * 查找最新的测试
     */
    Optional<ReadingQuiz> findLatestByChapterId(ChapterId chapterId);

    /**
     * 删除测试
     */
    void delete(ReadingQuizId id);

    /**
     * 删除章节的所有测试
     */
    void deleteByChapterId(ChapterId chapterId);
}
