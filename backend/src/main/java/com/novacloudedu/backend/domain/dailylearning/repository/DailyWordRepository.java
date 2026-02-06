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

    long countByDifficulty(Difficulty difficulty);

    long countByKeyword(String keyword);

    void deleteById(DailyWordId id);

    /**
     * 分页查询（带完整分页信息）
     */
    DailyWordPage findAllPaged(int page, int size);

    DailyWordPage findByCategoryPaged(String category, int page, int size);

    DailyWordPage findByDifficultyPaged(Difficulty difficulty, int page, int size);

    DailyWordPage searchByWordPaged(String keyword, int page, int size);

    /**
     * 单词分页结果
     */
    record DailyWordPage(List<DailyWord> words, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return pageSize > 0 ? (int) Math.ceil((double) total / pageSize) : 0;
        }
    }
}
