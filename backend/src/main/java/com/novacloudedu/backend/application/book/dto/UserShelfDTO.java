package com.novacloudedu.backend.application.book.dto;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class UserShelfDTO {
    private Long userId;
    private Long bookId;
    private String bookTitle;
    private String bookAuthor;
    private String bookCoverUrl;
    private Integer lastChapterIndex;
    private Integer lastPosition;
    private BigDecimal readingProgress;
    private LocalDateTime addedTime;
    private LocalDateTime lastReadTime;
}
