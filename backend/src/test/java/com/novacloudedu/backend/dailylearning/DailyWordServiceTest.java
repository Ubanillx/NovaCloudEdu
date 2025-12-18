package com.novacloudedu.backend.dailylearning;

import com.novacloudedu.backend.application.dailylearning.command.CreateDailyWordCommand;
import com.novacloudedu.backend.application.dailylearning.command.DeleteDailyWordCommand;
import com.novacloudedu.backend.application.dailylearning.command.StudyWordCommand;
import com.novacloudedu.backend.application.dailylearning.command.UpdateDailyWordCommand;
import com.novacloudedu.backend.application.dailylearning.query.GetDailyWordQuery;
import com.novacloudedu.backend.application.dailylearning.query.GetUserDailyWordQuery;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.dailylearning.valueobject.MasteryLevel;
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
class DailyWordServiceTest {

    @Mock
    private DailyWordRepository dailyWordRepository;

    @Mock
    private UserDailyWordRepository userDailyWordRepository;

    @InjectMocks
    private CreateDailyWordCommand createDailyWordCommand;

    @InjectMocks
    private UpdateDailyWordCommand updateDailyWordCommand;

    @InjectMocks
    private DeleteDailyWordCommand deleteDailyWordCommand;

    @InjectMocks
    private GetDailyWordQuery getDailyWordQuery;

    @InjectMocks
    private StudyWordCommand studyWordCommand;

    @InjectMocks
    private GetUserDailyWordQuery getUserDailyWordQuery;

    private static final Long WORD_ID = 1L;
    private static final Long USER_ID = 100L;
    private static final Long ADMIN_ID = 1L;

    private DailyWord mockDailyWord;
    private UserDailyWord mockUserDailyWord;

    @BeforeEach
    void setUp() {
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
                UserId.of(ADMIN_ID),
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now()
        );

