package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class UpdateDailyWordCommand {

    private final DailyWordRepository dailyWordRepository;

    @Transactional
    public void execute(Long id, String word, String pronunciation, String audioUrl, String translation,
                       String example, String exampleTranslation, Integer difficulty,
                       String category, String notes, LocalDate publishDate) {
        
        DailyWord dailyWord = dailyWordRepository.findById(DailyWordId.of(id))
                .orElseThrow(() -> new BusinessException(40400, "每日单词不存在"));

        dailyWord.updateInfo(word, pronunciation, audioUrl, translation, example, exampleTranslation,
                Difficulty.fromCode(difficulty), category, notes, publishDate);

        dailyWordRepository.save(dailyWord);
    }
}
