package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CreateDailyArticleCommand {

    private final DailyArticleRepository dailyArticleRepository;

    @Transactional
    public Long execute(String title, String content, String summary, String coverImage,
                       String author, String source, String sourceUrl, String category,
                       List<String> tags, Integer difficulty, Integer readTime,
                       LocalDate publishDate, Long adminId) {
        
        DailyArticle article = DailyArticle.create(
                title, content, summary, coverImage, author, source, sourceUrl, category,
                tags, Difficulty.fromCode(difficulty), readTime, publishDate, UserId.of(adminId)
        );

        dailyArticleRepository.save(article);
        return article.getId().value();
    }
}
