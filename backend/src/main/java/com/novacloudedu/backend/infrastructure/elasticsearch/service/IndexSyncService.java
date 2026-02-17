package com.novacloudedu.backend.infrastructure.elasticsearch.service;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.domain.post.entity.Post;
import com.novacloudedu.backend.domain.post.repository.PostRepository;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.BookDocument;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.ChapterDocument;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.PostDocument;
import com.novacloudedu.backend.infrastructure.elasticsearch.repository.BookEsRepository;
import com.novacloudedu.backend.infrastructure.elasticsearch.repository.ChapterEsRepository;
import com.novacloudedu.backend.infrastructure.elasticsearch.repository.PostEsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@ConditionalOnProperty(name = "search.elasticsearch.enabled", havingValue = "true")
public class IndexSyncService {

    private final BookRepository bookRepository;
    private final ChapterRepository chapterRepository;
    private final PostRepository postRepository;
    private final BookEsRepository bookEsRepository;
    private final ChapterEsRepository chapterEsRepository;
    private final PostEsRepository postEsRepository;

    // ==================== 增量同步 ====================

    @Async
    public void indexBook(Book book) {
        try {
            BookDocument doc = toBookDocument(book);
            bookEsRepository.save(doc);
            log.debug("书籍索引同步成功: bookId={}", book.getId().value());
        } catch (Exception e) {
            log.error("书籍索引同步失败: bookId={}", book.getId().value(), e);
        }
    }

    @Async
    public void indexBookWithChapters(Book book, List<Chapter> chapters) {
        try {
            bookEsRepository.save(toBookDocument(book));

            List<ChapterDocument> chapterDocs = chapters.stream()
                    .map(ch -> toChapterDocument(ch, book.getTitle()))
                    .toList();
            chapterEsRepository.bulkSave(chapterDocs);

            log.info("书籍+章节索引同步成功: bookId={}, chapters={}", book.getId().value(), chapters.size());
        } catch (Exception e) {
            log.error("书籍+章节索引同步失败: bookId={}", book.getId().value(), e);
        }
    }

    @Async
    public void deleteBookIndex(Long bookId) {
        try {
            bookEsRepository.deleteById(bookId);
            chapterEsRepository.deleteByBookId(bookId);
            log.info("书籍索引删除成功: bookId={}", bookId);
        } catch (Exception e) {
            log.error("书籍索引删除失败: bookId={}", bookId, e);
        }
    }

    @Async
    public void indexPost(Post post) {
        try {
            PostDocument doc = toPostDocument(post);
            postEsRepository.save(doc);
            log.debug("帖子索引同步成功: postId={}", post.getId().value());
        } catch (Exception e) {
            log.error("帖子索引同步失败: postId={}", post.getId().value(), e);
        }
    }

    @Async
    public void deletePostIndex(Long postId) {
        try {
            postEsRepository.deleteById(postId);
            log.debug("帖子索引删除成功: postId={}", postId);
        } catch (Exception e) {
            log.error("帖子索引删除失败: postId={}", postId, e);
        }
    }

    // ==================== 全量重建 ====================

    public int reindexBooks() {
        int page = 1;
        int size = 100;
        int total = 0;
        while (true) {
            List<Book> books = bookRepository.findByStatus(BookStatus.READY, page, size);
            if (books.isEmpty()) break;

            List<BookDocument> docs = books.stream().map(this::toBookDocument).toList();
            bookEsRepository.bulkSave(docs);
            total += docs.size();

            // 同时索引每本书的章节
            for (Book book : books) {
                List<Chapter> chapters = chapterRepository.findByBookId(book.getId());
                List<ChapterDocument> chapterDocs = chapters.stream()
                        .map(ch -> toChapterDocument(ch, book.getTitle()))
                        .toList();
                chapterEsRepository.bulkSave(chapterDocs);
            }
            page++;
        }
        log.info("书籍全量重建索引完成: total={}", total);
        return total;
    }

    public int reindexChapters() {
        // 章节跟随书籍一起索引，此方法用于单独重建
        int page = 1;
        int size = 100;
        int total = 0;
        while (true) {
            List<Book> books = bookRepository.findByStatus(BookStatus.READY, page, size);
            if (books.isEmpty()) break;
            for (Book book : books) {
                List<Chapter> chapters = chapterRepository.findByBookId(book.getId());
                List<ChapterDocument> chapterDocs = chapters.stream()
                        .map(ch -> toChapterDocument(ch, book.getTitle()))
                        .toList();
                chapterEsRepository.bulkSave(chapterDocs);
                total += chapterDocs.size();
            }
            page++;
        }
        log.info("章节全量重建索引完成: total={}", total);
        return total;
    }

    public int reindexPosts() {
        int page = 1;
        int size = 100;
        int total = 0;
        while (true) {
            PostRepository.PostPage postPage = postRepository.findAll(page, size);
            if (postPage.posts().isEmpty()) break;

            List<PostDocument> docs = postPage.posts().stream().map(this::toPostDocument).toList();
            postEsRepository.bulkSave(docs);
            total += docs.size();
            page++;
        }
        log.info("帖子全量重建索引完成: total={}", total);
        return total;
    }

    // ==================== 转换方法 ====================

    private BookDocument toBookDocument(Book book) {
        return BookDocument.builder()
                .id(book.getId().value())
                .title(book.getTitle())
                .author(book.getAuthor())
                .fileType(book.getFileType() != null ? book.getFileType().name() : null)
                .status(book.getStatus() != null ? book.getStatus().getCode() : null)
                .totalChapters(book.getTotalChapters())
                .wordCount(book.getWordCount())
                .coverUrl(book.getCoverUrl())
                .createTime(book.getCreateTime())
                .build();
    }

    private ChapterDocument toChapterDocument(Chapter chapter, String bookTitle) {
        // 去除 HTML 标签用于索引
        String plainContent = chapter.getContent() != null
                ? chapter.getContent().replaceAll("<[^>]+>", " ").replaceAll("\\s+", " ").trim()
                : "";
        return ChapterDocument.builder()
                .id(chapter.getId().value())
                .bookId(chapter.getBookId().value())
                .bookTitle(bookTitle)
                .title(chapter.getTitle())
                .chapterIndex(chapter.getChapterIndex())
                .content(plainContent)
                .wordCount(chapter.getWordCount())
                .build();
    }

    private PostDocument toPostDocument(Post post) {
        return PostDocument.builder()
                .id(post.getId().value())
                .title(post.getTitle())
                .content(post.getContent())
                .tags(post.getTags())
                .postType(post.getPostType() != null ? post.getPostType().getCode() : null)
                .userId(post.getUserId().value())
                .thumbNum(post.getThumbNum())
                .favourNum(post.getFavourNum())
                .commentNum(post.getCommentNum())
                .createTime(post.getCreateTime())
                .build();
    }
}
