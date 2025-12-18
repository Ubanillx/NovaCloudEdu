package com.novacloudedu.backend.application.dailylearning.query;

import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetUserDailyWordQuery {

    private final UserDailyWordRepository userDailyWordRepository;

    public Optional<UserDailyWord> executeByUserIdAndWordId(Long userId, Long wordId) {
        return userDailyWordRepository.findByUserIdAndWordId(UserId.of(userId), DailyWordId.of(wordId));
    }

    public List<UserDailyWord> executeByUserId(Long userId, int page, int size) {
        return userDailyWordRepository.findByUserId(UserId.of(userId), page, size);
    }

    public List<UserDailyWord> executeStudiedByUserId(Long userId, int page, int size) {
        return userDailyWordRepository.findStudiedByUserId(UserId.of(userId), page, size);
    }

    public List<UserDailyWord> executeCollectedByUserId(Long userId, int page, int size) {
        return userDailyWordRepository.findCollectedByUserId(UserId.of(userId), page, size);
    }

    public long countByUserId(Long userId) {
        return userDailyWordRepository.countByUserId(UserId.of(userId));
    }

    public long countStudiedByUserId(Long userId) {
        return userDailyWordRepository.countStudiedByUserId(UserId.of(userId));
    }
}
