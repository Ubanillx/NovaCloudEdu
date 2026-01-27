package com.novacloudedu.backend.application.ai.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 知识库文档视图对象
 */
@Data
public class KnowledgeDocumentVO {

    private Long id;
    private Long knowledgeBaseId;

    private String name;
    private String fileType;
    private String fileUrl;
    private Long fileSize;

    private Integer chunkCount;
    private String status;
    private String errorMessage;

    private Long creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
