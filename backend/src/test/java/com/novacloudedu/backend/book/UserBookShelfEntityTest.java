package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.entity.UserBookShelf;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.*;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("用户书架实体测试")
class UserBookShelfEntityTest {

    @Test
    @Order(1)
    @DisplayName("创建书架记录 - 成功")
    void createShelf_Success() {
        UserBookShelf shelf = UserBookShelf.create(
                UserId.of(1L),
                BookId.of(100L)
        );

        assertNotNull(shelf);
        assertEquals(1L, shelf.getUserId().value());
        assertEquals(100L, shelf.getBookId().value());
        assertEquals(0, shelf.getLastChapterIndex());
        assertEquals(0, shelf.getLastPosition());
        assertEquals(BigDecimal.ZERO, shelf.getReadingProgress());
        assertNotNull(shelf.getAddedTime());
    }

    @Test
    @Order(2)
    @DisplayName("更新阅读进度 - 成功")
    void updateProgress_Success() {
        UserBookShelf shelf = UserBookShelf.create(
                UserId.of(1L),
                BookId.of(100L)
        );

        shelf.updateProgress(5, 1000, 10);

        assertEquals(5, shelf.getLastChapterIndex());
        assertEquals(1000, shelf.getLastPosition());
        assertNotNull(shelf.getLastReadTime());
        
        BigDecimal expectedProgress = new BigDecimal("60.00");
        assertEquals(0, expectedProgress.compareTo(shelf.getReadingProgress()));
    }

    @Test
    @Order(3)
    @DisplayName("更新阅读进度 - 计算百分比")
    void updateProgress_CalculatePercentage() {
        UserBookShelf shelf = UserBookShelf.create(
                UserId.of(1L),
                BookId.of(100L)
        );

        shelf.updateProgress(3, 500, 10);
        BigDecimal progress = shelf.getReadingProgress();
        
        assertTrue(progress.compareTo(BigDecimal.ZERO) > 0);
        assertTrue(progress.compareTo(new BigDecimal("100")) <= 0);
    }

    @Test
    @Order(4)
    @DisplayName("更新阅读进度 - 最后一章")
    void updateProgress_LastChapter() {
        UserBookShelf shelf = UserBookShelf.create(
                UserId.of(1L),
                BookId.of(100L)
        );

        shelf.updateProgress(9, 5000, 10);

        BigDecimal expectedProgress = new BigDecimal("100.00");
        assertEquals(0, expectedProgress.compareTo(shelf.getReadingProgress()));
    }

    @Test
    @Order(5)
    @DisplayName("更新阅读进度 - 无效章节索引")
    void updateProgress_InvalidChapterIndex() {
        UserBookShelf shelf = UserBookShelf.create(
                UserId.of(1L),
                BookId.of(100L)
        );

        assertThrows(IllegalArgumentException.class, () -> {
            shelf.updateProgress(-1, 0, 10);
        });
    }

    @Test
    @Order(6)
    @DisplayName("更新阅读进度 - 无效位置")
    void updateProgress_InvalidPosition() {
        UserBookShelf shelf = UserBookShelf.create(
                UserId.of(1L),
                BookId.of(100L)
        );

        assertThrows(IllegalArgumentException.class, () -> {
            shelf.updateProgress(0, -100, 10);
        });
    }
}
