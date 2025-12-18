package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.MasteryLevel;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class StudyWordCommand {

    private final DailyWordRepository dailyWordRepository;
    private final UserDailyWordRepository userDailyWordRepository;

    @Transactional
    public void execute(Long userId, Long wordId) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        dailyWordRepository.findById(dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "单词不存在"));

        UserDailyWord userDailyWord = userDailyWordRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElseGet(() -> UserDailyWord.create(userIdObj, dailyWordId));

        userDailyWord.markAsStudied();
        userDailyWordRepository.save(userDailyWord);
    }

    @Transactional
    public void updateMastery(Long userId, Long wordId, Integer masteryLevel) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        UserDailyWord userDailyWord = userDailyWordRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "用户单词记录不存在"));

        userDailyWord.updateMasteryLevel(MasteryLevel.fromCode(masteryLevel));
        userDailyWordRepository.save(userDailyWord);
    }

    @Transactional
    public void toggleCollect(Long userId, Long wordId) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        dailyWordRepository.findById(dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "单词不存在"));

        UserDailyWord userDailyWord = userDailyWordRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElseGet(() -> UserDailyWord.create(userIdObj, dailyWordId));

        userDailyWord.toggleCollect();
        userDailyWordRepository.save(userDailyWord);
    }
}
