package com.novacloudedu.backend.dailylearning;

import com.novacloudedu.backend.application.recommendation.service.KnowledgeGraphRecommendationService;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.neo4j.node.ArticleNode;
import com.novacloudedu.backend.infrastructure.neo4j.node.WordNode;
import com.novacloudedu.backend.infrastructure.neo4j.repository.ArticleNodeRepository;
import com.novacloudedu.backend.infrastructure.neo4j.repository.WordNodeRepository;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class KnowledgeGraphRecommendationServiceTest {

    @Mock
    private WordNodeRepository wordNodeRepository;

    @Mock
    private ArticleNodeRepository articleNodeRepository;

    @Mock
    private DailyWordRepository dailyWordRepository;

    @Mock
    private DailyArticleRepository dailyArticleRepository;

    @InjectMocks
    private KnowledgeGraphRecommendationService knowledgeGraphRecommendationService;

    private static final Long USER_ID = 100L;
    private static final Long WORD_ID = 1L;
    private static final Long ARTICLE_ID = 1L;

    private WordNode mockWordNode;
    private ArticleNode mockArticleNode;
    private DailyWord mockDailyWord;
    private DailyArticle mockDailyArticle;

    @BeforeEach
    void setUp() {
        mockWordNode = new WordNode(WORD_ID, "hello", "你好", 1, "日常用语");
        mockArticleNode = new ArticleNode(ARTICLE_ID, "英语学习技巧", "学习英语的方法", 2, "学习方法");

        mockDailyWord = DailyWord.reconstruct(
                DailyWordId.of(WORD_ID),
                "hello",
                "həˈloʊ",
                "http://audio.mp3",
                "你好",
                "Hello, world!",
                "你好，世界！",
                Difficulty.fromCode(1),
                "日常用语",
                "常用问候语",
                LocalDate.now(),
                UserId.of(1L),
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now()
        );

        mockDailyArticle = DailyArticle.reconstruct(
                DailyArticleId.of(ARTICLE_ID),
                "英语学习技巧",
                "这是一篇关于英语学习技巧的文章...",
                "本文介绍了高效学习英语的方法",
                "http://cover.jpg",
                "张老师",
                "教育周刊",
                "http://source.com/article",
                "学习方法",
                List.of("英语", "学习", "技巧"),
                Difficulty.fromCode(2),
                10,
                LocalDate.now(),
                UserId.of(1L),
                100,
                50,
                20,
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now()
        );
    }

    // ==================== 单词推荐测试 ====================

    @Test
    @Order(1)
    @DisplayName("推荐单词 - 协同过滤成功")
    void recommendWords_CollaborativeFiltering_Success() {
        when(wordNodeRepository.recommendWordsByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockWordNode));
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));

        List<DailyWord> result = knowledgeGraphRecommendationService.recommendWords(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("hello", result.get(0).getWord());
    }

    @Test
    @Order(2)
    @DisplayName("推荐单词 - 协同过滤不足时使用同分类推荐")
    void recommendWords_FallbackToCategory_Success() {
        when(wordNodeRepository.recommendWordsByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.recommendWordsBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockWordNode));
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));

        List<DailyWord> result = knowledgeGraphRecommendationService.recommendWords(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(3)
    @DisplayName("推荐单词 - 协同过滤和分类都不足时使用难度推荐")
    void recommendWords_FallbackToDifficulty_Success() {
        when(wordNodeRepository.recommendWordsByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.recommendWordsBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.recommendWordsBySameDifficulty(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockWordNode));
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));

        List<DailyWord> result = knowledgeGraphRecommendationService.recommendWords(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(4)
    @DisplayName("推荐单词 - 所有推荐都不足时使用未学习单词")
    void recommendWords_FallbackToUnstudied_Success() {
        when(wordNodeRepository.recommendWordsByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.recommendWordsBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.recommendWordsBySameDifficulty(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.findUnstudiedWords(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockWordNode));
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));

        List<DailyWord> result = knowledgeGraphRecommendationService.recommendWords(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(5)
    @DisplayName("推荐单词 - Neo4j查询失败时使用默认推荐")
    void recommendWords_Neo4jFails_FallbackToDefault() {
        when(wordNodeRepository.recommendWordsByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenThrow(new RuntimeException("Neo4j connection failed"));
        when(dailyWordRepository.findAll(eq(1), anyInt()))
                .thenReturn(List.of(mockDailyWord));

        List<DailyWord> result = knowledgeGraphRecommendationService.recommendWords(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    // ==================== 文章推荐测试 ====================

    @Test
    @Order(6)
    @DisplayName("推荐文章 - 协同过滤成功")
    void recommendArticles_CollaborativeFiltering_Success() {
        when(articleNodeRepository.recommendArticlesByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockArticleNode));
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));

        List<DailyArticle> result = knowledgeGraphRecommendationService.recommendArticles(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("英语学习技巧", result.get(0).getTitle());
    }

    @Test
    @Order(7)
    @DisplayName("推荐文章 - 协同过滤不足时使用同分类推荐")
    void recommendArticles_FallbackToCategory_Success() {
        when(articleNodeRepository.recommendArticlesByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockArticleNode));
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));

        List<DailyArticle> result = knowledgeGraphRecommendationService.recommendArticles(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(8)
    @DisplayName("推荐文章 - 使用同标签推荐")
    void recommendArticles_FallbackToTag_Success() {
        when(articleNodeRepository.recommendArticlesByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameTag(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockArticleNode));
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));

        List<DailyArticle> result = knowledgeGraphRecommendationService.recommendArticles(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(9)
    @DisplayName("推荐文章 - 使用点赞用户推荐")
    void recommendArticles_FallbackToLikedUsers_Success() {
        when(articleNodeRepository.recommendArticlesByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameTag(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesByLikedUsers(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockArticleNode));
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));

        List<DailyArticle> result = knowledgeGraphRecommendationService.recommendArticles(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(10)
    @DisplayName("推荐文章 - 使用热门未读文章")
    void recommendArticles_FallbackToPopular_Success() {
        when(articleNodeRepository.recommendArticlesByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameTag(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesByLikedUsers(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.findPopularUnreadArticles(eq(USER_ID), anyInt()))
                .thenReturn(List.of(mockArticleNode));
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));

        List<DailyArticle> result = knowledgeGraphRecommendationService.recommendArticles(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(11)
    @DisplayName("推荐文章 - Neo4j查询失败时使用默认推荐")
    void recommendArticles_Neo4jFails_FallbackToDefault() {
        when(articleNodeRepository.recommendArticlesByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenThrow(new RuntimeException("Neo4j connection failed"));
        when(dailyArticleRepository.findAll(eq(1), anyInt()))
                .thenReturn(List.of(mockDailyArticle));

        List<DailyArticle> result = knowledgeGraphRecommendationService.recommendArticles(USER_ID, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(12)
    @DisplayName("推荐单词 - 空结果")
    void recommendWords_EmptyResult() {
        when(wordNodeRepository.recommendWordsByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.recommendWordsBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.recommendWordsBySameDifficulty(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(wordNodeRepository.findUnstudiedWords(eq(USER_ID), anyInt()))
                .thenReturn(List.of());

        List<DailyWord> result = knowledgeGraphRecommendationService.recommendWords(USER_ID, 10);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    @Order(13)
    @DisplayName("推荐文章 - 空结果")
    void recommendArticles_EmptyResult() {
        when(articleNodeRepository.recommendArticlesByCollaborativeFiltering(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameCategory(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesBySameTag(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.recommendArticlesByLikedUsers(eq(USER_ID), anyInt()))
                .thenReturn(List.of());
        when(articleNodeRepository.findPopularUnreadArticles(eq(USER_ID), anyInt()))
                .thenReturn(List.of());

        List<DailyArticle> result = knowledgeGraphRecommendationService.recommendArticles(USER_ID, 10);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }
}
