package com.novacloudedu.backend.domain.dailylearning.repository;

import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserDailyArticleRepository {

    UserDailyArticle save(UserDailyArticle userDailyArticle);

    Optional<UserDailyArticle> findById(Long id);

    Optional<UserDailyArticle> findByUserIdAndArticleId(UserId userId, DailyArticleId articleId);

    List<UserDailyArticle> findByUserId(UserId userId, int page, int size);

    List<UserDailyArticle> findReadByUserId(UserId userId, int page, int size);

    List<UserDailyArticle> findLikedByUserId(UserId userId, int page, int size);

    List<UserDailyArticle> findCollectedByUserId(UserId userId, int page, int size);

    long countByUserId(UserId userId);

    long countReadByUserId(UserId userId);
}
