package com.novacloudedu.backend.book;

import com.novacloudedu.backend.application.book.command.UpdateReadingProgressCommand;
import com.novacloudedu.backend.application.book.dto.UserShelfDTO;
import com.novacloudedu.backend.application.book.service.ReadingProgressApplicationService;
import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.UserBookShelf;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.UserBookShelfRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@DisplayName("阅读进度应用服务测试")
class ReadingProgressApplicationServiceTest {

    @Mock
    private UserBookShelfRepository userBookShelfRepository;

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private ReadingProgressApplicationService readingProgressApplicationService;

    private Book createReadyBook(Long id) {
        Book book = Book.create(
                "测试书籍",
                "测试作者",
                null,
                "http://example.com/book.txt",
                FileType.TXT,
                1024000L,
                UserId.of(1L)
        );
        book.assignId(BookId.of(id));
        book.startParsing();
        book.completeProcessing(10, 50000);
        return book;
    }

    @Test
    @Order(1)
    @DisplayName("添加到书架 - 成功")
    void addToShelf_Success() {
        Book book = createReadyBook(1L);

        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));
        when(userBookShelfRepository.findByUserIdAndBookId(any(), any())).thenReturn(Optional.empty());
        when(userBookShelfRepository.save(any())).thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> {
            readingProgressApplicationService.addToShelf(1L, 1L);
        });

        verify(bookRepository, times(1)).findById(BookId.of(1L));
        verify(userBookShelfRepository, times(1)).save(any(UserBookShelf.class));
    }

    @Test
    @Order(2)
    @DisplayName("添加到书架 - 书籍不存在")
    void addToShelf_BookNotFound() {
        when(bookRepository.findById(any())).thenReturn(Optional.empty());

        assertThrows(RuntimeException.class, () -> {
            readingProgressApplicationService.addToShelf(1L, 999L);
        });
    }

    @Test
    @Order(3)
    @DisplayName("添加到书架 - 书籍未就绪")
    void addToShelf_BookNotReady() {
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

        assertThrows(RuntimeException.class, () -> {
            readingProgressApplicationService.addToShelf(1L, 1L);
        });
    }

    @Test
    @Order(4)
    @DisplayName("添加到书架 - 已存在")
    void addToShelf_AlreadyExists() {
        Book book = createReadyBook(1L);
        UserBookShelf shelf = UserBookShelf.create(UserId.of(1L), BookId.of(1L));

        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));
        when(userBookShelfRepository.findByUserIdAndBookId(any(), any())).thenReturn(Optional.of(shelf));

        assertThrows(RuntimeException.class, () -> {
            readingProgressApplicationService.addToShelf(1L, 1L);
        });
    }

    @Test
    @Order(5)
    @DisplayName("更新阅读进度 - 成功")
    void updateProgress_Success() {
        Book book = createReadyBook(1L);
        UserBookShelf shelf = UserBookShelf.create(UserId.of(1L), BookId.of(1L));

        UpdateReadingProgressCommand command = new UpdateReadingProgressCommand();
        command.setUserId(1L);
        command.setBookId(1L);
        command.setChapterIndex(5);
        command.setPosition(1000);

        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));
        when(userBookShelfRepository.findByUserIdAndBookId(any(), any())).thenReturn(Optional.of(shelf));
        when(userBookShelfRepository.save(any())).thenAnswer(invocation -> invocation.getArgument(0));

        assertDoesNotThrow(() -> {
            readingProgressApplicationService.updateProgress(command);
        });

        verify(userBookShelfRepository, times(1)).save(any(UserBookShelf.class));
    }

    @Test
    @Order(6)
    @DisplayName("获取用户书架 - 成功")
    void getUserShelf_Success() {
        Book book = createReadyBook(1L);
        UserBookShelf shelf = UserBookShelf.create(UserId.of(1L), BookId.of(1L));
        shelf.updateProgress(3, 500, 10);

        List<UserBookShelf> shelves = new ArrayList<>();
        shelves.add(shelf);

        when(userBookShelfRepository.findByUserIdOrderByLastReadTime(UserId.of(1L), 1, 20))
                .thenReturn(shelves);
        when(bookRepository.findById(BookId.of(1L))).thenReturn(Optional.of(book));

        List<UserShelfDTO> result = readingProgressApplicationService.getUserShelf(1L, 1, 20);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals(1L, result.get(0).getBookId());
        assertEquals(3, result.get(0).getLastChapterIndex());

        verify(userBookShelfRepository, times(1))
                .findByUserIdOrderByLastReadTime(UserId.of(1L), 1, 20);
    }

    @Test
    @Order(7)
    @DisplayName("从书架移除 - 成功")
    void removeFromShelf_Success() {
        doNothing().when(userBookShelfRepository).delete(any(), any());

        assertDoesNotThrow(() -> {
            readingProgressApplicationService.removeFromShelf(1L, 1L);
        });

        verify(userBookShelfRepository, times(1)).delete(UserId.of(1L), BookId.of(1L));
    }
}
