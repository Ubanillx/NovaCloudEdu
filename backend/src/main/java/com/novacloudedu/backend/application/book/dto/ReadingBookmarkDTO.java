package com.novacloudedu.backend.application.book.dto;

import com.novacloudedu.backend.domain.book.entity.ReadingBookmark;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class ReadingBookmarkDTO {
    private Long id;
    private Long userId;
    private Long bookId;
    private Long chapterId;
    private Integer chapterIndex;
    private Integer position;
    private String bookmarkTitle;
    private String note;
    private LocalDateTime createTime;

    public static ReadingBookmarkDTO from(ReadingBookmark bookmark) {
        return ReadingBookmarkDTO.builder()
                .id(bookmark.getId())
                .userId(bookmark.getUserId().value())
                .bookId(bookmark.getBookId().value())
                .chapterId(bookmark.getChapterId().value())
                .chapterIndex(bookmark.getChapterIndex())
                .position(bookmark.getPosition())
                .bookmarkTitle(bookmark.getBookmarkTitle())
                .note(bookmark.getNote())
                .createTime(bookmark.getCreateTime())
                .build();
    }
}
