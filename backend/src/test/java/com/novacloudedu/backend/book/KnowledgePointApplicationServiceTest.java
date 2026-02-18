package com.novacloudedu.backend.book;

import com.novacloudedu.backend.application.service.KnowledgePointApplicationService;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.entity.KnowledgePoint;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.repository.KnowledgePointRepository;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.KnowledgePointType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 知识点提取应用服务测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("知识点提取应用服务测试")
class KnowledgePointApplicationServiceTest {

    @Mock
    private KnowledgePointRepository knowledgePointRepository;

    @Mock
    private ChapterRepository chapterRepository;

    @Mock
    private LlmService llmService;

    @InjectMocks
    private KnowledgePointApplicationService service;

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
    @DisplayName("提取知识点 - 成功")
    void testExtractKnowledgePoints_Success() {
        when(knowledgePointRepository.findByChapterId(chapterId)).thenReturn(Collections.emptyList());
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.of(chapter));
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("[{\"name\":\"知识点1\",\"description\":\"描述1\",\"type\":\"CONCEPT\",\"position\":1}]");
        when(knowledgePointRepository.saveAll(anyList()))
                .thenAnswer(invocation -> invocation.getArgument(0));

        List<KnowledgePoint> result = service.extractKnowledgePoints(1L);

        assertNotNull(result);
        verify(knowledgePointRepository, times(1)).saveAll(anyList());
    }

    @Test
    @DisplayName("提取知识点 - 章节不存在")
    void testExtractKnowledgePoints_ChapterNotFound() {
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.empty());

        assertThrows(IllegalArgumentException.class, () -> {
            service.extractKnowledgePoints(1L);
        });

        verify(knowledgePointRepository, never()).saveAll(anyList());
    }

    @Test
    @DisplayName("获取知识点 - 成功")
    void testGetKnowledgePoints_Success() {
        List<KnowledgePoint> points = Arrays.asList(
                KnowledgePoint.create(chapterId, KnowledgePointType.CONCEPT, "知识点1", "描述1", 1),
                KnowledgePoint.create(chapterId, KnowledgePointType.PRINCIPLE, "知识点2", "描述2", 2)
        );

        when(knowledgePointRepository.findByChapterId(chapterId)).thenReturn(points);

        List<KnowledgePoint> result = service.getKnowledgePoints(1L);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(knowledgePointRepository, times(1)).findByChapterId(chapterId);
    }

    @Test
    @DisplayName("按类型获取知识点 - 成功")
    void testGetKnowledgePointsByType_Success() {
        List<KnowledgePoint> points = Arrays.asList(
                KnowledgePoint.create(chapterId, KnowledgePointType.CONCEPT, "概念1", "描述1", 1)
        );

        when(knowledgePointRepository.findByChapterIdAndType(chapterId, KnowledgePointType.CONCEPT))
                .thenReturn(points);

        List<KnowledgePoint> result = service.getKnowledgePointsByType(1L, "CONCEPT");

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals(KnowledgePointType.CONCEPT, result.get(0).getPointType());
    }

    @Test
    @DisplayName("重新提取知识点 - 成功")
    void testRegenerateKnowledgePoints_Success() {
        when(chapterRepository.findById(chapterId)).thenReturn(Optional.of(chapter));
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("[{\"name\":\"新知识点\",\"description\":\"新描述\",\"type\":\"CONCEPT\",\"position\":1}]");

        List<KnowledgePoint> result = service.regenerateKnowledgePoints(1L);

        assertNotNull(result);
        verify(knowledgePointRepository, times(1)).deleteByChapterId(chapterId);
        verify(knowledgePointRepository, times(1)).saveAll(anyList());
    }
}
