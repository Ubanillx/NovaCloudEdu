package com.novacloudedu.backend.application.recommendation.service;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.infrastructure.neo4j.node.ArticleNode;
import com.novacloudedu.backend.infrastructure.neo4j.node.WordNode;
import com.novacloudedu.backend.infrastructure.neo4j.repository.ArticleNodeRepository;
import com.novacloudedu.backend.infrastructure.neo4j.repository.WordNodeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgeGraphRecommendationService {

    private final WordNodeRepository wordNodeRepository;
    private final ArticleNodeRepository articleNodeRepository;
    private final DailyWordRepository dailyWordRepository;
    private final DailyArticleRepository dailyArticleRepository;

    private static final int DEFAULT_LIMIT = 10;

    public List<DailyWord> recommendWords(Long userId, int size) {
        int limit = size > 0 ? size : DEFAULT_LIMIT;
        Set<Long> recommendedIds = new LinkedHashSet<>();

        try {
            List<WordNode> collaborativeWords = wordNodeRepository.recommendWordsByCollaborativeFiltering(userId, limit);
            collaborativeWords.forEach(w -> recommendedIds.add(w.getId()));

            if (recommendedIds.size() < limit) {
                List<WordNode> categoryWords = wordNodeRepository.recommendWordsBySameCategory(userId, limit);
                categoryWords.forEach(w -> recommendedIds.add(w.getId()));
            }

            if (recommendedIds.size() < limit) {
                List<WordNode> difficultyWords = wordNodeRepository.recommendWordsBySameDifficulty(userId, limit);
                difficultyWords.forEach(w -> recommendedIds.add(w.getId()));
            }

            if (recommendedIds.size() < limit) {
                List<WordNode> unstudiedWords = wordNodeRepository.findUnstudiedWords(userId, limit);
                unstudiedWords.forEach(w -> recommendedIds.add(w.getId()));
            }
        } catch (Exception e) {
            log.warn("Neo4j查询失败，使用默认推荐: {}", e.getMessage());
            return getDefaultWords(limit);
        }

        return recommendedIds.stream()
                .limit(limit)
                .map(id -> dailyWordRepository.findById(DailyWordId.of(id)).orElse(null))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    public List<DailyArticle> recommendArticles(Long userId, int size) {
        int limit = size > 0 ? size : DEFAULT_LIMIT;
        Set<Long> recommendedIds = new LinkedHashSet<>();

        try {
            List<ArticleNode> collaborativeArticles = articleNodeRepository.recommendArticlesByCollaborativeFiltering(userId, limit);
            collaborativeArticles.forEach(a -> recommendedIds.add(a.getId()));

            if (recommendedIds.size() < limit) {
                List<ArticleNode> categoryArticles = articleNodeRepository.recommendArticlesBySameCategory(userId, limit);
                categoryArticles.forEach(a -> recommendedIds.add(a.getId()));
            }

            if (recommendedIds.size() < limit) {
                List<ArticleNode> tagArticles = articleNodeRepository.recommendArticlesBySameTag(userId, limit);
                tagArticles.forEach(a -> recommendedIds.add(a.getId()));
            }

            if (recommendedIds.size() < limit) {
                List<ArticleNode> likedArticles = articleNodeRepository.recommendArticlesByLikedUsers(userId, limit);
                likedArticles.forEach(a -> recommendedIds.add(a.getId()));
            }

            if (recommendedIds.size() < limit) {
                List<ArticleNode> popularArticles = articleNodeRepository.findPopularUnreadArticles(userId, limit);
                popularArticles.forEach(a -> recommendedIds.add(a.getId()));
            }
        } catch (Exception e) {
            log.warn("Neo4j查询失败，使用默认推荐: {}", e.getMessage());
            return getDefaultArticles(limit);
        }

        return recommendedIds.stream()
                .limit(limit)
                .map(id -> dailyArticleRepository.findById(DailyArticleId.of(id)).orElse(null))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    private List<DailyWord> getDefaultWords(int limit) {
        return dailyWordRepository.findAll(1, limit);
    }

    private List<DailyArticle> getDefaultArticles(int limit) {
        return dailyArticleRepository.findAll(1, limit);
    }
}
