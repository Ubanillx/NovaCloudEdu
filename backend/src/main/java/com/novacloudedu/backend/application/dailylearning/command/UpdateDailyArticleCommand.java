package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UpdateDailyArticleCommand {

    private final DailyArticleRepository dailyArticleRepository;

    @Transactional
    public void execute(Long id, String title, String content, String summary, String coverImage,
                       String author, String source, String sourceUrl, String category,
                       List<String> tags, Integer difficulty, Integer readTime, LocalDate publishDate) {
        
        DailyArticle article = dailyArticleRepository.findById(DailyArticleId.of(id))
                .orElseThrow(() -> new BusinessException(40400, "每日文章不存在"));

        article.updateInfo(title, content, summary, coverImage, author, source, sourceUrl,
                category, tags, Difficulty.fromCode(difficulty), readTime, publishDate);

        dailyArticleRepository.save(article);
    }
}
