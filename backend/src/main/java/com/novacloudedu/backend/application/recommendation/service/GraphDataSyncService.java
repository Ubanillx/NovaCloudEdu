package com.novacloudedu.backend.application.recommendation.service;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.infrastructure.neo4j.node.*;
import com.novacloudedu.backend.infrastructure.neo4j.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class GraphDataSyncService {

    private final DailyWordRepository dailyWordRepository;
    private final DailyArticleRepository dailyArticleRepository;
    private final UserNodeRepository userNodeRepository;
    private final WordNodeRepository wordNodeRepository;
    private final ArticleNodeRepository articleNodeRepository;
    private final CategoryNodeRepository categoryNodeRepository;
    private final TagNodeRepository tagNodeRepository;

    @Transactional
    public void syncUserToGraph(Long userId, String username) {
        try {
            UserNode userNode = userNodeRepository.findById(userId)
                    .orElse(new UserNode(userId, username));
            userNode.setUsername(username);
            userNodeRepository.save(userNode);
            log.info("同步用户到知识图谱: userId={}", userId);
        } catch (Exception e) {
            log.error("同步用户到知识图谱失败: userId={}, error={}", userId, e.getMessage());
        }
    }

    @Transactional
    public void syncWordToGraph(DailyWord word) {
        try {
            WordNode wordNode = wordNodeRepository.findById(word.getId().value())
                    .orElse(new WordNode());
            
            wordNode.setId(word.getId().value());
            wordNode.setWord(word.getWord());
            wordNode.setTranslation(word.getTranslation());
            wordNode.setDifficulty(word.getDifficulty().getCode());
            wordNode.setCategory(word.getCategory());

            if (word.getCategory() != null && !word.getCategory().isEmpty()) {
                CategoryNode categoryNode = categoryNodeRepository.findByName(word.getCategory())
                        .orElseGet(() -> categoryNodeRepository.save(new CategoryNode(word.getCategory(), "WORD")));
                wordNode.setCategoryNode(categoryNode);
            }

            DifficultyNode difficultyNode = new DifficultyNode(
                    word.getDifficulty().getCode(),
                    word.getDifficulty().getDescription()
            );
            wordNode.setDifficultyNode(difficultyNode);

            wordNodeRepository.save(wordNode);
            log.info("同步单词到知识图谱: wordId={}", word.getId().value());
        } catch (Exception e) {
            log.error("同步单词到知识图谱失败: wordId={}, error={}", word.getId().value(), e.getMessage());
        }
    }

    @Transactional
    public void syncArticleToGraph(DailyArticle article) {
        try {
            ArticleNode articleNode = articleNodeRepository.findById(article.getId().value())
                    .orElse(new ArticleNode());
            
            articleNode.setId(article.getId().value());
            articleNode.setTitle(article.getTitle());
            articleNode.setSummary(article.getSummary());
            articleNode.setDifficulty(article.getDifficulty().getCode());
            articleNode.setCategory(article.getCategory());
            articleNode.setViewCount(article.getViewCount());
            articleNode.setLikeCount(article.getLikeCount());

            if (article.getCategory() != null && !article.getCategory().isEmpty()) {
                CategoryNode categoryNode = categoryNodeRepository.findByName(article.getCategory())
                        .orElseGet(() -> categoryNodeRepository.save(new CategoryNode(article.getCategory(), "ARTICLE")));
                articleNode.setCategoryNode(categoryNode);
            }

            DifficultyNode difficultyNode = new DifficultyNode(
                    article.getDifficulty().getCode(),
                    article.getDifficulty().getDescription()
            );
            articleNode.setDifficultyNode(difficultyNode);

            if (article.getTags() != null && !article.getTags().isEmpty()) {
                Set<TagNode> tagNodes = new HashSet<>();
                for (String tagName : article.getTags()) {
                    TagNode tagNode = tagNodeRepository.findByName(tagName)
                            .orElseGet(() -> tagNodeRepository.save(new TagNode(tagName)));
                    tagNodes.add(tagNode);
                }
                articleNode.setTags(tagNodes);
            }

            articleNodeRepository.save(articleNode);
            log.info("同步文章到知识图谱: articleId={}", article.getId().value());
        } catch (Exception e) {
            log.error("同步文章到知识图谱失败: articleId={}, error={}", article.getId().value(), e.getMessage());
        }
    }

    @Transactional
    public void syncUserStudyWord(Long userId, Long wordId) {
        try {
            UserNode userNode = userNodeRepository.findById(userId).orElse(null);
            WordNode wordNode = wordNodeRepository.findById(wordId).orElse(null);
            
            if (userNode != null && wordNode != null) {
                userNode.getStudiedWords().add(wordNode);
                userNodeRepository.save(userNode);
                log.info("同步用户学习单词关系: userId={}, wordId={}", userId, wordId);
            }
        } catch (Exception e) {
            log.error("同步用户学习单词关系失败: userId={}, wordId={}, error={}", userId, wordId, e.getMessage());
        }
    }

    @Transactional
    public void syncUserCollectWord(Long userId, Long wordId) {
        try {
            UserNode userNode = userNodeRepository.findById(userId).orElse(null);
            WordNode wordNode = wordNodeRepository.findById(wordId).orElse(null);
            
            if (userNode != null && wordNode != null) {
                userNode.getCollectedWords().add(wordNode);
                userNodeRepository.save(userNode);
                log.info("同步用户收藏单词关系: userId={}, wordId={}", userId, wordId);
            }
        } catch (Exception e) {
            log.error("同步用户收藏单词关系失败: userId={}, wordId={}, error={}", userId, wordId, e.getMessage());
        }
    }

    @Transactional
    public void syncUserReadArticle(Long userId, Long articleId) {
        try {
            UserNode userNode = userNodeRepository.findById(userId).orElse(null);
            ArticleNode articleNode = articleNodeRepository.findById(articleId).orElse(null);
            
            if (userNode != null && articleNode != null) {
                userNode.getReadArticles().add(articleNode);
                userNodeRepository.save(userNode);
                log.info("同步用户阅读文章关系: userId={}, articleId={}", userId, articleId);
            }
        } catch (Exception e) {
            log.error("同步用户阅读文章关系失败: userId={}, articleId={}, error={}", userId, articleId, e.getMessage());
        }
    }

    @Transactional
    public void syncUserLikeArticle(Long userId, Long articleId) {
        try {
            UserNode userNode = userNodeRepository.findById(userId).orElse(null);
            ArticleNode articleNode = articleNodeRepository.findById(articleId).orElse(null);
            
            if (userNode != null && articleNode != null) {
                userNode.getLikedArticles().add(articleNode);
                userNodeRepository.save(userNode);
                log.info("同步用户点赞文章关系: userId={}, articleId={}", userId, articleId);
            }
        } catch (Exception e) {
            log.error("同步用户点赞文章关系失败: userId={}, articleId={}, error={}", userId, articleId, e.getMessage());
        }
    }

    @Transactional
    public void syncUserCollectArticle(Long userId, Long articleId) {
        try {
            UserNode userNode = userNodeRepository.findById(userId).orElse(null);
            ArticleNode articleNode = articleNodeRepository.findById(articleId).orElse(null);
            
            if (userNode != null && articleNode != null) {
                userNode.getCollectedArticles().add(articleNode);
                userNodeRepository.save(userNode);
                log.info("同步用户收藏文章关系: userId={}, articleId={}", userId, articleId);
            }
        } catch (Exception e) {
            log.error("同步用户收藏文章关系失败: userId={}, articleId={}, error={}", userId, articleId, e.getMessage());
        }
    }

    public void syncAllWordsToGraph() {
        log.info("开始全量同步单词到知识图谱...");
        int page = 1;
        int size = 100;
        List<DailyWord> words;
        int total = 0;
        
        do {
            words = dailyWordRepository.findAll(page, size);
            for (DailyWord word : words) {
                syncWordToGraph(word);
                total++;
            }
            page++;
        } while (!words.isEmpty());
        
        log.info("全量同步单词完成，共同步 {} 个单词", total);
    }

    public void syncAllArticlesToGraph() {
        log.info("开始全量同步文章到知识图谱...");
        int page = 1;
        int size = 100;
        List<DailyArticle> articles;
        int total = 0;
        
        do {
            articles = dailyArticleRepository.findAll(page, size);
            for (DailyArticle article : articles) {
                syncArticleToGraph(article);
                total++;
            }
            page++;
        } while (!articles.isEmpty());
        
        log.info("全量同步文章完成，共同步 {} 篇文章", total);
    }
}
