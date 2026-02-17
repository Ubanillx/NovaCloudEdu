package com.novacloudedu.backend.application.book.dto;

import com.novacloudedu.backend.domain.book.entity.ReadingNote;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class ReadingNoteDTO {
    private Long id;
    private Long userId;
    private Long bookId;
    private Long chapterId;
    private Integer chapterIndex;
    private String noteContent;
    private String selectedText;
    private Integer startPosition;
    private Integer endPosition;
    private String noteColor;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static ReadingNoteDTO from(ReadingNote note) {
        return ReadingNoteDTO.builder()
                .id(note.getId())
                .userId(note.getUserId().value())
                .bookId(note.getBookId().value())
                .chapterId(note.getChapterId().value())
                .chapterIndex(note.getChapterIndex())
                .noteContent(note.getNoteContent())
                .selectedText(note.getSelectedText())
                .startPosition(note.getStartPosition())
                .endPosition(note.getEndPosition())
                .noteColor(note.getNoteColor())
                .createTime(note.getCreateTime())
                .updateTime(note.getUpdateTime())
                .build();
    }
}
