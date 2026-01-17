package com.novacloudedu.backend.domain.book.service;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class ParsedBook {
    private String title;
    private String author;
    private String coverUrl;
    private List<ParsedChapter> chapters;

    @Getter
    @Builder
    public static class ParsedChapter {
        private String title;
        private Integer chapterIndex;
        private String content;
    }
}
