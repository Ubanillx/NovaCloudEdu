package com.novacloudedu.backend.interfaces.rest.recommendation.assembler;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.recommendation.entity.UserPreference;
import com.novacloudedu.backend.interfaces.rest.recommendation.dto.RecommendedArticleResponse;
import com.novacloudedu.backend.interfaces.rest.recommendation.dto.RecommendedWordResponse;
import com.novacloudedu.backend.interfaces.rest.recommendation.dto.UserPreferenceResponse;
import org.springframework.stereotype.Component;

@Component
public class RecommendationAssembler {

    public UserPreferenceResponse toUserPreferenceResponse(UserPreference preference) {
        return UserPreferenceResponse.builder()
                .id(preference.getId())
                .preferenceType(preference.getPreferenceType().getCode())
                .preferenceTypeDesc(preference.getPreferenceType().getDescription())
                .preferenceKey(preference.getPreferenceKey())
                .preferenceValue(preference.getPreferenceValue())
                .interactionCount(preference.getInteractionCount())
                .lastInteractionTime(preference.getLastInteractionTime())
                .build();
    }

    public RecommendedWordResponse toRecommendedWordResponse(DailyWord word, String recommendReason) {
        return RecommendedWordResponse.builder()
                .id(word.getId().value())
                .word(word.getWord())
                .pronunciation(word.getPronunciation())
                .audioUrl(word.getAudioUrl())
                .translation(word.getTranslation())
                .example(word.getExample())
                .exampleTranslation(word.getExampleTranslation())
                .difficulty(word.getDifficulty().getCode())
                .difficultyDesc(word.getDifficulty().getDescription())
                .category(word.getCategory())
                .publishDate(word.getPublishDate())
                .recommendReason(recommendReason)
                .build();
    }

    public RecommendedArticleResponse toRecommendedArticleResponse(DailyArticle article, String recommendReason) {
        return RecommendedArticleResponse.builder()
                .id(article.getId().value())
                .title(article.getTitle())
                .summary(article.getSummary())
                .coverImage(article.getCoverImage())
                .author(article.getAuthor())
                .category(article.getCategory())
                .tags(article.getTags())
                .difficulty(article.getDifficulty().getCode())
                .difficultyDesc(article.getDifficulty().getDescription())
                .readTime(article.getReadTime())
                .publishDate(article.getPublishDate())
                .viewCount(article.getViewCount())
                .likeCount(article.getLikeCount())
                .recommendReason(recommendReason)
                .build();
    }
}
