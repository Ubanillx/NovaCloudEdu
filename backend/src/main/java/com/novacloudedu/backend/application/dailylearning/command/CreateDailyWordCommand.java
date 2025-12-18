package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class CreateDailyWordCommand {

    private final DailyWordRepository dailyWordRepository;

    @Transactional
    public Long execute(String word, String pronunciation, String audioUrl, String translation,
                       String example, String exampleTranslation, Integer difficulty,
                       String category, String notes, LocalDate publishDate, Long adminId) {
        
        DailyWord dailyWord = DailyWord.create(
                word, pronunciation, audioUrl, translation, example, exampleTranslation,
                Difficulty.fromCode(difficulty), category, notes, publishDate, UserId.of(adminId)
        );

        dailyWordRepository.save(dailyWord);
        return dailyWord.getId().value();
    }
}
