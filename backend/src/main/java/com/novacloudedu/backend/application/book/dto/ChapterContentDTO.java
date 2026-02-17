package com.novacloudedu.backend.application.book.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChapterContentDTO {
    private Long id;
    private String title;
    private Integer chapterIndex;
    private String content;
    private Integer wordCount;
}
