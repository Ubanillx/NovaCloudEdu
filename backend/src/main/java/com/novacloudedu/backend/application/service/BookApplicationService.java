package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.book.command.UploadBookCommand;
import com.novacloudedu.backend.application.book.dto.BookDTO;
import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.IndexSyncService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import lombok.extern.slf4j.Slf4j;
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
    private final BookParseAsyncService bookParseAsyncService;

    @Autowired(required = false)
    private IndexSyncService indexSyncService;

    @Transactional
    public BookDTO uploadBook(UploadBookCommand command) {
        String originalFilename = command.getFile().getOriginalFilename();
        String fileExtension = getFileExtension(originalFilename);
        FileType fileType = FileType.fromExtension(fileExtension);

        String fileUrl = ossService.uploadFile(command.getFile(), FileBusinessType.BOOK_FILE);

        // 处理封面上传
        String coverUrl = null;
        if (command.getCover() != null && !command.getCover().isEmpty()) {
            coverUrl = ossService.uploadFile(command.getCover(), FileBusinessType.BOOK_COVER);
        }

        Book book = Book.create(
                command.getTitle(),
                command.getAuthor(),
                coverUrl,
                fileUrl,
                fileType,
                command.getFile().getSize(),
                UserId.of(command.getAdminId())
        );

        bookRepository.save(book);

        bookParseAsyncService.parseBookAsync(book.getId(), fileUrl, fileType);

        return toBookDTO(book);
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
    public BookDTO updateBook(Long bookId, String title, String author) {
        Book book = bookRepository.findById(BookId.of(bookId))
                .orElseThrow(() -> new RuntimeException("书籍不存在"));
        book.updateBasicInfo(
                title != null ? title.trim() : book.getTitle(),
                author != null ? author.trim() : book.getAuthor(),
                book.getCoverUrl()
        );
        bookRepository.save(book);

        // 同步 ES 索引
        if (indexSyncService != null) {
            indexSyncService.indexBook(book);
        }
        return toBookDTO(book);
    }

    @Transactional
    public BookDTO updateBookCover(Long bookId, org.springframework.web.multipart.MultipartFile coverFile) {
        Book book = bookRepository.findById(BookId.of(bookId))
                .orElseThrow(() -> new RuntimeException("书籍不存在"));
        String coverUrl = ossService.uploadFile(coverFile, FileBusinessType.BOOK_COVER);
        book.updateBasicInfo(book.getTitle(), book.getAuthor(), coverUrl);
        bookRepository.save(book);

        // 同步 ES 索引
        if (indexSyncService != null) {
            indexSyncService.indexBook(book);
        }
        return toBookDTO(book);
    }

    @Transactional
    public void deleteBook(Long bookId) {
        BookId id = BookId.of(bookId);
        chapterRepository.deleteByBookId(id);
        bookRepository.deleteById(id);

        // 同步删除 ES 索引
        if (indexSyncService != null) {
            indexSyncService.deleteBookIndex(bookId);
        }
    }

    public String getPdfPresignedUrl(Long bookId) {
        Book book = bookRepository.findById(BookId.of(bookId))
                .orElseThrow(() -> new RuntimeException("书籍不存在"));
        if (book.getFileType() != com.novacloudedu.backend.domain.book.valueobject.FileType.PDF) {
            throw new RuntimeException("该书籍不是PDF格式");
        }
        return ossService.generatePresignedUrl(book.getOriginFileUrl(), 3600);
    }

    private BookDTO toBookDTO(Book book) {
        return BookDTO.builder()
                .id(book.getId().value())
                .title(book.getTitle())
                .author(book.getAuthor())
                .coverUrl(book.getCoverUrl())
                .originFileUrl(book.getOriginFileUrl())
                .fileType(book.getFileType().getCode())
                .status(book.getStatus().name())
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