        mockUserDailyWord = UserDailyWord.reconstruct(
                1L,
                UserId.of(USER_ID),
                DailyWordId.of(WORD_ID),
                true,
                false,
                MasteryLevel.NEW_WORD,
                LocalDateTime.now().minusDays(1),
                LocalDateTime.now()
        );
    }

    // ==================== 每日单词CRUD测试 ====================

    @Test
    @Order(1)
    @DisplayName("创建每日单词 - 成功")
    void createDailyWord_Success() {
        when(dailyWordRepository.save(any(DailyWord.class))).thenAnswer(invocation -> {
            DailyWord word = invocation.getArgument(0);
            word.assignId(DailyWordId.of(WORD_ID));
            return word;
        });

        Long id = createDailyWordCommand.execute(
                "world",
                "wɜːrld",
                "http://audio2.mp3",
                "世界",
                "The world is beautiful.",
                "世界是美丽的。",
                2,
                "日常用语",
                "常用名词",
                LocalDate.now(),
                ADMIN_ID
        );

        assertEquals(WORD_ID, id);
        verify(dailyWordRepository, times(1)).save(any(DailyWord.class));
    }

    @Test
    @Order(2)
    @DisplayName("更新每日单词 - 成功")
    void updateDailyWord_Success() {
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));
        when(dailyWordRepository.save(any(DailyWord.class))).thenReturn(mockDailyWord);

        assertDoesNotThrow(() -> updateDailyWordCommand.execute(
                WORD_ID,
                "hello updated",
                "həˈloʊ",
                "http://audio.mp3",
                "你好（更新）",
                "Hello, updated world!",
                "你好，更新的世界！",
                2,
                "日常用语",
                "更新后的备注",
                LocalDate.now()
        ));

        verify(dailyWordRepository, times(1)).save(any(DailyWord.class));
    }

    @Test
    @Order(3)
    @DisplayName("更新每日单词 - 单词不存在抛异常")
    void updateDailyWord_NotFound_ThrowsException() {
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.empty());

        assertThrows(BusinessException.class, () -> updateDailyWordCommand.execute(
                999L, "test", null, null, "测试", null, null, null, null, null, null
        ));
    }

    @Test
    @Order(4)
    @DisplayName("删除每日单词 - 成功")
    void deleteDailyWord_Success() {
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));
        doNothing().when(dailyWordRepository).deleteById(any(DailyWordId.class));

        assertDoesNotThrow(() -> deleteDailyWordCommand.execute(WORD_ID));
        verify(dailyWordRepository, times(1)).deleteById(any(DailyWordId.class));
    }

    @Test
    @Order(5)
    @DisplayName("删除每日单词 - 直接删除")
    void deleteDailyWord_DirectDelete() {
        doNothing().when(dailyWordRepository).deleteById(any(DailyWordId.class));

        assertDoesNotThrow(() -> deleteDailyWordCommand.execute(999L));
        verify(dailyWordRepository, times(1)).deleteById(any(DailyWordId.class));
    }

    // ==================== 查询测试 ====================

    @Test
    @Order(6)
    @DisplayName("根据ID获取单词 - 成功")
    void getDailyWordById_Success() {
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));

        Optional<DailyWord> result = getDailyWordQuery.execute(WORD_ID);

        assertTrue(result.isPresent());
        assertEquals("hello", result.get().getWord());
    }

    @Test
    @Order(7)
    @DisplayName("获取今日单词列表")
    void getTodayWords_Success() {
        when(dailyWordRepository.findByPublishDate(LocalDate.now()))
                .thenReturn(List.of(mockDailyWord));

        List<DailyWord> result = getDailyWordQuery.executeToday();

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(8)
    @DisplayName("根据分类获取单词列表")
    void getWordsByCategory_Success() {
        when(dailyWordRepository.findByCategory(eq("日常用语"), eq(1), eq(10)))
                .thenReturn(List.of(mockDailyWord));

        List<DailyWord> result = getDailyWordQuery.executeByCategory("日常用语", 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(9)
    @DisplayName("根据难度获取单词列表")
    void getWordsByDifficulty_Success() {
        when(dailyWordRepository.findByDifficulty(eq(Difficulty.fromCode(1)), eq(1), eq(10)))
                .thenReturn(List.of(mockDailyWord));

        List<DailyWord> result = getDailyWordQuery.executeByDifficulty(1, 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(10)
    @DisplayName("搜索单词")
    void searchWords_Success() {
        when(dailyWordRepository.searchByWord(eq("hello"), eq(1), eq(10)))
                .thenReturn(List.of(mockDailyWord));

        List<DailyWord> result = getDailyWordQuery.searchByWord("hello", 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("hello", result.get(0).getWord());
    }

    // ==================== 用户学习交互测试 ====================

    @Test
    @Order(11)
    @DisplayName("标记单词为已学习 - 新记录")
    void studyWord_NewRecord_Success() {
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));
        when(userDailyWordRepository.findByUserIdAndWordId(eq(UserId.of(USER_ID)), any(DailyWordId.class)))
                .thenReturn(Optional.empty());
        when(userDailyWordRepository.save(any(UserDailyWord.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> studyWordCommand.execute(USER_ID, WORD_ID));
        verify(userDailyWordRepository, times(1)).save(any(UserDailyWord.class));
    }

    @Test
    @Order(12)
    @DisplayName("标记单词为已学习 - 已有记录")
    void studyWord_ExistingRecord_Success() {
        UserDailyWord unstudiedWord = UserDailyWord.reconstruct(
                1L, UserId.of(USER_ID), DailyWordId.of(WORD_ID),
                false, false, MasteryLevel.UNKNOWN, LocalDateTime.now(), LocalDateTime.now()
        );
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));
        when(userDailyWordRepository.findByUserIdAndWordId(eq(UserId.of(USER_ID)), any(DailyWordId.class)))
                .thenReturn(Optional.of(unstudiedWord));
        when(userDailyWordRepository.save(any(UserDailyWord.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> studyWordCommand.execute(USER_ID, WORD_ID));
        verify(userDailyWordRepository, times(1)).save(any(UserDailyWord.class));
    }

    @Test
    @Order(13)
    @DisplayName("更新单词掌握程度")
    void updateMastery_Success() {
        when(userDailyWordRepository.findByUserIdAndWordId(eq(UserId.of(USER_ID)), any(DailyWordId.class)))
                .thenReturn(Optional.of(mockUserDailyWord));
        when(userDailyWordRepository.save(any(UserDailyWord.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> studyWordCommand.updateMastery(USER_ID, WORD_ID, 3));
        verify(userDailyWordRepository, times(1)).save(any(UserDailyWord.class));
    }

    @Test
    @Order(14)
    @DisplayName("收藏单词")
    void collectWord_Success() {
        when(dailyWordRepository.findById(any(DailyWordId.class)))
                .thenReturn(Optional.of(mockDailyWord));
        when(userDailyWordRepository.findByUserIdAndWordId(eq(UserId.of(USER_ID)), any(DailyWordId.class)))
                .thenReturn(Optional.of(mockUserDailyWord));
        when(userDailyWordRepository.save(any(UserDailyWord.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> studyWordCommand.toggleCollect(USER_ID, WORD_ID));
        verify(userDailyWordRepository, times(1)).save(any(UserDailyWord.class));
    }

    @Test
    @Order(15)
    @DisplayName("获取用户已学习单词列表")
    void getStudiedWords_Success() {
        when(userDailyWordRepository.findStudiedByUserId(eq(UserId.of(USER_ID)), eq(1), eq(10)))
                .thenReturn(List.of(mockUserDailyWord));

        List<UserDailyWord> result = getUserDailyWordQuery.executeStudiedByUserId(USER_ID, 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(16)
    @DisplayName("获取用户收藏单词列表")
    void getCollectedWords_Success() {
        UserDailyWord collectedWord = UserDailyWord.reconstruct(
                1L, UserId.of(USER_ID), DailyWordId.of(WORD_ID),
                true, true, MasteryLevel.FAMILIAR, LocalDateTime.now(), LocalDateTime.now()
        );
        when(userDailyWordRepository.findCollectedByUserId(eq(UserId.of(USER_ID)), eq(1), eq(10)))
                .thenReturn(List.of(collectedWord));

        List<UserDailyWord> result = getUserDailyWordQuery.executeCollectedByUserId(USER_ID, 1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @Order(17)
    @DisplayName("统计用户学习数量")
    void countStudied_Success() {
        when(userDailyWordRepository.countByUserId(UserId.of(USER_ID))).thenReturn(10L);
        when(userDailyWordRepository.countStudiedByUserId(UserId.of(USER_ID))).thenReturn(5L);

        long total = getUserDailyWordQuery.countByUserId(USER_ID);
        long studied = getUserDailyWordQuery.countStudiedByUserId(USER_ID);

        assertEquals(10L, total);
        assertEquals(5L, studied);
    }
}
