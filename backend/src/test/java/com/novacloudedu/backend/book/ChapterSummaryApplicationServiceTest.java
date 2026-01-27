package com.novacloudedu.backend.book;

import com.novacloudedu.backend.application.book.service.ChapterSummaryApplicationService;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.entity.ChapterSummary;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterSummaryRepository;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterSummaryId;
import com.novacloudedu.backend.domain.book.valueobject.SummaryType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 章节总结应用服务测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("章节总结应用服务测试")
class ChapterSummaryApplicationServiceTest {

    @Mock
    private ChapterRepository chapterRepository;

    @Mock
    private ChapterSummaryRepository summaryRepository;

    @Mock
    private LlmService llmService;

    @InjectMocks
    private ChapterSummaryApplicationService service;

    private static final String DEFAULT_AI_MODEL = "qwen-plus";

    private BookId bookId;
    private ChapterId chapterId;
    private Chapter chapter;

    @BeforeEach
    void setUp() {
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
    @DisplayName("生成章节总结 - 成功")
    void testGenerateSummary_Success() {
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.of(chapter));
        when(llmService.getModelName()).thenReturn(DEFAULT_AI_MODEL);
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("这是一个测试总结内容。\n\n关键要点：\n1. 要点一\n2. 要点二");
        when(summaryRepository.save(any(ChapterSummary.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        ChapterSummary result = service.generateSummary(1L, "BRIEF");

        assertNotNull(result);
        assertTrue(result.getContent().contains("测试总结"));
        verify(summaryRepository, times(1)).save(any(ChapterSummary.class));
    }

    @Test
    @DisplayName("生成章节总结 - 章节不存在")
    void testGenerateSummary_ChapterNotFound() {
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.empty());

        assertThrows(IllegalArgumentException.class, () -> {
            service.generateSummary(1L, "BRIEF");
        });

        verify(summaryRepository, never()).save(any());
    }

    @Test
    @DisplayName("获取章节总结 - 成功")
    void testGetSummary_Success() {
        ChapterSummary summary = ChapterSummary.create(
                chapterId,
                SummaryType.BRIEF,
                "简要总结",
                Arrays.asList("要点1"),
                "qwen-plus"
        );
        
        when(summaryRepository.findByChapterIdAndType(chapterId, SummaryType.BRIEF))
                .thenReturn(Optional.of(summary));

        Optional<ChapterSummary> result = service.getSummary(1L, "BRIEF");

        assertTrue(result.isPresent());
        assertEquals("简要总结", result.get().getContent());
        verify(summaryRepository, times(1)).findByChapterIdAndType(chapterId, SummaryType.BRIEF);
    }

    @Test
    @DisplayName("获取所有类型总结 - 成功")
    void testGetAllSummaries_Success() {
        List<ChapterSummary> summaries = Arrays.asList(
                ChapterSummary.create(
                        chapterId,
                        SummaryType.BRIEF,
                        "简要总结",
                        Arrays.asList("要点1"),
                        "qwen-plus"
                ),
                ChapterSummary.create(
                        chapterId,
                        SummaryType.DETAILED,
                        "详细总结",
                        Arrays.asList("要点1", "要点2"),
                        "qwen-plus"
                )
        );
        
        when(summaryRepository.findByChapterId(chapterId)).thenReturn(summaries);

        List<ChapterSummary> result = service.getAllSummaries(1L);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(summaryRepository, times(1)).findByChapterId(chapterId);
    }

    @Test
    @DisplayName("重新生成总结 - 章节不存在")
    void testRegenerateSummary_NotFound() {
        when(summaryRepository.findByChapterIdAndType(any(), any()))
                .thenReturn(Optional.empty());
        when(chapterRepository.findById(any())).thenReturn(Optional.empty());

        assertThrows(IllegalArgumentException.class, () -> {
            service.regenerateSummary(999L, "BRIEF");
        });

        verify(summaryRepository, never()).save(any());
    }

    @Test
    @DisplayName("重新生成总结 - 成功")
    void testRegenerateSummary_Success() {
        when(summaryRepository.findByChapterIdAndType(chapterId, SummaryType.BRIEF))
                .thenReturn(Optional.empty());
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.of(chapter));
        when(llmService.getModelName()).thenReturn(DEFAULT_AI_MODEL);
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("重新生成的总结内容");
        when(summaryRepository.save(any(ChapterSummary.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        ChapterSummary result = service.regenerateSummary(1L, "BRIEF");

        assertNotNull(result);
        verify(summaryRepository, times(1)).save(any(ChapterSummary.class));
    }
}
