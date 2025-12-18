package com.novacloudedu.backend.domain.dailylearning.repository;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface DailyWordRepository {

    DailyWord save(DailyWord dailyWord);

    Optional<DailyWord> findById(DailyWordId id);

    List<DailyWord> findByPublishDate(LocalDate publishDate);

    List<DailyWord> findByCategory(String category, int page, int size);

    List<DailyWord> findByDifficulty(Difficulty difficulty, int page, int size);

    List<DailyWord> findAll(int page, int size);

    List<DailyWord> searchByWord(String keyword, int page, int size);

    long count();

    long countByCategory(String category);

    void deleteById(DailyWordId id);
}
