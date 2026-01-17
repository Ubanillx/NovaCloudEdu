package com.novacloudedu.backend.application.book.service;

import com.novacloudedu.backend.application.book.command.UploadBookCommand;
import com.novacloudedu.backend.application.book.dto.BookDTO;
import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.BookParserManager;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class BookApplicationService {

    private final BookRepository bookRepository;
    private final ChapterRepository chapterRepository;
    private final OssService ossService;
    private final BookParserManager bookParserManager;

    @Transactional
    public BookDTO uploadBook(UploadBookCommand command) {
        String originalFilename = command.getFile().getOriginalFilename();
        String fileExtension = getFileExtension(originalFilename);
        FileType fileType = FileType.fromExtension(fileExtension);

        String fileUrl = ossService.uploadFile(command.getFile(), FileBusinessType.BOOK_FILE);

        Book book = Book.create(
                command.getTitle(),
                command.getAuthor(),
                null,
                fileUrl,
                fileType,
                command.getFile().getSize(),
                UserId.of(command.getAdminId())
        );

        bookRepository.save(book);

        parseBookAsync(book.getId(), fileUrl, fileType);

        return toBookDTO(book);
    }

    @Async
    public void parseBookAsync(BookId bookId, String fileUrl, FileType fileType) {
        try {
            Book book = bookRepository.findById(bookId)
                    .orElseThrow(() -> new RuntimeException("书籍不存在"));

            book.startParsing();
            bookRepository.save(book);

            ParsedBook parsedBook = bookParserManager.parse(fileUrl, fileType);

            List<Chapter> chapters = parsedBook.getChapters().stream()
                    .map(pc -> Chapter.create(
                            bookId,
                            pc.getTitle(),
                            pc.getChapterIndex(),
                            pc.getContent()
                    ))
                    .collect(Collectors.toList());

            chapterRepository.saveAll(chapters);

            int totalWordCount = chapters.stream()
                    .mapToInt(Chapter::getWordCount)
                    .sum();

            book.completeProcessing(chapters.size(), totalWordCount);
            bookRepository.save(book);

            log.info("书籍解析完成: bookId={}, chapters={}, words={}", 
                    bookId, chapters.size(), totalWordCount);

        } catch (Exception e) {
            log.error("书籍解析失败: bookId={}", bookId, e);
            Book book = bookRepository.findById(bookId).orElse(null);
            if (book != null) {
                book.failProcessing();
                bookRepository.save(book);
            }
        }
    }

    public BookDTO getBook(Long bookId) {
        Book book = bookRepository.findById(BookId.of(bookId))
                .orElseThrow(() -> new RuntimeException("书籍不存在"));
        return toBookDTO(book);
    }

    public List<BookDTO> listBooks(int page, int size) {
        return bookRepository.findAll(page, size).stream()
                .map(this::toBookDTO)
                .collect(Collectors.toList());
    }

    public List<BookDTO> searchBooks(String keyword, int page, int size) {
        return bookRepository.searchByKeyword(keyword, page, size).stream()
                .map(this::toBookDTO)
                .collect(Collectors.toList());
    }

    @Transactional
    public void deleteBook(Long bookId) {
        BookId id = BookId.of(bookId);
        chapterRepository.deleteByBookId(id);
        bookRepository.deleteById(id);
    }

    private BookDTO toBookDTO(Book book) {
        return BookDTO.builder()
                .id(book.getId().value())
                .title(book.getTitle())
                .author(book.getAuthor())
                .coverUrl(book.getCoverUrl())
                .fileType(book.getFileType().getCode())
                .status(book.getStatus().getDescription())
                .totalChapters(book.getTotalChapters())
                .wordCount(book.getWordCount())
                .fileSize(book.getFileSize())
                .createTime(book.getCreateTime())
                .updateTime(book.getUpdateTime())
                .build();
    }

    private String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            throw new IllegalArgumentException("无效的文件名");
        }
        return filename.substring(filename.lastIndexOf(".") + 1);
    }
}
