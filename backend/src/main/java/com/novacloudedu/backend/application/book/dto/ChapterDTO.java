package com.novacloudedu.backend.application.book.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ChapterDTO {
    private Long id;
    private Long bookId;
    private String title;
    private Integer chapterIndex;
    private Integer wordCount;
}
