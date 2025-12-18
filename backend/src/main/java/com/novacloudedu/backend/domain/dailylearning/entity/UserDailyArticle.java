package com.novacloudedu.backend.domain.dailylearning.entity;

import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserDailyArticle {

    private Long id;
    private UserId userId;
    private DailyArticleId articleId;
    private boolean read;
    private boolean liked;
    private boolean collected;
    private String commentContent;
    private LocalDateTime commentTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static UserDailyArticle create(UserId userId, DailyArticleId articleId) {
        UserDailyArticle userDailyArticle = new UserDailyArticle();
        userDailyArticle.userId = userId;
        userDailyArticle.articleId = articleId;
        userDailyArticle.read = false;
        userDailyArticle.liked = false;
        userDailyArticle.collected = false;
        userDailyArticle.createTime = LocalDateTime.now();
        userDailyArticle.updateTime = LocalDateTime.now();
        return userDailyArticle;
    }

    public static UserDailyArticle reconstruct(Long id, UserId userId, DailyArticleId articleId,
                                               boolean read, boolean liked, boolean collected,
                                               String commentContent, LocalDateTime commentTime,
                                               LocalDateTime createTime, LocalDateTime updateTime) {
        UserDailyArticle userDailyArticle = new UserDailyArticle();
        userDailyArticle.id = id;
        userDailyArticle.userId = userId;
        userDailyArticle.articleId = articleId;
        userDailyArticle.read = read;
        userDailyArticle.liked = liked;
        userDailyArticle.collected = collected;
        userDailyArticle.commentContent = commentContent;
        userDailyArticle.commentTime = commentTime;
        userDailyArticle.createTime = createTime;
        userDailyArticle.updateTime = updateTime;
        return userDailyArticle;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void markAsRead() {
        this.read = true;
        this.updateTime = LocalDateTime.now();
    }

    public void toggleLike() {
        this.liked = !this.liked;
        this.updateTime = LocalDateTime.now();
    }

    public void toggleCollect() {
        this.collected = !this.collected;
        this.updateTime = LocalDateTime.now();
    }

    public void addComment(String content) {
        this.commentContent = content;
        this.commentTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }
}
