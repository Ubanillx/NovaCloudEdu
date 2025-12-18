package com.novacloudedu.backend.domain.dailylearning.entity;

import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.LearningStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserWordBook {

    private Long id;
    private UserId userId;
    private DailyWordId wordId;
    private LearningStatus learningStatus;
    private LocalDateTime collectedTime;
    private boolean deleted;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static UserWordBook create(UserId userId, DailyWordId wordId) {
        UserWordBook wordBook = new UserWordBook();
        wordBook.userId = userId;
        wordBook.wordId = wordId;
        wordBook.learningStatus = LearningStatus.NOT_LEARNED;
        wordBook.collectedTime = LocalDateTime.now();
        wordBook.deleted = false;
        wordBook.createTime = LocalDateTime.now();
        wordBook.updateTime = LocalDateTime.now();
        return wordBook;
    }

    public static UserWordBook reconstruct(Long id, UserId userId, DailyWordId wordId,
                                           LearningStatus learningStatus, LocalDateTime collectedTime,
                                           boolean deleted, LocalDateTime createTime, LocalDateTime updateTime) {
        UserWordBook wordBook = new UserWordBook();
        wordBook.id = id;
        wordBook.userId = userId;
        wordBook.wordId = wordId;
        wordBook.learningStatus = learningStatus;
        wordBook.collectedTime = collectedTime;
        wordBook.deleted = deleted;
        wordBook.createTime = createTime;
        wordBook.updateTime = updateTime;
        return wordBook;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateLearningStatus(LearningStatus status) {
        this.learningStatus = status;
        this.updateTime = LocalDateTime.now();
    }

    public void markAsDeleted() {
        this.deleted = true;
        this.updateTime = LocalDateTime.now();
    }

    public void restore() {
        this.deleted = false;
        this.collectedTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }
}
