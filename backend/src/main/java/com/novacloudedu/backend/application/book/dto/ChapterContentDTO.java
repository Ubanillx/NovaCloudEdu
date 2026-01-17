package com.novacloudedu.backend.application.book.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ChapterContentDTO {
    private Long id;
    private String title;
    private Integer chapterIndex;
    private String content;
    private Integer wordCount;
}
