package com.novacloudedu.backend.application.dailylearning.query;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository.DailyWordPage;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.Duration;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class GetDailyWordQuery {

    public static final String CATEGORY_CACHE_KEY = "daily_word:categories";
    private static final Duration CATEGORY_CACHE_TTL = Duration.ofMinutes(10);

    private final DailyWordRepository dailyWordRepository;
    private final StringRedisTemplate redisTemplate;

    public Optional<DailyWord> execute(Long id) {
        return dailyWordRepository.findById(DailyWordId.of(id));
    }

    public List<DailyWord> executeByPublishDate(LocalDate publishDate) {
        return dailyWordRepository.findByPublishDate(publishDate);
    }

    public List<DailyWord> executeToday() {
        return dailyWordRepository.findByPublishDate(LocalDate.now());
    }

    public List<DailyWord> executeByCategory(String category, int page, int size) {
        return dailyWordRepository.findByCategory(category, page, size);
    }

    public List<DailyWord> executeByDifficulty(Integer difficulty, int page, int size) {
        return dailyWordRepository.findByDifficulty(Difficulty.fromCode(difficulty), page, size);
    }

    public List<DailyWord> executeList(int page, int size) {
        return dailyWordRepository.findAll(page, size);
    }

    public List<DailyWord> searchByWord(String keyword, int page, int size) {
        return dailyWordRepository.searchByWord(keyword, page, size);
    }

    public long count() {
        return dailyWordRepository.count();
    }

    // ==================== 分页查询（带完整分页信息） ====================

    public DailyWordPage executeListPaged(int page, int size) {
        return dailyWordRepository.findAllPaged(page, size);
    }

    public DailyWordPage executeByCategoryPaged(String category, int page, int size) {
        return dailyWordRepository.findByCategoryPaged(category, page, size);
    }

    public DailyWordPage executeByDifficultyPaged(Integer difficulty, int page, int size) {
        return dailyWordRepository.findByDifficultyPaged(Difficulty.fromCode(difficulty), page, size);
    }

    public DailyWordPage executePaged(String category, Integer difficulty, int page, int size) {
        Difficulty difficultyValue = difficulty != null ? Difficulty.fromCode(difficulty) : null;
        return dailyWordRepository.findPaged(category, difficultyValue, page, size);
    }

    public DailyWordPage searchByWordPaged(String keyword, int page, int size) {
        return dailyWordRepository.searchByWordPaged(keyword, page, size);
    }

    public List<String> executeCategories() {
        String cached = redisTemplate.opsForValue().get(CATEGORY_CACHE_KEY);
        if (cached != null) {
            if (cached.isBlank()) {
                return List.of();
            }
            return Arrays.stream(cached.split("\\n", -1))
                    .filter(category -> !category.isBlank())
                    .toList();
        }

        List<String> categories = dailyWordRepository.findCategories();
        try {
            redisTemplate.opsForValue().set(
                    CATEGORY_CACHE_KEY,
                    String.join("\n", categories),
                    CATEGORY_CACHE_TTL
            );
        } catch (RuntimeException e) {
            log.warn("每日单词分类缓存写入失败", e);
        }
        return categories;
    }

    public void evictCategoryCache() {
        redisTemplate.delete(CATEGORY_CACHE_KEY);
    }
}
