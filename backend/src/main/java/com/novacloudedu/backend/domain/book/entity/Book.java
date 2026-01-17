package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Book {

    private BookId id;
    private String title;
    private String author;
    private String coverUrl;
    private String originFileUrl;
    private FileType fileType;
    private BookStatus status;
    private Integer totalChapters;
    private Integer wordCount;
    private Long fileSize;
    private UserId adminId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static Book create(String title, String author, String coverUrl,
                             String originFileUrl, FileType fileType,
                             Long fileSize, UserId adminId) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("书名不能为空");
        }
        if (originFileUrl == null || originFileUrl.trim().isEmpty()) {
            throw new IllegalArgumentException("文件URL不能为空");
        }
        if (fileType == null) {
            throw new IllegalArgumentException("文件类型不能为空");
        }
        if (adminId == null) {
            throw new IllegalArgumentException("管理员ID不能为空");
        }
        
        Book book = new Book();
        book.title = title.trim();
        book.author = author;
        book.coverUrl = coverUrl;
        book.originFileUrl = originFileUrl;
        book.fileType = fileType;
        book.status = BookStatus.UPLOADED;
        book.totalChapters = 0;
        book.wordCount = 0;
        book.fileSize = fileSize;
        book.adminId = adminId;
        book.createTime = LocalDateTime.now();
        book.updateTime = LocalDateTime.now();
        return book;
    }

    public static Book reconstruct(BookId id, String title, String author, String coverUrl,
                                  String originFileUrl, FileType fileType, BookStatus status,
                                  Integer totalChapters, Integer wordCount, Long fileSize,
                                  UserId adminId, LocalDateTime createTime, LocalDateTime updateTime) {
        Book book = new Book();
        book.id = id;
        book.title = title;
        book.author = author;
        book.coverUrl = coverUrl;
        book.originFileUrl = originFileUrl;
        book.fileType = fileType;
        book.status = status;
        book.totalChapters = totalChapters;
        book.wordCount = wordCount;
        book.fileSize = fileSize;
        book.adminId = adminId;
        book.createTime = createTime;
        book.updateTime = updateTime;
        return book;
    }

    public void assignId(BookId id) {
        if (this.id != null) {
            throw new IllegalStateException("书籍ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void startParsing() {
        if (this.status != BookStatus.UPLOADED) {
            throw new IllegalStateException("只有已上传状态的书籍才能开始解析");
        }
        this.status = BookStatus.PROCESSING;
        this.updateTime = LocalDateTime.now();
    }

    public void completeProcessing(Integer totalChapters, Integer wordCount) {
        if (this.status != BookStatus.PROCESSING) {
            throw new IllegalStateException("只有解析中的书籍才能完成处理");
        }
        this.status = BookStatus.READY;
        this.totalChapters = totalChapters;
        this.wordCount = wordCount;
        this.updateTime = LocalDateTime.now();
    }

    public void failProcessing() {
        if (this.status != BookStatus.PROCESSING) {
            throw new IllegalStateException("只有解析中的书籍才能标记为失败");
        }
        this.status = BookStatus.FAILED;
        this.updateTime = LocalDateTime.now();
    }

    public void updateBasicInfo(String title, String author, String coverUrl) {
        this.title = title;
        this.author = author;
        this.coverUrl = coverUrl;
        this.updateTime = LocalDateTime.now();
    }

    public boolean canBeRead() {
        return this.status == BookStatus.READY;
    }

    public boolean isProcessing() {
        return this.status == BookStatus.PROCESSING;
    }

    public boolean isFailed() {
        return this.status == BookStatus.FAILED;
    }
}
