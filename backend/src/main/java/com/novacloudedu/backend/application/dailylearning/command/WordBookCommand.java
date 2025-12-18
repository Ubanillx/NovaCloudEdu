package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.entity.UserWordBook;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserWordBookRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.LearningStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class WordBookCommand {

    private final DailyWordRepository dailyWordRepository;
    private final UserWordBookRepository userWordBookRepository;

    @Transactional
    public Long addToWordBook(Long userId, Long wordId) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        dailyWordRepository.findById(dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "单词不存在"));

        UserWordBook existingWordBook = userWordBookRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElse(null);

        if (existingWordBook != null) {
            if (existingWordBook.isDeleted()) {
                existingWordBook.restore();
                userWordBookRepository.save(existingWordBook);
                return existingWordBook.getId();
            }
            throw new BusinessException(40000, "单词已在生词本中");
        }

        UserWordBook wordBook = UserWordBook.create(userIdObj, dailyWordId);
        userWordBookRepository.save(wordBook);
        return wordBook.getId();
    }

    @Transactional
    public void updateLearningStatus(Long userId, Long wordBookId, Integer status) {
        UserWordBook wordBook = userWordBookRepository.findById(wordBookId)
                .orElseThrow(() -> new BusinessException(40400, "生词本记录不存在"));

        if (!wordBook.getUserId().value().equals(userId)) {
            throw new BusinessException(40300, "无权操作此记录");
        }

        wordBook.updateLearningStatus(LearningStatus.fromCode(status));
        userWordBookRepository.save(wordBook);
    }

    @Transactional
    public void removeFromWordBook(Long userId, Long wordBookId) {
        UserWordBook wordBook = userWordBookRepository.findById(wordBookId)
                .orElseThrow(() -> new BusinessException(40400, "生词本记录不存在"));

        if (!wordBook.getUserId().value().equals(userId)) {
            throw new BusinessException(40300, "无权操作此记录");
        }

        wordBook.markAsDeleted();
        userWordBookRepository.save(wordBook);
    }
}
