package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.infrastructure.search.PostgresBookSearchService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

@DisplayName("书籍搜索服务测试")
@ExtendWith(MockitoExtension.class)
class BookSearchServiceTest {

    @Mock
    private BookRepository bookRepository;

    @Mock
    private ChapterRepository chapterRepository;

    private PostgresBookSearchService searchService;

    @BeforeEach
    void setUp() {
        searchService = new PostgresBookSearchService(bookRepository, chapterRepository);
    }

    @Test
    @DisplayName("搜索书籍成功")
    void searchBooks_Success() {
        List<Book> mockBooks = Arrays.asList(
                createMockBook(1L, "机器学习入门", "张三"),
                createMockBook(2L, "深度学习实战", "李四")
        );

        when(bookRepository.searchByKeyword(anyString(), anyInt(), anyInt()))
                .thenReturn(mockBooks);

        List<Book> results = searchService.searchBooks("机器学习", 1, 20);

        assertNotNull(results);
        assertEquals(2, results.size());
        assertEquals("机器学习入门", results.get(0).getTitle());
    }

    @Test
    @DisplayName("搜索结果高亮显示")
    void highlightSearchResult_Success() {
        String content = "这是一段关于机器学习的介绍文本，机器学习是人工智能的重要分支。";
        String keyword = "机器学习";

        String highlighted = searchService.highlightSearchResult(content, keyword);

        assertTrue(highlighted.contains("<mark class=\"search-highlight\">机器学习</mark>"));
        // 应该高亮两次出现的关键词
        int count = highlighted.split("<mark class=\"search-highlight\">机器学习</mark>").length - 1;
        assertEquals(2, count);
    }

    @Test
    @DisplayName("搜索结果高亮 - 大小写不敏感")
    void highlightSearchResult_CaseInsensitive() {
        String content = "Machine Learning and machine learning are the same.";
        String keyword = "machine learning";

        String highlighted = searchService.highlightSearchResult(content, keyword);

        assertTrue(highlighted.contains("<mark class=\"search-highlight\">Machine Learning</mark>"));
        assertTrue(highlighted.contains("<mark class=\"search-highlight\">machine learning</mark>"));
    }

    @Test
    @DisplayName("搜索结果高亮 - 空关键词返回原文")
    void highlightSearchResult_EmptyKeyword() {
        String content = "这是一段测试文本";

        String highlighted = searchService.highlightSearchResult(content, "");

        assertEquals(content, highlighted);
    }

    @Test
    @DisplayName("搜索结果高亮 - null关键词返回原文")
    void highlightSearchResult_NullKeyword() {
        String content = "这是一段测试文本";

        String highlighted = searchService.highlightSearchResult(content, null);

        assertEquals(content, highlighted);
    }

    @Test
    @DisplayName("搜索结果高亮 - null内容返回null")
    void highlightSearchResult_NullContent() {
        String highlighted = searchService.highlightSearchResult(null, "关键词");

        assertNull(highlighted);
    }

    @Test
    @DisplayName("搜索书籍 - 空结果")
    void searchBooks_EmptyResult() {
        when(bookRepository.searchByKeyword(anyString(), anyInt(), anyInt()))
                .thenReturn(Arrays.asList());

        List<Book> results = searchService.searchBooks("不存在的书籍", 1, 20);

        assertNotNull(results);
        assertTrue(results.isEmpty());
    }

    private Book createMockBook(Long id, String title, String author) {
        // 使用 reconstruct 方法创建 Book 对象用于测试
        return Book.reconstruct(
                com.novacloudedu.backend.domain.book.valueobject.BookId.of(id),
                title,
                author,
                null,
                "file:///test.txt",
                com.novacloudedu.backend.domain.book.valueobject.FileType.TXT,
                com.novacloudedu.backend.domain.book.valueobject.BookStatus.READY,
                10,
                100000,
                1024000L,
                com.novacloudedu.backend.domain.user.valueobject.UserId.of(1L),
                java.time.LocalDateTime.now(),
                java.time.LocalDateTime.now()
        );
    }
}
