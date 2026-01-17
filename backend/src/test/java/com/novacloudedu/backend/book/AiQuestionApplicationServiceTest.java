package com.novacloudedu.backend.book;

import com.novacloudedu.backend.application.book.service.AiQuestionApplicationService;
import com.novacloudedu.backend.domain.book.entity.AiConversation;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.AiConversationRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
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

/**
 * AI问答应用服务测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("AI问答应用服务测试")
class AiQuestionApplicationServiceTest {

    @Mock
    private AiConversationRepository conversationRepository;

    @Mock
    private ChapterRepository chapterRepository;

    @Mock
    private LlmService llmService;

    @InjectMocks
    private AiQuestionApplicationService service;

    private UserId userId;
    private BookId bookId;
    private ChapterId chapterId;
    private Chapter chapter;

    @BeforeEach
    void setUp() {
        userId = UserId.of(1L);
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
                LocalDateTime.now(),
                LocalDateTime.now()
        );
    }

    @Test
    @DisplayName("新对话提问 - 成功")
    void testAskQuestion_Success() {
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("这是AI的回答");
        when(conversationRepository.save(any(AiConversation.class)))
                .thenAnswer(invocation -> {
                    AiConversation conv = invocation.getArgument(0);
                    return AiConversation.reconstruct(
                            AiConversationId.of(1L),
                            conv.getUserId(),
                            conv.getBookId(),
                            conv.getChapterId(),
                            conv.getConversationType(),
                            conv.getMessages(),
                            LocalDateTime.now(),
                            LocalDateTime.now()
                    );
                });

        Map<String, Object> result = service.askQuestion(1L, 1L, "这是什么内容？", 1L);

        assertNotNull(result);
        assertTrue(result.containsKey("conversationId"));
        assertTrue(result.containsKey("answer"));
        assertEquals("这是AI的回答", result.get("answer"));
        verify(conversationRepository, times(1)).save(any(AiConversation.class));
    }

    @Test
    @DisplayName("继续对话 - 成功")
    void testContinueConversation_Success() {
        AiConversationId conversationId = AiConversationId.of(1L);
        AiConversation existingConversation = AiConversation.reconstruct(
                conversationId,
                userId,
                bookId,
                chapterId,
                ConversationType.QA,
                new ArrayList<>(),
                LocalDateTime.now(),
                LocalDateTime.now()
        );

        when(conversationRepository.findById(conversationId))
                .thenReturn(Optional.of(existingConversation));
        when(llmService.chat(anyList()))
                .thenReturn("这是AI的后续回答");

        Map<String, Object> result = service.continueConversation(1L, "继续问题");

        assertNotNull(result);
        assertTrue(result.containsKey("answer"));
        verify(conversationRepository, times(1)).save(any(AiConversation.class));
    }

    @Test
    @DisplayName("继续对话 - 对话不存在")
    void testContinueConversation_NotFound() {
        when(conversationRepository.findById(any())).thenReturn(Optional.empty());

        assertThrows(IllegalArgumentException.class, () -> {
            service.continueConversation(999L, "继续问题");
        });

        verify(conversationRepository, never()).save(any());
    }

    @Test
    @DisplayName("获取用户对话列表 - 成功")
    void testGetUserConversations_Success() {
        List<AiConversation> conversations = Arrays.asList(
                AiConversation.create(userId, bookId, chapterId, ConversationType.QA),
                AiConversation.create(userId, bookId, chapterId, ConversationType.QA)
        );

        when(conversationRepository.findByUserId(eq(userId), anyInt(), anyInt()))
                .thenReturn(conversations);

        List<AiConversation> result = service.getUserConversations(1L, 1, 20);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(conversationRepository, times(1)).findByUserId(eq(userId), anyInt(), anyInt());
    }
}
