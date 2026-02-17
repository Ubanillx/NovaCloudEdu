package com.novacloudedu.backend.infrastructure.elasticsearch.document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BookDocument {

    private Long id;

    private String title;

    private String author;

    private String fileType;

    private Integer status;

    private Integer totalChapters;

    private Integer wordCount;

    private String coverUrl;

    private LocalDateTime createTime;
}
