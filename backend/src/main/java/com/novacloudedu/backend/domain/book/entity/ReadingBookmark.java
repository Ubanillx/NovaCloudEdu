package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReadingBookmark {

    private Long id;
    private UserId userId;
    private BookId bookId;
    private ChapterId chapterId;
    private Integer chapterIndex;
    private Integer position;
    private String bookmarkTitle;
    private String note;
    private LocalDateTime createTime;

    public static ReadingBookmark create(UserId userId, BookId bookId, ChapterId chapterId,
                                        Integer chapterIndex, Integer position,
                                        String bookmarkTitle, String note) {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        if (bookId == null) {
            throw new IllegalArgumentException("书籍ID不能为空");
        }
        if (chapterId == null) {
            throw new IllegalArgumentException("章节ID不能为空");
        }
        if (chapterIndex == null || chapterIndex < 0) {
            throw new IllegalArgumentException("章节索引无效");
        }
        if (position == null || position < 0) {
            throw new IllegalArgumentException("位置无效");
        }

        ReadingBookmark bookmark = new ReadingBookmark();
        bookmark.userId = userId;
        bookmark.bookId = bookId;
        bookmark.chapterId = chapterId;
        bookmark.chapterIndex = chapterIndex;
        bookmark.position = position;
        bookmark.bookmarkTitle = bookmarkTitle != null ? bookmarkTitle.trim() : 
                "书签 - 第" + (chapterIndex + 1) + "章";
        bookmark.note = note;
        bookmark.createTime = LocalDateTime.now();
        return bookmark;
    }

    public static ReadingBookmark reconstruct(Long id, UserId userId, BookId bookId,
                                             ChapterId chapterId, Integer chapterIndex,
                                             Integer position, String bookmarkTitle,
                                             String note, LocalDateTime createTime) {
        ReadingBookmark bookmark = new ReadingBookmark();
        bookmark.id = id;
        bookmark.userId = userId;
        bookmark.bookId = bookId;
        bookmark.chapterId = chapterId;
        bookmark.chapterIndex = chapterIndex;
        bookmark.position = position;
        bookmark.bookmarkTitle = bookmarkTitle;
        bookmark.note = note;
        bookmark.createTime = createTime;
        return bookmark;
    }

    public void updateNote(String newNote) {
        this.note = newNote;
    }

    public void updateTitle(String newTitle) {
        if (newTitle != null && !newTitle.trim().isEmpty()) {
            this.bookmarkTitle = newTitle.trim();
        }
    }
}
