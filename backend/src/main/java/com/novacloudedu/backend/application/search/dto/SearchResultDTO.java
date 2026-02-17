package com.novacloudedu.backend.application.search.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SearchResultDTO {

    private String type;
    private Long id;
    private String title;
    private String content;
    private Double score;
    private Map<String, List<String>> highlights;

    // 书籍特有
    private String author;
    private String fileType;
    private String coverUrl;
    private Integer totalChapters;

    // 章节特有
    private Long bookId;
    private String bookTitle;
    private Integer chapterIndex;

    // 帖子特有
    private List<String> tags;
    private String postType;
    private Integer thumbNum;
    private Integer favourNum;
    private Integer commentNum;

    private LocalDateTime createTime;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class PageResult {
        private List<SearchResultDTO> items;
        private long total;
        private int page;
        private int size;
        private int totalPages;
    }
}
