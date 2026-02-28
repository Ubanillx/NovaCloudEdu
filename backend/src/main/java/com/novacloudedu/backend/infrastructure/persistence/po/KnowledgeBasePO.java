package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 知识库持久化对象
 */
@Data
@TableName("knowledge_base")
public class KnowledgeBasePO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;
    private String description;

    private String embeddingModel;
    private Integer embeddingDimension;
    private Integer chunkSize;
    private Integer chunkOverlap;
    private String chunkStrategy;
    private Boolean parentChildMode;
    private Integer parentChunkSize;
    private Boolean preserveMetadata;
    private Double semanticThreshold;

    private String retrievalMode;
    private Boolean enableQueryRewrite;
    private Boolean useDynamicTopK;
    private Integer defaultTopK;
    private String queryRewriteModelId;
    private String rerankModel;

    private Integer documentCount;
    private Integer chunkCount;

    private String status;

    private Long creatorId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
