package com.novacloudedu.backend.application.dailylearning.query;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetDailyArticleQuery {

    private final DailyArticleRepository dailyArticleRepository;

    public Optional<DailyArticle> execute(Long id) {
        return dailyArticleRepository.findById(DailyArticleId.of(id));
    }

    public List<DailyArticle> executeByPublishDate(LocalDate publishDate) {
        return dailyArticleRepository.findByPublishDate(publishDate);
    }

    public List<DailyArticle> executeToday() {
        return dailyArticleRepository.findByPublishDate(LocalDate.now());
    }

    public List<DailyArticle> executeByCategory(String category, int page, int size) {
        return dailyArticleRepository.findByCategory(category, page, size);
    }

    public List<DailyArticle> executeByDifficulty(Integer difficulty, int page, int size) {
        return dailyArticleRepository.findByDifficulty(Difficulty.fromCode(difficulty), page, size);
    }

    public List<DailyArticle> executeList(int page, int size) {
        return dailyArticleRepository.findAll(page, size);
    }

    public List<DailyArticle> searchByKeyword(String keyword, int page, int size) {
        return dailyArticleRepository.searchByKeyword(keyword, page, size);
    }

    public long count() {
        return dailyArticleRepository.count();
    }
}
