package com.novacloudedu.backend.domain.dailylearning.entity;

import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.MasteryLevel;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserDailyWord {

    private Long id;
    private UserId userId;
    private DailyWordId wordId;
    private boolean studied;
    private boolean collected;
    private MasteryLevel masteryLevel;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static UserDailyWord create(UserId userId, DailyWordId wordId) {
        UserDailyWord userDailyWord = new UserDailyWord();
        userDailyWord.userId = userId;
        userDailyWord.wordId = wordId;
        userDailyWord.studied = false;
        userDailyWord.collected = false;
        userDailyWord.masteryLevel = MasteryLevel.UNKNOWN;
        userDailyWord.createTime = LocalDateTime.now();
        userDailyWord.updateTime = LocalDateTime.now();
        return userDailyWord;
    }

    public static UserDailyWord reconstruct(Long id, UserId userId, DailyWordId wordId,
                                            boolean studied, boolean collected, MasteryLevel masteryLevel,
                                            LocalDateTime createTime, LocalDateTime updateTime) {
        UserDailyWord userDailyWord = new UserDailyWord();
        userDailyWord.id = id;
        userDailyWord.userId = userId;
        userDailyWord.wordId = wordId;
        userDailyWord.studied = studied;
        userDailyWord.collected = collected;
        userDailyWord.masteryLevel = masteryLevel;
        userDailyWord.createTime = createTime;
        userDailyWord.updateTime = updateTime;
        return userDailyWord;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void markAsStudied() {
        this.studied = true;
        this.updateTime = LocalDateTime.now();
    }

    public void toggleCollect() {
        this.collected = !this.collected;
        this.updateTime = LocalDateTime.now();
    }

    public void updateMasteryLevel(MasteryLevel level) {
        this.masteryLevel = level;
        this.updateTime = LocalDateTime.now();
    }
}
