package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.BookParserManager;
import com.novacloudedu.backend.domain.book.service.ContentSecurityService;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.IndexSyncService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class BookParseAsyncService {

    private final BookRepository bookRepository;
    private final ChapterRepository chapterRepository;
    private final BookParserManager bookParserManager;
    private final ContentSecurityService contentSecurityService;
    private final TransactionTemplate transactionTemplate;

    @Value("${book.content.encryption.enabled:false}")
    private boolean encryptionEnabled;

    @Value("${book.content.encryption.secret-key:NovaCloudEduBookKey1}")
    private String encryptionSecretKey;

    @Autowired(required = false)
    private IndexSyncService indexSyncService;

    @Async
    public void parseBookAsync(BookId bookId, String fileUrl, FileType fileType) {
        try {
            // 阶段1: 标记为解析中（独立事务）
            transactionTemplate.executeWithoutResult(status -> {
                Book book = bookRepository.findById(bookId)
                        .orElseThrow(() -> new RuntimeException("书籍不存在"));
                book.startParsing();
                bookRepository.save(book);
            });

            // PDF 不进行文字解析，直接标记为就绪，前端用 PDF 阅读器展示原文件
            if (fileType == FileType.PDF) {
                transactionTemplate.executeWithoutResult(status -> {
                    Book book = bookRepository.findById(bookId)
                            .orElseThrow(() -> new RuntimeException("书籍不存在"));
                    book.completeProcessing(0, 0);
                    bookRepository.save(book);

                    if (indexSyncService != null) {
                        indexSyncService.indexBook(book);
                    }
                });
                log.info("PDF书籍已标记就绪(不解析文字): bookId={}", bookId);
                return;
            }

            // 阶段2: 解析文件（不在事务中，纯计算）
            ParsedBook parsedBook = bookParserManager.parse(fileUrl, fileType);

            List<Chapter> chapters = parsedBook.getChapters().stream()
                    .map(pc -> Chapter.create(
                            bookId,
                            pc.getTitle(),
                            pc.getChapterIndex(),
                            pc.getContent()
                    ))
                    .collect(Collectors.toList());

            // 阶段2.5: 如果启用了加密，对每个章节内容进行AES加密（wordCount已在create时计算）
            if (encryptionEnabled) {
                for (Chapter chapter : chapters) {
                    ContentSecurityService.EncryptedContent encrypted =
                            contentSecurityService.encrypt(chapter.getContent(), encryptionSecretKey);
                    chapter.setEncryptedContent(encrypted.getContent(), encrypted.getIv());
                }
                log.info("书籍章节已自动加密: bookId={}, chapters={}", bookId, chapters.size());
            }

            // 阶段3: 保存章节 + 更新书籍状态（独立事务）
            transactionTemplate.executeWithoutResult(status -> {
                chapterRepository.saveAll(chapters);

                int totalWordCount = chapters.stream()
                        .mapToInt(Chapter::getWordCount)
                        .sum();

                Book book = bookRepository.findById(bookId)
                        .orElseThrow(() -> new RuntimeException("书籍不存在"));
                book.completeProcessing(chapters.size(), totalWordCount);
                bookRepository.save(book);

                // 同步 ES 索引
                if (indexSyncService != null) {
                    indexSyncService.indexBookWithChapters(book, chapters);
                }
            });

            log.info("书籍解析完成: bookId={}, chapters={}, words={}",
                    bookId, chapters.size(),
                    chapters.stream().mapToInt(Chapter::getWordCount).sum());

        } catch (Exception e) {
            log.error("书籍解析失败: bookId={}", bookId, e);
            // 阶段4: 标记失败（独立事务，不受前面异常影响）
            try {
                transactionTemplate.executeWithoutResult(status -> {
                    Book book = bookRepository.findById(bookId).orElse(null);
                    if (book != null) {
                        book.failProcessing();
                        bookRepository.save(book);
                    }
                });
            } catch (Exception ex) {
                log.error("更新书籍失败状态异常: bookId={}", bookId, ex);
            }
        }
    }
}
