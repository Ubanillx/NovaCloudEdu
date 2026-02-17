package com.novacloudedu.backend.application.book.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class BookDTO {
    private Long id;
    private String title;
    private String author;
    private String coverUrl;
    private String originFileUrl;
    private String fileType;
    private String status;
    private Integer totalChapters;
    private Integer wordCount;
    private Long fileSize;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
