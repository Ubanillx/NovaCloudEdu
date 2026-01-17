package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ReadingPosition;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserBookShelf {

    private UserId userId;
    private BookId bookId;
    private Integer lastChapterIndex;
    private Integer lastPosition;
    private BigDecimal readingProgress;
    private LocalDateTime addedTime;
    private LocalDateTime lastReadTime;

    public static UserBookShelf create(UserId userId, BookId bookId) {
        UserBookShelf shelf = new UserBookShelf();
        shelf.userId = userId;
        shelf.bookId = bookId;
        shelf.lastChapterIndex = 0;
        shelf.lastPosition = 0;
        shelf.readingProgress = BigDecimal.ZERO;
        shelf.addedTime = LocalDateTime.now();
        shelf.lastReadTime = LocalDateTime.now();
        return shelf;
    }

    public static UserBookShelf reconstruct(UserId userId, BookId bookId,
                                           Integer lastChapterIndex, Integer lastPosition,
                                           BigDecimal readingProgress,
                                           LocalDateTime addedTime, LocalDateTime lastReadTime) {
        UserBookShelf shelf = new UserBookShelf();
        shelf.userId = userId;
        shelf.bookId = bookId;
        shelf.lastChapterIndex = lastChapterIndex;
        shelf.lastPosition = lastPosition;
        shelf.readingProgress = readingProgress;
        shelf.addedTime = addedTime;
        shelf.lastReadTime = lastReadTime;
        return shelf;
    }

    public void updateProgress(ReadingPosition position, Integer totalChapters) {
        this.lastChapterIndex = position.chapterIndex();
        this.lastPosition = position.offset();
        this.readingProgress = calculateProgress(position.chapterIndex(), totalChapters);
        this.lastReadTime = LocalDateTime.now();
    }

    public void updateProgress(Integer chapterIndex, Integer offset, Integer totalChapters) {
        if (chapterIndex == null || chapterIndex < 0) {
            throw new IllegalArgumentException("章节索引不能为空或负数");
        }
        if (offset == null || offset < 0) {
            throw new IllegalArgumentException("阅读位置不能为空或负数");
        }
        if (totalChapters == null || totalChapters <= 0) {
            throw new IllegalArgumentException("总章节数必须大于0");
        }
        
        this.lastChapterIndex = chapterIndex;
        this.lastPosition = offset;
        this.readingProgress = calculateProgress(chapterIndex, totalChapters);
        this.lastReadTime = LocalDateTime.now();
    }

    public ReadingPosition getReadingPosition() {
        return ReadingPosition.of(lastChapterIndex, lastPosition);
    }

    public boolean isFinished() {
        return readingProgress.compareTo(new BigDecimal("100.00")) >= 0;
    }

    public boolean isStarted() {
        return lastChapterIndex > 0 || lastPosition > 0;
    }

    private BigDecimal calculateProgress(Integer currentChapter, Integer totalChapters) {
        if (totalChapters == null || totalChapters == 0) {
            return BigDecimal.ZERO;
        }
        
        if (currentChapter >= totalChapters - 1) {
            return BigDecimal.valueOf(100.00).setScale(2, RoundingMode.HALF_UP);
        }
        
        BigDecimal progress = BigDecimal.valueOf(currentChapter + 1)
                .divide(BigDecimal.valueOf(totalChapters), 4, RoundingMode.HALF_UP)
                .multiply(BigDecimal.valueOf(100));
        
        if (progress.compareTo(BigDecimal.valueOf(100)) > 0) {
            return BigDecimal.valueOf(100.00).setScale(2, RoundingMode.HALF_UP);
        }
        return progress.setScale(2, RoundingMode.HALF_UP);
    }
}
