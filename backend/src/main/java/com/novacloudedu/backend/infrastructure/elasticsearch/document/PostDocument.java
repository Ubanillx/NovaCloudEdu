package com.novacloudedu.backend.infrastructure.elasticsearch.document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PostDocument {

    private Long id;

    private String title;

    private String content;

    private List<String> tags;

    private String postType;

    private Long userId;

    private Integer thumbNum;

    private Integer favourNum;

    private Integer commentNum;

    private LocalDateTime createTime;
}
