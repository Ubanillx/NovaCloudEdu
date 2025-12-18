package com.novacloudedu.backend.domain.dailylearning.repository;

import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserDailyWordRepository {

    UserDailyWord save(UserDailyWord userDailyWord);

    Optional<UserDailyWord> findById(Long id);

    Optional<UserDailyWord> findByUserIdAndWordId(UserId userId, DailyWordId wordId);

    List<UserDailyWord> findByUserId(UserId userId, int page, int size);

    List<UserDailyWord> findStudiedByUserId(UserId userId, int page, int size);

    List<UserDailyWord> findCollectedByUserId(UserId userId, int page, int size);

    long countByUserId(UserId userId);

    long countStudiedByUserId(UserId userId);
}
