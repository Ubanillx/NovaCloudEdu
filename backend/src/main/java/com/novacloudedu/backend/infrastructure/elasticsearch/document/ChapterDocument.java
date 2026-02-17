package com.novacloudedu.backend.infrastructure.elasticsearch.document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChapterDocument {

    private Long id;

    private Long bookId;

    private String bookTitle;

    private String title;

    private Integer chapterIndex;

    private String content;

    private Integer wordCount;
}
