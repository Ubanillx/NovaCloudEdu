package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("书籍实体测试")
class BookEntityTest {

    @Test
    @Order(1)
    @DisplayName("创建书籍 - 成功")
    void createBook_Success() {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                "http://example.com/cover.jpg",
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );

        assertNotNull(book);
        assertEquals("测试书籍", book.getTitle());
        assertEquals("测试作者", book.getAuthor());
        assertEquals(FileType.TXT, book.getFileType());
        assertEquals(BookStatus.UPLOADED, book.getStatus());
        assertEquals(1024000L, book.getFileSize());
        assertNotNull(book.getCreateTime());
    }

    @Test
    @Order(2)
    @DisplayName("创建书籍 - 标题为空抛异常")
    void createBook_EmptyTitle_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> {
            Book.create(
                    "",
                    "测试作者",
                    null,
                    "http://example.com/book.txt",
                    FileType.TXT,
                    1024000L,
                    UserId.of(1L)
            );
        });
    }

    @Test
    @Order(3)
    @DisplayName("书籍状态转换 - 开始解析")
    void bookStatusTransition_StartParsing() {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );

        book.startParsing();
        assertEquals(BookStatus.PROCESSING, book.getStatus());
    }

    @Test
    @Order(4)
    @DisplayName("书籍状态转换 - 完成处理")
    void bookStatusTransition_CompleteProcessing() {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );

        book.startParsing();
        book.completeProcessing(10, 50000);

        assertEquals(BookStatus.READY, book.getStatus());
        assertEquals(10, book.getTotalChapters());
        assertEquals(50000, book.getWordCount());
    }

    @Test
    @Order(5)
    @DisplayName("书籍状态转换 - 处理失败")
    void bookStatusTransition_FailProcessing() {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );

        book.startParsing();
        book.failProcessing();

        assertEquals(BookStatus.FAILED, book.getStatus());
    }

    @Test
    @Order(6)
    @DisplayName("检查书籍是否可读")
    void checkBookCanBeRead() {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );

        assertFalse(book.canBeRead());

        book.startParsing();
        assertFalse(book.canBeRead());

        book.completeProcessing(10, 50000);
        assertTrue(book.canBeRead());
    }

    @Test
    @Order(7)
    @DisplayName("更新书籍信息")
    void updateBookInfo() {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );

        book.updateBasicInfo("新标题", "新作者", "http://example.com/new-cover.jpg");

        assertEquals("新标题", book.getTitle());
        assertEquals("新作者", book.getAuthor());
        assertEquals("http://example.com/new-cover.jpg", book.getCoverUrl());
    }
}
