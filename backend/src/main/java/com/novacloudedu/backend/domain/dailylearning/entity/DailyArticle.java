package com.novacloudedu.backend.domain.dailylearning.entity;

import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DailyArticle {

    private DailyArticleId id;
    private String title;
    private String content;
    private String summary;
    private String coverImage;
    private String author;
    private String source;
    private String sourceUrl;
    private String category;
    private List<String> tags;
    private Difficulty difficulty;
    private Integer readTime;
    private LocalDate publishDate;
    private UserId adminId;
    private Integer viewCount;
    private Integer likeCount;
    private Integer collectCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static DailyArticle create(String title, String content, String summary, String coverImage,
                                      String author, String source, String sourceUrl, String category,
                                      List<String> tags, Difficulty difficulty, Integer readTime,
                                      LocalDate publishDate, UserId adminId) {
        DailyArticle article = new DailyArticle();
        article.title = title;
        article.content = content;
        article.summary = summary;
        article.coverImage = coverImage;
        article.author = author;
        article.source = source;
        article.sourceUrl = sourceUrl;
        article.category = category;
        article.tags = tags;
        article.difficulty = difficulty;
        article.readTime = readTime != null ? readTime : 0;
        article.publishDate = publishDate;
        article.adminId = adminId;
        article.viewCount = 0;
        article.likeCount = 0;
        article.collectCount = 0;
        article.createTime = LocalDateTime.now();
        article.updateTime = LocalDateTime.now();
        return article;
    }

    public static DailyArticle reconstruct(DailyArticleId id, String title, String content, String summary,
                                           String coverImage, String author, String source, String sourceUrl,
                                           String category, List<String> tags, Difficulty difficulty,
                                           Integer readTime, LocalDate publishDate, UserId adminId,
                                           Integer viewCount, Integer likeCount, Integer collectCount,
                                           LocalDateTime createTime, LocalDateTime updateTime) {
        DailyArticle article = new DailyArticle();
        article.id = id;
        article.title = title;
        article.content = content;
        article.summary = summary;
        article.coverImage = coverImage;
        article.author = author;
        article.source = source;
        article.sourceUrl = sourceUrl;
        article.category = category;
        article.tags = tags;
        article.difficulty = difficulty;
        article.readTime = readTime;
        article.publishDate = publishDate;
        article.adminId = adminId;
        article.viewCount = viewCount;
        article.likeCount = likeCount;
        article.collectCount = collectCount;
        article.createTime = createTime;
        article.updateTime = updateTime;
        return article;
    }

    public void assignId(DailyArticleId id) {
        if (this.id != null) {
            throw new IllegalStateException("每日文章ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateInfo(String title, String content, String summary, String coverImage,
                          String author, String source, String sourceUrl, String category,
                          List<String> tags, Difficulty difficulty, Integer readTime,
                          LocalDate publishDate) {
        this.title = title;
        this.content = content;
        this.summary = summary;
        this.coverImage = coverImage;
        this.author = author;
        this.source = source;
        this.sourceUrl = sourceUrl;
        this.category = category;
        this.tags = tags;
        this.difficulty = difficulty;
        this.readTime = readTime;
        this.publishDate = publishDate;
        this.updateTime = LocalDateTime.now();
    }

    public void incrementViewCount() {
        this.viewCount++;
        this.updateTime = LocalDateTime.now();
    }

    public void incrementLikeCount() {
        this.likeCount++;
        this.updateTime = LocalDateTime.now();
    }

    public void decrementLikeCount() {
        if (this.likeCount > 0) {
            this.likeCount--;
            this.updateTime = LocalDateTime.now();
        }
    }

    public void incrementCollectCount() {
        this.collectCount++;
        this.updateTime = LocalDateTime.now();
    }

    public void decrementCollectCount() {
        if (this.collectCount > 0) {
            this.collectCount--;
            this.updateTime = LocalDateTime.now();
        }
    }
}
