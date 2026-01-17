package com.novacloudedu.backend.application.book.service;

import com.novacloudedu.backend.application.book.command.UpdateReadingProgressCommand;
import com.novacloudedu.backend.application.book.dto.UserShelfDTO;
import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.UserBookShelf;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.UserBookShelfRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReadingProgressApplicationService {

    private final UserBookShelfRepository userBookShelfRepository;
    private final BookRepository bookRepository;

    @Transactional
    public void addToShelf(Long userId, Long bookId) {
        UserId userIdVO = UserId.of(userId);
        BookId bookIdVO = BookId.of(bookId);

        Book book = bookRepository.findById(bookIdVO)
                .orElseThrow(() -> new RuntimeException("书籍不存在"));

        if (!book.canBeRead()) {
            throw new RuntimeException("书籍尚未准备好");
        }

        userBookShelfRepository.findByUserIdAndBookId(userIdVO, bookIdVO)
                .ifPresentOrElse(
                        shelf -> {
                            throw new RuntimeException("书籍已在书架中");
                        },
                        () -> {
                            UserBookShelf shelf = UserBookShelf.create(userIdVO, bookIdVO);
                            userBookShelfRepository.save(shelf);
                        }
                );
    }

    @Transactional
    public void updateProgress(UpdateReadingProgressCommand command) {
        UserId userId = UserId.of(command.getUserId());
        BookId bookId = BookId.of(command.getBookId());

        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new RuntimeException("书籍不存在"));

        UserBookShelf shelf = userBookShelfRepository.findByUserIdAndBookId(userId, bookId)
                .orElseGet(() -> UserBookShelf.create(userId, bookId));

        shelf.updateProgress(
                command.getChapterIndex(),
                command.getPosition(),
                book.getTotalChapters()
        );

        userBookShelfRepository.save(shelf);
    }

    public List<UserShelfDTO> getUserShelf(Long userId, int page, int size) {
        UserId userIdVO = UserId.of(userId);
        List<UserBookShelf> shelves = userBookShelfRepository
                .findByUserIdOrderByLastReadTime(userIdVO, page, size);

        return shelves.stream()
                .map(shelf -> {
                    Book book = bookRepository.findById(shelf.getBookId())
                            .orElse(null);
                    return toUserShelfDTO(shelf, book);
                })
                .collect(Collectors.toList());
    }

    @Transactional
    public void removeFromShelf(Long userId, Long bookId) {
        userBookShelfRepository.delete(UserId.of(userId), BookId.of(bookId));
    }

    private UserShelfDTO toUserShelfDTO(UserBookShelf shelf, Book book) {
        return UserShelfDTO.builder()
                .userId(shelf.getUserId().value())
                .bookId(shelf.getBookId().value())
                .bookTitle(book != null ? book.getTitle() : "未知")
                .bookAuthor(book != null ? book.getAuthor() : "未知")
                .bookCoverUrl(book != null ? book.getCoverUrl() : null)
                .lastChapterIndex(shelf.getLastChapterIndex())
                .lastPosition(shelf.getLastPosition())
                .readingProgress(shelf.getReadingProgress())
                .addedTime(shelf.getAddedTime())
                .lastReadTime(shelf.getLastReadTime())
                .build();
    }
}
