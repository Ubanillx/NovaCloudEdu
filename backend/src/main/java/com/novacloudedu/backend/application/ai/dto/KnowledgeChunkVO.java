package com.novacloudedu.backend.application.ai.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 知识库分块视图对象
 */
@Data
public class KnowledgeChunkVO {

    private Long id;
    private Long knowledgeBaseId;
    private Long documentId;

    private String content;
    private Integer chunkIndex;
    private String metadata;

    private LocalDateTime createTime;
}
