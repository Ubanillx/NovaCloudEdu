package com.novacloudedu.backend.application.dailylearning.query;

import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetUserDailyArticleQuery {

    private final UserDailyArticleRepository userDailyArticleRepository;

    public Optional<UserDailyArticle> executeByUserIdAndArticleId(Long userId, Long articleId) {
        return userDailyArticleRepository.findByUserIdAndArticleId(UserId.of(userId), DailyArticleId.of(articleId));
    }

    public List<UserDailyArticle> executeByUserId(Long userId, int page, int size) {
        return userDailyArticleRepository.findByUserId(UserId.of(userId), page, size);
    }

    public List<UserDailyArticle> executeReadByUserId(Long userId, int page, int size) {
        return userDailyArticleRepository.findReadByUserId(UserId.of(userId), page, size);
    }

    public List<UserDailyArticle> executeLikedByUserId(Long userId, int page, int size) {
        return userDailyArticleRepository.findLikedByUserId(UserId.of(userId), page, size);
    }

    public List<UserDailyArticle> executeCollectedByUserId(Long userId, int page, int size) {
        return userDailyArticleRepository.findCollectedByUserId(UserId.of(userId), page, size);
    }

    public long countByUserId(Long userId) {
        return userDailyArticleRepository.countByUserId(UserId.of(userId));
    }

    public long countReadByUserId(Long userId) {
        return userDailyArticleRepository.countReadByUserId(UserId.of(userId));
    }
}
