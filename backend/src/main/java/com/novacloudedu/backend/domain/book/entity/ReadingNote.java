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
public class ReadingNote {

    private Long id;
    private UserId userId;
    private BookId bookId;
    private ChapterId chapterId;
    private Integer chapterIndex;
    private String noteContent;
    private String selectedText;
    private Integer startPosition;
    private Integer endPosition;
    private String noteColor;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static ReadingNote create(UserId userId, BookId bookId, ChapterId chapterId,
                                    Integer chapterIndex, String noteContent, 
                                    String selectedText, Integer startPosition, 
                                    Integer endPosition, String noteColor) {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        if (bookId == null) {
            throw new IllegalArgumentException("书籍ID不能为空");
        }
        if (chapterId == null) {
            throw new IllegalArgumentException("章节ID不能为空");
        }
        if (noteContent == null || noteContent.trim().isEmpty()) {
            throw new IllegalArgumentException("笔记内容不能为空");
        }

        ReadingNote note = new ReadingNote();
        note.userId = userId;
        note.bookId = bookId;
        note.chapterId = chapterId;
        note.chapterIndex = chapterIndex;
        note.noteContent = noteContent.trim();
        note.selectedText = selectedText;
        note.startPosition = startPosition;
        note.endPosition = endPosition;
        note.noteColor = noteColor != null ? noteColor : "#FFEB3B";
        note.createTime = LocalDateTime.now();
        note.updateTime = LocalDateTime.now();
        return note;
    }

    public static ReadingNote reconstruct(Long id, UserId userId, BookId bookId, 
                                         ChapterId chapterId, Integer chapterIndex,
                                         String noteContent, String selectedText,
                                         Integer startPosition, Integer endPosition,
                                         String noteColor, LocalDateTime createTime,
                                         LocalDateTime updateTime) {
        ReadingNote note = new ReadingNote();
        note.id = id;
        note.userId = userId;
        note.bookId = bookId;
        note.chapterId = chapterId;
        note.chapterIndex = chapterIndex;
        note.noteContent = noteContent;
        note.selectedText = selectedText;
        note.startPosition = startPosition;
        note.endPosition = endPosition;
        note.noteColor = noteColor;
        note.createTime = createTime;
        note.updateTime = updateTime;
        return note;
    }

    public void updateContent(String newContent) {
        if (newContent == null || newContent.trim().isEmpty()) {
            throw new IllegalArgumentException("笔记内容不能为空");
        }
        this.noteContent = newContent.trim();
        this.updateTime = LocalDateTime.now();
    }

    public void updateColor(String newColor) {
        this.noteColor = newColor;
        this.updateTime = LocalDateTime.now();
    }
}
