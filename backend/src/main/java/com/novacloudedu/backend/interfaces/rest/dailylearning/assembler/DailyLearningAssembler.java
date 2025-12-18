package com.novacloudedu.backend.interfaces.rest.dailylearning.assembler;

import com.novacloudedu.backend.domain.dailylearning.entity.*;
import com.novacloudedu.backend.interfaces.rest.dailylearning.dto.*;
import org.springframework.stereotype.Component;

@Component
public class DailyLearningAssembler {

    public DailyWordResponse toDailyWordResponse(DailyWord word) {
        return DailyWordResponse.builder()
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
                .notes(word.getNotes())
                .publishDate(word.getPublishDate())
                .createTime(word.getCreateTime())
                .updateTime(word.getUpdateTime())
                .build();
    }

    public DailyArticleResponse toDailyArticleResponse(DailyArticle article) {
        return DailyArticleResponse.builder()
                .id(article.getId().value())
                .title(article.getTitle())
                .content(article.getContent())
                .summary(article.getSummary())
                .coverImage(article.getCoverImage())
                .author(article.getAuthor())
                .source(article.getSource())
                .sourceUrl(article.getSourceUrl())
                .category(article.getCategory())
                .tags(article.getTags())
                .difficulty(article.getDifficulty().getCode())
                .difficultyDesc(article.getDifficulty().getDescription())
                .readTime(article.getReadTime())
                .publishDate(article.getPublishDate())
                .viewCount(article.getViewCount())
                .likeCount(article.getLikeCount())
                .collectCount(article.getCollectCount())
                .createTime(article.getCreateTime())
                .updateTime(article.getUpdateTime())
                .build();
    }

    public UserDailyWordResponse toUserDailyWordResponse(UserDailyWord userDailyWord) {
        return UserDailyWordResponse.builder()
                .id(userDailyWord.getId())
                .userId(userDailyWord.getUserId().value())
                .wordId(userDailyWord.getWordId().value())
                .studied(userDailyWord.isStudied())
                .collected(userDailyWord.isCollected())
                .masteryLevel(userDailyWord.getMasteryLevel().getCode())
                .masteryLevelDesc(userDailyWord.getMasteryLevel().getDescription())
                .createTime(userDailyWord.getCreateTime())
                .updateTime(userDailyWord.getUpdateTime())
                .build();
    }

    public UserDailyWordResponse toUserDailyWordResponse(UserDailyWord userDailyWord, DailyWord word) {
        UserDailyWordResponse response = toUserDailyWordResponse(userDailyWord);
        response.setWord(toDailyWordResponse(word));
        return response;
    }

    public UserDailyArticleResponse toUserDailyArticleResponse(UserDailyArticle userDailyArticle) {
        return UserDailyArticleResponse.builder()
                .id(userDailyArticle.getId())
                .userId(userDailyArticle.getUserId().value())
                .articleId(userDailyArticle.getArticleId().value())
                .read(userDailyArticle.isRead())
                .liked(userDailyArticle.isLiked())
                .collected(userDailyArticle.isCollected())
                .commentContent(userDailyArticle.getCommentContent())
                .commentTime(userDailyArticle.getCommentTime())
                .createTime(userDailyArticle.getCreateTime())
                .updateTime(userDailyArticle.getUpdateTime())
                .build();
    }

    public UserDailyArticleResponse toUserDailyArticleResponse(UserDailyArticle userDailyArticle, DailyArticle article) {
        UserDailyArticleResponse response = toUserDailyArticleResponse(userDailyArticle);
        response.setArticle(toDailyArticleResponse(article));
        return response;
    }

    public UserWordBookResponse toUserWordBookResponse(UserWordBook wordBook) {
        return UserWordBookResponse.builder()
                .id(wordBook.getId())
                .userId(wordBook.getUserId().value())
                .wordId(wordBook.getWordId().value())
                .learningStatus(wordBook.getLearningStatus().getCode())
                .learningStatusDesc(wordBook.getLearningStatus().getDescription())
                .collectedTime(wordBook.getCollectedTime())
                .createTime(wordBook.getCreateTime())
                .updateTime(wordBook.getUpdateTime())
                .build();
    }

    public UserWordBookResponse toUserWordBookResponse(UserWordBook wordBook, DailyWord word) {
        UserWordBookResponse response = toUserWordBookResponse(wordBook);
        response.setWord(toDailyWordResponse(word));
        return response;
    }
}
