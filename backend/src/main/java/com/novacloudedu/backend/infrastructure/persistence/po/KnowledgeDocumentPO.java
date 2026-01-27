package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 知识库文档持久化对象
 */
@Data
@TableName("knowledge_document")
public class KnowledgeDocumentPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long knowledgeBaseId;

    private String name;
    private String fileType;
    private String fileUrl;
    private Long fileSize;

    private String content;
    private String contentHash;

    private Integer chunkCount;
    private String status;
    private String errorMessage;

    private Long creatorId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
