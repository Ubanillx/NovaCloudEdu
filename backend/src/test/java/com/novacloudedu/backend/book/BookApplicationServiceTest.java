package com.novacloudedu.backend.book;

import com.novacloudedu.backend.application.book.command.UploadBookCommand;
import com.novacloudedu.backend.application.book.dto.BookDTO;
import com.novacloudedu.backend.application.service.BookApplicationService;
import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.BookParserManager;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("书籍应用服务测试")
class BookApplicationServiceTest {

    @Mock
    private BookRepository bookRepository;

    @Mock
    private ChapterRepository chapterRepository;

    @Mock
    private OssService ossService;

    @Mock
    private BookParserManager bookParserManager;

    @InjectMocks
    private BookApplicationService bookApplicationService;

    @Test
    @Order(1)
    @DisplayName("上传书籍 - 成功")
    void uploadBook_Success() {
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "test.txt",
                "text/plain",
                "测试内容".getBytes()
        );

        UploadBookCommand command = new UploadBookCommand();
        command.setFile(file);
        command.setTitle("测试书籍");
        command.setAuthor("测试作者");
        command.setAdminId(1L);

        when(ossService.uploadFile(any(), any())).thenReturn("http://oss.example.com/test.txt");
        when(bookRepository.save(any(Book.class))).thenAnswer(invocation -> {
            Book book = invocation.getArgument(0);
            book.assignId(BookId.of(1L));
            return book;
        });

        BookDTO result = bookApplicationService.uploadBook(command);

        assertNotNull(result);
        assertEquals("测试书籍", result.getTitle());
        assertEquals("测试作者", result.getAuthor());
        assertEquals("TXT", result.getFileType());

        verify(ossService, times(1)).uploadFile(any(), any());
        verify(bookRepository, times(1)).save(any(Book.class));
    }

    @Test
    @Order(2)
    @DisplayName("获取书籍 - 成功")
    void getBook_Success() {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );
        book.assignId(BookId.of(1L));

        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));

        BookDTO result = bookApplicationService.getBook(1L);

        assertNotNull(result);
        assertEquals(1L, result.getId());
        assertEquals("测试书籍", result.getTitle());

        verify(bookRepository, times(1)).findById(BookId.of(1L));
    }

    @Test
    @Order(3)
    @DisplayName("获取书籍 - 不存在抛异常")
    void getBook_NotFound_ThrowsException() {
        when(bookRepository.findById(any())).thenReturn(Optional.empty());

        assertThrows(RuntimeException.class, () -> {
            bookApplicationService.getBook(999L);
        });
    }

    @Test
    @Order(4)
    @DisplayName("列出书籍 - 成功")
    void listBooks_Success() {
        List<Book> books = new ArrayList<>();
        for (int i = 1; i <= 3; i++) {
            Book book = Book.create(
                    "书籍" + i,
                    "作者" + i,
                    null,
                    "http://example.com/book" + i + ".txt",
                    FileType.TXT,
                    1024000L,
                    UserId.of(1L)
            );
            book.assignId(BookId.of((long) i));
            books.add(book);
        }

        when(bookRepository.findAll(1, 20)).thenReturn(books);

        List<BookDTO> result = bookApplicationService.listBooks(1, 20);

        assertNotNull(result);
        assertEquals(3, result.size());
        assertEquals("书籍1", result.get(0).getTitle());

        verify(bookRepository, times(1)).findAll(1, 20);
    }

    @Test
    @Order(5)
    @DisplayName("搜索书籍 - 成功")
    void searchBooks_Success() {
        List<Book> books = new ArrayList<>();
        Book book = Book.create(
                "Java编程思想",
                "Bruce Eckel",
                null,
                "http://example.com/java.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );
        book.assignId(BookId.of(1L));
        books.add(book);

        when(bookRepository.searchByKeyword("Java", 1, 20)).thenReturn(books);

        List<BookDTO> result = bookApplicationService.searchBooks("Java", 1, 20);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertTrue(result.get(0).getTitle().contains("Java"));

        verify(bookRepository, times(1)).searchByKeyword("Java", 1, 20);
    }

    @Test
    @Order(6)
    @DisplayName("删除书籍 - 成功")
    void deleteBook_Success() {
        doNothing().when(chapterRepository).deleteByBookId(any());
        doNothing().when(bookRepository).deleteById(any());

        bookApplicationService.deleteBook(1L);

        verify(chapterRepository, times(1)).deleteByBookId(BookId.of(1L));
        verify(bookRepository, times(1)).deleteById(BookId.of(1L));
    }
}
