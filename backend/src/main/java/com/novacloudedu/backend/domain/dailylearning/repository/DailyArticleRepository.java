package com.novacloudedu.backend.domain.dailylearning.repository;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface DailyArticleRepository {

    DailyArticle save(DailyArticle dailyArticle);

    Optional<DailyArticle> findById(DailyArticleId id);

    List<DailyArticle> findByPublishDate(LocalDate publishDate);

    List<DailyArticle> findByCategory(String category, int page, int size);

    List<DailyArticle> findByDifficulty(Difficulty difficulty, int page, int size);

    List<DailyArticle> findAll(int page, int size);

    List<DailyArticle> searchByKeyword(String keyword, int page, int size);

    long count();

    long countByCategory(String category);

    long countByDifficulty(Difficulty difficulty);

    long countByKeyword(String keyword);

    void deleteById(DailyArticleId id);

    /**
     * 分页查询（带完整分页信息）
     */
    DailyArticlePage findAllPaged(int page, int size);

    DailyArticlePage findByCategoryPaged(String category, int page, int size);

    DailyArticlePage findByDifficultyPaged(Difficulty difficulty, int page, int size);

    DailyArticlePage searchByKeywordPaged(String keyword, int page, int size);

    /**
     * 文章分页结果
     */
    record DailyArticlePage(List<DailyArticle> articles, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return pageSize > 0 ? (int) Math.ceil((double) total / pageSize) : 0;
        }
    }
}
