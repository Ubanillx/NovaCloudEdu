package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 知识库分块持久化对象
 */
@Data
@TableName("knowledge_chunk")
public class KnowledgeChunkPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long knowledgeBaseId;
    private Long documentId;

    private String content;
    private Integer chunkIndex;

    @TableField(exist = false)
    private float[] embedding;

    private String metadata;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;
}
