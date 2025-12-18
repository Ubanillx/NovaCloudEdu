package com.novacloudedu.backend.domain.dailylearning.repository;

import com.novacloudedu.backend.domain.dailylearning.entity.UserWordBook;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.LearningStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserWordBookRepository {

    UserWordBook save(UserWordBook userWordBook);

    Optional<UserWordBook> findById(Long id);

    Optional<UserWordBook> findByUserIdAndWordId(UserId userId, DailyWordId wordId);

    List<UserWordBook> findByUserId(UserId userId, int page, int size);

    List<UserWordBook> findByUserIdAndStatus(UserId userId, LearningStatus status, int page, int size);

    long countByUserId(UserId userId);

    long countByUserIdAndStatus(UserId userId, LearningStatus status);

    void deleteById(Long id);
}
