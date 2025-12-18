package com.novacloudedu.backend.application.recommendation.service;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.recommendation.entity.UserBehaviorLog;
import com.novacloudedu.backend.domain.recommendation.entity.UserPreference;
import com.novacloudedu.backend.domain.recommendation.repository.UserBehaviorLogRepository;
import com.novacloudedu.backend.domain.recommendation.repository.UserPreferenceRepository;
import com.novacloudedu.backend.domain.recommendation.valueobject.BehaviorType;
import com.novacloudedu.backend.domain.recommendation.valueobject.PreferenceType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class PreferenceAnalysisService {

    private final UserPreferenceRepository userPreferenceRepository;
    private final UserBehaviorLogRepository userBehaviorLogRepository;
    private final DailyWordRepository dailyWordRepository;
    private final DailyArticleRepository dailyArticleRepository;

    @Transactional
    public void recordBehavior(Long userId, BehaviorType behaviorType, TargetType targetType,
                               Long targetId, String behaviorData, Integer duration) {
        UserId userIdObj = UserId.of(userId);

        UserBehaviorLog log = UserBehaviorLog.create(userIdObj, behaviorType, targetType, targetId, behaviorData, duration);
        userBehaviorLogRepository.save(log);

        updatePreferencesFromBehavior(userIdObj, behaviorType, targetType, targetId);
    }

    @Transactional
    public void updatePreferencesFromBehavior(UserId userId, BehaviorType behaviorType,
                                              TargetType targetType, Long targetId) {
        double behaviorWeight = behaviorType.getWeight();

        if (targetType == TargetType.WORD) {
            updateWordPreferences(userId, targetId, behaviorWeight);
        } else if (targetType == TargetType.ARTICLE) {
            updateArticlePreferences(userId, targetId, behaviorWeight);
        }
    }

    private void updateWordPreferences(UserId userId, Long wordId, double behaviorWeight) {
        Optional<DailyWord> wordOpt = dailyWordRepository.findById(DailyWordId.of(wordId));
        if (wordOpt.isEmpty()) {
            return;
        }

        DailyWord word = wordOpt.get();

        if (word.getCategory() != null && !word.getCategory().isEmpty()) {
            updateOrCreatePreference(userId, PreferenceType.WORD_CATEGORY, word.getCategory(), behaviorWeight);
        }

        String difficultyKey = String.valueOf(word.getDifficulty().getCode());
        updateOrCreatePreference(userId, PreferenceType.WORD_DIFFICULTY, difficultyKey, behaviorWeight);
    }

    private void updateArticlePreferences(UserId userId, Long articleId, double behaviorWeight) {
        Optional<DailyArticle> articleOpt = dailyArticleRepository.findById(DailyArticleId.of(articleId));
        if (articleOpt.isEmpty()) {
            return;
        }

        DailyArticle article = articleOpt.get();

        if (article.getCategory() != null && !article.getCategory().isEmpty()) {
            updateOrCreatePreference(userId, PreferenceType.ARTICLE_CATEGORY, article.getCategory(), behaviorWeight);
        }

        String difficultyKey = String.valueOf(article.getDifficulty().getCode());
        updateOrCreatePreference(userId, PreferenceType.ARTICLE_DIFFICULTY, difficultyKey, behaviorWeight);

        List<String> tags = article.getTags();
        if (tags != null && !tags.isEmpty()) {
            for (String tag : tags) {
                updateOrCreatePreference(userId, PreferenceType.ARTICLE_TAG, tag, behaviorWeight * 0.5);
            }
        }
    }

    private void updateOrCreatePreference(UserId userId, PreferenceType type, String key, double behaviorWeight) {
        UserPreference preference = userPreferenceRepository
                .findByUserIdAndTypeAndKey(userId, type, key)
                .orElseGet(() -> UserPreference.create(userId, type, key));

        preference.incrementInteraction(behaviorWeight);
        userPreferenceRepository.save(preference);
    }

    public List<UserPreference> getUserPreferences(Long userId) {
        return userPreferenceRepository.findByUserId(UserId.of(userId));
    }

    public List<UserPreference> getUserPreferencesByType(Long userId, PreferenceType type) {
        return userPreferenceRepository.findByUserIdAndType(UserId.of(userId), type);
    }

    public List<UserPreference> getTopPreferences(Long userId, PreferenceType type, int limit) {
        return userPreferenceRepository.findTopByUserIdAndType(UserId.of(userId), type, limit);
    }
}
