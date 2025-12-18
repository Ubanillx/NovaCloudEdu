package com.novacloudedu.backend.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.ArticleInteractionCommand;
import com.novacloudedu.backend.application.dailylearning.command.CreateDailyArticleCommand;
import com.novacloudedu.backend.application.dailylearning.command.DeleteDailyArticleCommand;
import com.novacloudedu.backend.application.dailylearning.command.UpdateDailyArticleCommand;
import com.novacloudedu.backend.application.dailylearning.query.GetDailyArticleQuery;
import com.novacloudedu.backend.application.dailylearning.query.GetUserDailyArticleQuery;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
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
class DailyArticleServiceTest {

    @Mock
    private DailyArticleRepository dailyArticleRepository;

    @Mock
    private UserDailyArticleRepository userDailyArticleRepository;

    @InjectMocks
    private CreateDailyArticleCommand createDailyArticleCommand;

    @InjectMocks
    private UpdateDailyArticleCommand updateDailyArticleCommand;

    @InjectMocks
    private DeleteDailyArticleCommand deleteDailyArticleCommand;

    @InjectMocks
    private GetDailyArticleQuery getDailyArticleQuery;

    @InjectMocks
    private ArticleInteractionCommand articleInteractionCommand;

    @InjectMocks
    private GetUserDailyArticleQuery getUserDailyArticleQuery;

    private static final Long ARTICLE_ID = 1L;
    private static final Long USER_ID = 100L;
    private static final Long ADMIN_ID = 1L;

    private DailyArticle mockDailyArticle;
    private UserDailyArticle mockUserDailyArticle;

    @BeforeEach
    void setUp() {
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
                UserId.of(ADMIN_ID),
                100,
                50,
                20,
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now()
        );

