package com.novacloudedu.backend.application.dailylearning.query;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetDailyWordQuery {

    private final DailyWordRepository dailyWordRepository;

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
}
