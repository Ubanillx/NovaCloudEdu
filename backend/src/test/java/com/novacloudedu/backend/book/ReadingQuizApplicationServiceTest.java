package com.novacloudedu.backend.book;

import com.novacloudedu.backend.application.book.service.ReadingQuizApplicationService;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.entity.ReadingQuiz;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.repository.ReadingQuizRepository;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.valueobject.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import com.google.gson.Gson;

/**
 * 阅读测试应用服务测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("阅读测试应用服务测试")
class ReadingQuizApplicationServiceTest {

    @Mock
    private ChapterRepository chapterRepository;

    @Mock
    private ReadingQuizRepository quizRepository;

    @Mock
    private LlmService llmService;

    private ReadingQuizApplicationService service;

    private BookId bookId;
    private ChapterId chapterId;
    private Chapter chapter;

    @BeforeEach
    void setUp() {
        service = new ReadingQuizApplicationService(
                chapterRepository,
                quizRepository,
                llmService,
                new Gson()
        );
        
        bookId = BookId.of(1L);
        chapterId = ChapterId.of(1L);

        chapter = Chapter.reconstruct(
                chapterId,
                bookId,
                "第一章",
                1,
                500,
                "这是第一章的内容，包含了很多重要的知识点。",
                "hash123",
                null,
                LocalDateTime.now(),
                LocalDateTime.now()
        );
    }

    @Test
    @DisplayName("生成阅读测试 - 成功")
    void testGenerateQuiz_Success() {
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.of(chapter));
        when(llmService.getModelName()).thenReturn("qwen-plus");
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("[{\"type\":\"CHOICE\",\"difficulty\":\"EASY\",\"question\":\"问题1\",\"options\":[\"A\",\"B\"],\"correctAnswer\":\"A\",\"explanation\":\"解释1\"}]");
        when(quizRepository.save(any(ReadingQuiz.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        ReadingQuiz result = service.generateQuiz(1L, 5, "MEDIUM");

        assertNotNull(result);
        assertEquals(chapterId, result.getChapterId());
        verify(quizRepository, times(1)).save(any(ReadingQuiz.class));
    }

    @Test
    @DisplayName("生成阅读测试 - 章节不存在")
    void testGenerateQuiz_ChapterNotFound() {
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.empty());

        assertThrows(IllegalArgumentException.class, () -> {
            service.generateQuiz(1L, 5, "MEDIUM");
        });

        verify(quizRepository, never()).save(any());
    }

    @Test
    @DisplayName("获取最新测试 - 成功")
    void testGetLatestQuiz_Success() {
        ReadingQuiz.QuizQuestion question = ReadingQuiz.QuizQuestion.create(
                QuestionType.CHOICE,
                QuestionDifficulty.EASY,
                "问题1",
                Arrays.asList("A", "B", "C", "D"),
                "A",
                "解释1"
        );
        
        ReadingQuiz quiz = ReadingQuiz.create(
                chapterId,
                Arrays.asList(question),
                "qwen-plus"
        );

        when(quizRepository.findLatestByChapterId(chapterId)).thenReturn(Optional.of(quiz));

        Optional<ReadingQuiz> result = service.getLatestQuiz(1L);

        assertTrue(result.isPresent());
        assertEquals(chapterId, result.get().getChapterId());
    }

    @Test
    @DisplayName("提交答案 - 成功")
    void testSubmitAnswers_Success() {
        ReadingQuiz.QuizQuestion question1 = ReadingQuiz.QuizQuestion.create(
                QuestionType.CHOICE,
                QuestionDifficulty.EASY,
                "问题1",
                Arrays.asList("A", "B", "C", "D"),
                "A",
                "解释1"
        );
        
        ReadingQuiz.QuizQuestion question2 = ReadingQuiz.QuizQuestion.create(
                QuestionType.CHOICE,
                QuestionDifficulty.MEDIUM,
                "问题2",
                Arrays.asList("A", "B", "C", "D"),
                "B",
                "解释2"
        );
        
        ReadingQuiz quiz = ReadingQuiz.create(
                chapterId,
                Arrays.asList(question1, question2),
                "qwen-plus"
        );

        when(quizRepository.findById(any(ReadingQuizId.class))).thenReturn(Optional.of(quiz));

        List<String> userAnswers = Arrays.asList("A", "B");
        int score = service.submitAnswers(1L, userAnswers);

        assertEquals(100, score);
    }

    @Test
    @DisplayName("提交答案 - 测试不存在")
    void testSubmitAnswers_QuizNotFound() {
        when(quizRepository.findById(any())).thenReturn(Optional.empty());

        assertThrows(IllegalArgumentException.class, () -> {
            service.submitAnswers(999L, Arrays.asList("A", "B"));
        });
    }

    @Test
    @DisplayName("提交答案 - 答案数量不匹配")
    void testSubmitAnswers_AnswerCountMismatch() {
        ReadingQuiz.QuizQuestion question = ReadingQuiz.QuizQuestion.create(
                QuestionType.CHOICE,
                QuestionDifficulty.EASY,
                "问题1",
                Arrays.asList("A", "B", "C", "D"),
                "A",
                "解释1"
        );
        
        ReadingQuiz quiz = ReadingQuiz.create(
                chapterId,
                Arrays.asList(question),
                "qwen-plus"
        );

        when(quizRepository.findById(any(ReadingQuizId.class))).thenReturn(Optional.of(quiz));

        assertThrows(IllegalArgumentException.class, () -> {
            service.submitAnswers(1L, Arrays.asList("A", "B"));
        });
    }
}
