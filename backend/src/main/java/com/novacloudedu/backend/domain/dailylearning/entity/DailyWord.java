package com.novacloudedu.backend.domain.dailylearning.entity;

import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DailyWord {

    private DailyWordId id;
    private String word;
    private String pronunciation;
    private String audioUrl;
    private String translation;
    private String example;
    private String exampleTranslation;
    private Difficulty difficulty;
    private String category;
    private String notes;
    private LocalDate publishDate;
    private UserId adminId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static DailyWord create(String word, String pronunciation, String audioUrl,
                                   String translation, String example, String exampleTranslation,
                                   Difficulty difficulty, String category, String notes,
                                   LocalDate publishDate, UserId adminId) {
        DailyWord dailyWord = new DailyWord();
        dailyWord.word = word;
        dailyWord.pronunciation = pronunciation;
        dailyWord.audioUrl = audioUrl;
        dailyWord.translation = translation;
        dailyWord.example = example;
        dailyWord.exampleTranslation = exampleTranslation;
        dailyWord.difficulty = difficulty;
        dailyWord.category = category;
        dailyWord.notes = notes;
        dailyWord.publishDate = publishDate;
        dailyWord.adminId = adminId;
        dailyWord.createTime = LocalDateTime.now();
        dailyWord.updateTime = LocalDateTime.now();
        return dailyWord;
    }

    public static DailyWord reconstruct(DailyWordId id, String word, String pronunciation, String audioUrl,
                                        String translation, String example, String exampleTranslation,
                                        Difficulty difficulty, String category, String notes,
                                        LocalDate publishDate, UserId adminId,
                                        LocalDateTime createTime, LocalDateTime updateTime) {
        DailyWord dailyWord = new DailyWord();
        dailyWord.id = id;
        dailyWord.word = word;
        dailyWord.pronunciation = pronunciation;
        dailyWord.audioUrl = audioUrl;
        dailyWord.translation = translation;
        dailyWord.example = example;
        dailyWord.exampleTranslation = exampleTranslation;
        dailyWord.difficulty = difficulty;
        dailyWord.category = category;
        dailyWord.notes = notes;
        dailyWord.publishDate = publishDate;
        dailyWord.adminId = adminId;
        dailyWord.createTime = createTime;
        dailyWord.updateTime = updateTime;
        return dailyWord;
    }

    public void assignId(DailyWordId id) {
        if (this.id != null) {
            throw new IllegalStateException("每日单词ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateInfo(String word, String pronunciation, String audioUrl,
                          String translation, String example, String exampleTranslation,
                          Difficulty difficulty, String category, String notes,
                          LocalDate publishDate) {
        this.word = word;
        this.pronunciation = pronunciation;
        this.audioUrl = audioUrl;
        this.translation = translation;
        this.example = example;
        this.exampleTranslation = exampleTranslation;
        this.difficulty = difficulty;
        this.category = category;
        this.notes = notes;
        this.publishDate = publishDate;
        this.updateTime = LocalDateTime.now();
    }
}
