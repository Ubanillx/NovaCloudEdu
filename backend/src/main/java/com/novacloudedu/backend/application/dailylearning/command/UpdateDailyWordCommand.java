package com.novacloudedu.backend.application.dailylearning.command;

import java.time.LocalDate;

/**
 * 更新每日单词命令
 */
public record UpdateDailyWordCommand(
        Long wordId,
        String word,
        String pronunciationUs,
        String pronunciationUk,
        String audioUrlUs,
        String audioUrlUk,
        String translation,
        String example,
        String exampleTranslation,
        Integer difficulty,
        String category,
        String notes,
        LocalDate publishDate
) {}
