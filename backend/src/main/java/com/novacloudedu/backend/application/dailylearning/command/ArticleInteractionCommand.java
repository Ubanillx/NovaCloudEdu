package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ArticleInteractionCommand {

    private final DailyArticleRepository dailyArticleRepository;
    private final UserDailyArticleRepository userDailyArticleRepository;

    @Transactional
    public void markAsRead(Long userId, Long articleId) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        DailyArticle article = dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        if (!userDailyArticle.isRead()) {
            userDailyArticle.markAsRead();
            article.incrementViewCount();
            dailyArticleRepository.save(article);
        }
        userDailyArticleRepository.save(userDailyArticle);
    }

    @Transactional
    public void toggleLike(Long userId, Long articleId) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        DailyArticle article = dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        boolean wasLiked = userDailyArticle.isLiked();
        userDailyArticle.toggleLike();
        
        if (wasLiked) {
            article.decrementLikeCount();
        } else {
            article.incrementLikeCount();
        }
        
        dailyArticleRepository.save(article);
        userDailyArticleRepository.save(userDailyArticle);
    }

    @Transactional
    public void toggleCollect(Long userId, Long articleId) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        DailyArticle article = dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        boolean wasCollected = userDailyArticle.isCollected();
        userDailyArticle.toggleCollect();
        
        if (wasCollected) {
            article.decrementCollectCount();
        } else {
            article.incrementCollectCount();
        }
        
        dailyArticleRepository.save(article);
        userDailyArticleRepository.save(userDailyArticle);
    }

    @Transactional
    public void addComment(Long userId, Long articleId, String content) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        userDailyArticle.addComment(content);
        userDailyArticleRepository.save(userDailyArticle);
    }
}
