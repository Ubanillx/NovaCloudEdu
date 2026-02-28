package com.novacloudedu.backend.application.ai.command;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 知识库创建DTO
 */
@Data
public class CreateKnowledgeBaseCommand {

    @NotBlank(message = "名称不能为空")
    @Size(max = 128, message = "名称最长128个字符")
    private String name;

    @Size(max = 2000, message = "描述最长2000个字符")
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
}