        mockUserDailyArticle = UserDailyArticle.reconstruct(
                1L,
                UserId.of(USER_ID),
                DailyArticleId.of(ARTICLE_ID),
                true,
                false,
                false,
                null,
                null,
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now()
        );
    }

    // ==================== 每日文章CRUD测试 ====================

    @Test
    @Order(1)
    @DisplayName("创建每日文章 - 成功")
    void createDailyArticle_Success() {
        when(dailyArticleRepository.save(any(DailyArticle.class))).thenAnswer(invocation -> {
            DailyArticle article = invocation.getArgument(0);
            article.assignId(DailyArticleId.of(ARTICLE_ID));
            return article;
        });

        Long id = createDailyArticleCommand.execute(
                "新文章标题",
                "新文章内容...",
                "文章摘要",
                "http://cover2.jpg",
                "李老师",
                "学习报",
                "http://source2.com",
                "阅读理解",
                List.of("阅读", "理解"),
                3,
                15,
                LocalDate.now(),
                ADMIN_ID
        );

        assertEquals(ARTICLE_ID, id);
        verify(dailyArticleRepository, times(1)).save(any(DailyArticle.class));
    }

    @Test
    @Order(2)
    @DisplayName("更新每日文章 - 成功")
    void updateDailyArticle_Success() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));
        when(dailyArticleRepository.save(any(DailyArticle.class))).thenReturn(mockDailyArticle);

        assertDoesNotThrow(() -> updateDailyArticleCommand.execute(
                ARTICLE_ID,
                "更新后的标题",
                "更新后的内容...",
                "更新后的摘要",
                "http://cover-updated.jpg",
                "王老师",
                "新来源",
                "http://new-source.com",
                "写作技巧",
                List.of("写作", "技巧"),
                2,
                12,
                LocalDate.now()
        ));

        verify(dailyArticleRepository, times(1)).save(any(DailyArticle.class));
    }

    @Test
    @Order(3)
    @DisplayName("更新每日文章 - 文章不存在抛异常")
    void updateDailyArticle_NotFound_ThrowsException() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.empty());

        assertThrows(BusinessException.class, () -> updateDailyArticleCommand.execute(
                999L, "标题", "内容", null, null, null, null, null, null, null, null, null, null
        ));
    }

    @Test
    @Order(4)
    @DisplayName("删除每日文章 - 成功")
    void deleteDailyArticle_Success() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));
        doNothing().when(dailyArticleRepository).deleteById(any(DailyArticleId.class));

        assertDoesNotThrow(() -> deleteDailyArticleCommand.execute(ARTICLE_ID));
        verify(dailyArticleRepository, times(1)).deleteById(any(DailyArticleId.class));
    }

    @Test
    @Order(5)
    @DisplayName("删除每日文章 - 直接删除")
    void deleteDailyArticle_DirectDelete() {
        doNothing().when(dailyArticleRepository).deleteById(any(DailyArticleId.class));

        assertDoesNotThrow(() -> deleteDailyArticleCommand.execute(999L));
        verify(dailyArticleRepository, times(1)).deleteById(any(DailyArticleId.class));
    }

    // ==================== 查询测试 ====================

    @Test
    @Order(6)
    @DisplayName("根据ID获取文章 - 成功")
    void getDailyArticleById_Success() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));

        Optional<DailyArticle> result = getDailyArticleQuery.execute(ARTICLE_ID);

        assertTrue(result.isPresent());
        assertEquals("英语学习技巧", result.get().getTitle());
    }

    @Test
    @Order(7)
    @DisplayName("获取今日文章列表")
    void getTodayArticles_Success() {
        when(dailyArticleRepository.findByPublishDate(LocalDate.now()))
                .thenReturn(List.of(mockDailyArticle));

        List<DailyArticle> result = getDailyArticleQuery.executeToday();

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(8)
    @DisplayName("根据分类获取文章列表")
    void getArticlesByCategory_Success() {
        when(dailyArticleRepository.findByCategory(eq("学习方法"), eq(1), eq(10)))
                .thenReturn(List.of(mockDailyArticle));

        List<DailyArticle> result = getDailyArticleQuery.executeByCategory("学习方法", 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(9)
    @DisplayName("根据难度获取文章列表")
    void getArticlesByDifficulty_Success() {
        when(dailyArticleRepository.findByDifficulty(eq(Difficulty.fromCode(2)), eq(1), eq(10)))
                .thenReturn(List.of(mockDailyArticle));

        List<DailyArticle> result = getDailyArticleQuery.executeByDifficulty(2, 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(10)
    @DisplayName("搜索文章")
    void searchArticles_Success() {
        when(dailyArticleRepository.searchByKeyword(eq("英语"), eq(1), eq(10)))
                .thenReturn(List.of(mockDailyArticle));

        List<DailyArticle> result = getDailyArticleQuery.searchByKeyword("英语", 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    // ==================== 用户文章交互测试 ====================

    @Test
    @Order(11)
    @DisplayName("标记文章为已阅读 - 新记录")
    void markAsRead_NewRecord_Success() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));
        when(dailyArticleRepository.save(any(DailyArticle.class)))
                .thenReturn(mockDailyArticle);
        when(userDailyArticleRepository.findByUserIdAndArticleId(eq(UserId.of(USER_ID)), any(DailyArticleId.class)))
                .thenReturn(Optional.empty());
        when(userDailyArticleRepository.save(any(UserDailyArticle.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> articleInteractionCommand.markAsRead(USER_ID, ARTICLE_ID));
        verify(userDailyArticleRepository, times(1)).save(any(UserDailyArticle.class));
    }

    @Test
    @Order(12)
    @DisplayName("标记文章为已阅读 - 已有记录")
    void markAsRead_ExistingRecord_Success() {
        UserDailyArticle unreadArticle = UserDailyArticle.reconstruct(
                1L, UserId.of(USER_ID), DailyArticleId.of(ARTICLE_ID),
                false, false, false, null, null, LocalDateTime.now(), LocalDateTime.now()
        );
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));
        when(dailyArticleRepository.save(any(DailyArticle.class)))
                .thenReturn(mockDailyArticle);
        when(userDailyArticleRepository.findByUserIdAndArticleId(eq(UserId.of(USER_ID)), any(DailyArticleId.class)))
                .thenReturn(Optional.of(unreadArticle));
        when(userDailyArticleRepository.save(any(UserDailyArticle.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> articleInteractionCommand.markAsRead(USER_ID, ARTICLE_ID));
        verify(userDailyArticleRepository, times(1)).save(any(UserDailyArticle.class));
    }

    @Test
    @Order(13)
    @DisplayName("点赞文章")
    void toggleLike_Success() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));
        when(dailyArticleRepository.save(any(DailyArticle.class)))
                .thenReturn(mockDailyArticle);
        when(userDailyArticleRepository.findByUserIdAndArticleId(eq(UserId.of(USER_ID)), any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockUserDailyArticle));
        when(userDailyArticleRepository.save(any(UserDailyArticle.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> articleInteractionCommand.toggleLike(USER_ID, ARTICLE_ID));
        verify(userDailyArticleRepository, times(1)).save(any(UserDailyArticle.class));
    }

    @Test
    @Order(14)
    @DisplayName("收藏文章")
    void toggleCollect_Success() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));
        when(dailyArticleRepository.save(any(DailyArticle.class)))
                .thenReturn(mockDailyArticle);
        when(userDailyArticleRepository.findByUserIdAndArticleId(eq(UserId.of(USER_ID)), any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockUserDailyArticle));
        when(userDailyArticleRepository.save(any(UserDailyArticle.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> articleInteractionCommand.toggleCollect(USER_ID, ARTICLE_ID));
        verify(userDailyArticleRepository, times(1)).save(any(UserDailyArticle.class));
    }

    @Test
    @Order(15)
    @DisplayName("添加评论")
    void addComment_Success() {
        when(dailyArticleRepository.findById(any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockDailyArticle));
        when(userDailyArticleRepository.findByUserIdAndArticleId(eq(UserId.of(USER_ID)), any(DailyArticleId.class)))
                .thenReturn(Optional.of(mockUserDailyArticle));
        when(userDailyArticleRepository.save(any(UserDailyArticle.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> articleInteractionCommand.addComment(USER_ID, ARTICLE_ID, "这篇文章很有帮助！"));
        verify(userDailyArticleRepository, times(1)).save(any(UserDailyArticle.class));
    }

    @Test
    @Order(16)
    @DisplayName("获取用户已阅读文章列表")
    void getReadArticles_Success() {
        when(userDailyArticleRepository.findReadByUserId(eq(UserId.of(USER_ID)), eq(1), eq(10)))
                .thenReturn(List.of(mockUserDailyArticle));

        List<UserDailyArticle> result = getUserDailyArticleQuery.executeReadByUserId(USER_ID, 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(17)
    @DisplayName("获取用户点赞文章列表")
    void getLikedArticles_Success() {
        UserDailyArticle likedArticle = UserDailyArticle.reconstruct(
                1L, UserId.of(USER_ID), DailyArticleId.of(ARTICLE_ID),
                true, true, false, null, null, LocalDateTime.now(), LocalDateTime.now()
        );
        when(userDailyArticleRepository.findLikedByUserId(eq(UserId.of(USER_ID)), eq(1), eq(10)))
                .thenReturn(List.of(likedArticle));

        List<UserDailyArticle> result = getUserDailyArticleQuery.executeLikedByUserId(USER_ID, 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(18)
    @DisplayName("获取用户收藏文章列表")
    void getCollectedArticles_Success() {
        UserDailyArticle collectedArticle = UserDailyArticle.reconstruct(
                1L, UserId.of(USER_ID), DailyArticleId.of(ARTICLE_ID),
                true, false, true, null, null, LocalDateTime.now(), LocalDateTime.now()
        );
        when(userDailyArticleRepository.findCollectedByUserId(eq(UserId.of(USER_ID)), eq(1), eq(10)))
                .thenReturn(List.of(collectedArticle));

        List<UserDailyArticle> result = getUserDailyArticleQuery.executeCollectedByUserId(USER_ID, 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(19)
    @DisplayName("统计用户阅读数量")
    void countRead_Success() {
        when(userDailyArticleRepository.countByUserId(UserId.of(USER_ID))).thenReturn(20L);
        when(userDailyArticleRepository.countReadByUserId(UserId.of(USER_ID))).thenReturn(15L);

        long total = getUserDailyArticleQuery.countByUserId(USER_ID);
        long read = getUserDailyArticleQuery.countReadByUserId(USER_ID);

        assertEquals(20L, total);
        assertEquals(15L, read);
    }
}
