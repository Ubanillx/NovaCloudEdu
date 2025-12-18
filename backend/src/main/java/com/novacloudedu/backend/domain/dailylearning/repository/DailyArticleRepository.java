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

    void deleteById(DailyArticleId id);
}
