package com.novacloudedu.backend.application.recommendation.service;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.recommendation.entity.RecommendationHistory;
import com.novacloudedu.backend.domain.recommendation.entity.UserPreference;
import com.novacloudedu.backend.domain.recommendation.repository.RecommendationHistoryRepository;
import com.novacloudedu.backend.domain.recommendation.repository.UserPreferenceRepository;
import com.novacloudedu.backend.domain.recommendation.valueobject.PreferenceType;
import com.novacloudedu.backend.domain.recommendation.valueobject.TargetType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class RecommendationService {

    private final UserPreferenceRepository userPreferenceRepository;
    private final RecommendationHistoryRepository recommendationHistoryRepository;
    private final DailyWordRepository dailyWordRepository;
    private final DailyArticleRepository dailyArticleRepository;

    private static final int DEFAULT_RECOMMENDATION_SIZE = 10;
    private static final int RECENT_RECOMMENDATION_DAYS = 7;

    @Transactional(readOnly = true)
    public List<DailyWord> recommendWords(Long userId, int size) {
        UserId userIdObj = UserId.of(userId);
        int recommendSize = size > 0 ? size : DEFAULT_RECOMMENDATION_SIZE;

        List<Long> recentRecommendedIds = getRecentRecommendedIds(userIdObj, TargetType.WORD);

        List<UserPreference> categoryPrefs = userPreferenceRepository
                .findTopByUserIdAndType(userIdObj, PreferenceType.WORD_CATEGORY, 3);
        List<UserPreference> difficultyPrefs = userPreferenceRepository
                .findTopByUserIdAndType(userIdObj, PreferenceType.WORD_DIFFICULTY, 3);

        List<DailyWord> recommendedWords = new ArrayList<>();

        if (!categoryPrefs.isEmpty()) {
            for (UserPreference pref : categoryPrefs) {
                List<DailyWord> words = dailyWordRepository.findByCategory(pref.getPreferenceKey(), 1, recommendSize);
                for (DailyWord word : words) {
                    if (!recentRecommendedIds.contains(word.getId().value()) && 
                        recommendedWords.stream().noneMatch(w -> w.getId().value().equals(word.getId().value()))) {
                        recommendedWords.add(word);
                    }
                }
            }
        }

        if (!difficultyPrefs.isEmpty() && recommendedWords.size() < recommendSize) {
            for (UserPreference pref : difficultyPrefs) {
                try {
                    int difficultyCode = Integer.parseInt(pref.getPreferenceKey());
                    List<DailyWord> words = dailyWordRepository.findByDifficulty(
                            Difficulty.fromCode(difficultyCode), 1, recommendSize);
                    for (DailyWord word : words) {
                        if (!recentRecommendedIds.contains(word.getId().value()) &&
                            recommendedWords.stream().noneMatch(w -> w.getId().value().equals(word.getId().value()))) {
                            recommendedWords.add(word);
                        }
                    }
                } catch (NumberFormatException e) {
                    log.warn("Invalid difficulty preference key: {}", pref.getPreferenceKey());
                }
            }
        }

        if (recommendedWords.size() < recommendSize) {
            List<DailyWord> defaultWords = dailyWordRepository.findAll(1, recommendSize * 2);
            for (DailyWord word : defaultWords) {
                if (!recentRecommendedIds.contains(word.getId().value()) &&
                    recommendedWords.stream().noneMatch(w -> w.getId().value().equals(word.getId().value()))) {
                    recommendedWords.add(word);
                    if (recommendedWords.size() >= recommendSize) break;
                }
            }
        }

        List<DailyWord> finalRecommendations = recommendedWords.stream()
                .limit(recommendSize)
                .collect(Collectors.toList());

        saveRecommendationHistory(userIdObj, TargetType.WORD, finalRecommendations.stream()
                .map(w -> new RecommendationItem(w.getId().value(), calculateWordScore(w, categoryPrefs, difficultyPrefs), "基于您的学习偏好"))
                .collect(Collectors.toList()));

        return finalRecommendations;
    }

    @Transactional(readOnly = true)
    public List<DailyArticle> recommendArticles(Long userId, int size) {
        UserId userIdObj = UserId.of(userId);
        int recommendSize = size > 0 ? size : DEFAULT_RECOMMENDATION_SIZE;

        List<Long> recentRecommendedIds = getRecentRecommendedIds(userIdObj, TargetType.ARTICLE);

        List<UserPreference> categoryPrefs = userPreferenceRepository
                .findTopByUserIdAndType(userIdObj, PreferenceType.ARTICLE_CATEGORY, 3);
        List<UserPreference> difficultyPrefs = userPreferenceRepository
                .findTopByUserIdAndType(userIdObj, PreferenceType.ARTICLE_DIFFICULTY, 3);
        List<UserPreference> tagPrefs = userPreferenceRepository
                .findTopByUserIdAndType(userIdObj, PreferenceType.ARTICLE_TAG, 5);

        List<DailyArticle> recommendedArticles = new ArrayList<>();

        if (!categoryPrefs.isEmpty()) {
            for (UserPreference pref : categoryPrefs) {
                List<DailyArticle> articles = dailyArticleRepository.findByCategory(pref.getPreferenceKey(), 1, recommendSize);
                for (DailyArticle article : articles) {
                    if (!recentRecommendedIds.contains(article.getId().value()) &&
                        recommendedArticles.stream().noneMatch(a -> a.getId().value().equals(article.getId().value()))) {
                        recommendedArticles.add(article);
                    }
                }
            }
        }

        if (!difficultyPrefs.isEmpty() && recommendedArticles.size() < recommendSize) {
            for (UserPreference pref : difficultyPrefs) {
                try {
                    int difficultyCode = Integer.parseInt(pref.getPreferenceKey());
                    List<DailyArticle> articles = dailyArticleRepository.findByDifficulty(
                            Difficulty.fromCode(difficultyCode), 1, recommendSize);
                    for (DailyArticle article : articles) {
                        if (!recentRecommendedIds.contains(article.getId().value()) &&
                            recommendedArticles.stream().noneMatch(a -> a.getId().value().equals(article.getId().value()))) {
                            recommendedArticles.add(article);
                        }
                    }
                } catch (NumberFormatException e) {
                    log.warn("Invalid difficulty preference key: {}", pref.getPreferenceKey());
                }
            }
        }

        if (recommendedArticles.size() < recommendSize) {
            List<DailyArticle> defaultArticles = dailyArticleRepository.findAll(1, recommendSize * 2);
            for (DailyArticle article : defaultArticles) {
                if (!recentRecommendedIds.contains(article.getId().value()) &&
                    recommendedArticles.stream().noneMatch(a -> a.getId().value().equals(article.getId().value()))) {
                    recommendedArticles.add(article);
                    if (recommendedArticles.size() >= recommendSize) break;
                }
            }
        }

        List<DailyArticle> finalRecommendations = recommendedArticles.stream()
                .limit(recommendSize)
                .collect(Collectors.toList());

        saveRecommendationHistory(userIdObj, TargetType.ARTICLE, finalRecommendations.stream()
                .map(a -> new RecommendationItem(a.getId().value(), calculateArticleScore(a, categoryPrefs, difficultyPrefs, tagPrefs), "基于您的阅读偏好"))
                .collect(Collectors.toList()));

        return finalRecommendations;
    }

    private List<Long> getRecentRecommendedIds(UserId userId, TargetType targetType) {
        LocalDateTime afterTime = LocalDateTime.now().minusDays(RECENT_RECOMMENDATION_DAYS);
        return recommendationHistoryRepository.findRecommendedTargetIds(userId, targetType, afterTime);
    }

    private BigDecimal calculateWordScore(DailyWord word, List<UserPreference> categoryPrefs, List<UserPreference> difficultyPrefs) {
        double score = 50.0;

        for (UserPreference pref : categoryPrefs) {
            if (word.getCategory() != null && word.getCategory().equals(pref.getPreferenceKey())) {
                score += pref.getPreferenceValue().doubleValue() * 0.3;
            }
        }

        for (UserPreference pref : difficultyPrefs) {
            if (String.valueOf(word.getDifficulty().getCode()).equals(pref.getPreferenceKey())) {
                score += pref.getPreferenceValue().doubleValue() * 0.2;
            }
        }

        return BigDecimal.valueOf(Math.min(100.0, score));
    }

    private BigDecimal calculateArticleScore(DailyArticle article, List<UserPreference> categoryPrefs,
                                             List<UserPreference> difficultyPrefs, List<UserPreference> tagPrefs) {
        double score = 50.0;

        for (UserPreference pref : categoryPrefs) {
            if (article.getCategory() != null && article.getCategory().equals(pref.getPreferenceKey())) {
                score += pref.getPreferenceValue().doubleValue() * 0.3;
            }
        }

        for (UserPreference pref : difficultyPrefs) {
            if (String.valueOf(article.getDifficulty().getCode()).equals(pref.getPreferenceKey())) {
                score += pref.getPreferenceValue().doubleValue() * 0.2;
            }
        }

        if (article.getTags() != null) {
            for (UserPreference pref : tagPrefs) {
                if (article.getTags().contains(pref.getPreferenceKey())) {
                    score += pref.getPreferenceValue().doubleValue() * 0.1;
                }
            }
        }

        return BigDecimal.valueOf(Math.min(100.0, score));
    }

    @Transactional
    public void saveRecommendationHistory(UserId userId, TargetType targetType, List<RecommendationItem> items) {
        for (RecommendationItem item : items) {
            RecommendationHistory history = RecommendationHistory.create(
                    userId, targetType, item.targetId(), item.score(), item.reason());
            recommendationHistoryRepository.save(history);
        }
    }

    @Transactional
    public void markRecommendationClicked(Long userId, TargetType targetType, Long targetId) {
        recommendationHistoryRepository.findByUserIdAndTarget(UserId.of(userId), targetType, targetId)
                .ifPresent(history -> {
                    history.markAsClicked();
                    recommendationHistoryRepository.save(history);
                });
    }

    @Transactional
    public void markRecommendationInteracted(Long userId, TargetType targetType, Long targetId) {
        recommendationHistoryRepository.findByUserIdAndTarget(UserId.of(userId), targetType, targetId)
                .ifPresent(history -> {
                    history.markAsInteracted();
                    recommendationHistoryRepository.save(history);
                });
    }

    private record RecommendationItem(Long targetId, BigDecimal score, String reason) {}
}
