package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Data;

import java.util.List;

/**
 * 知识库检索节点配置请求
 */
@Data
@Schema(description = "知识库检索节点配置")
public class KnowledgeRetrievalNodeConfigRequest {

    @Schema(description = "知识库ID列表", requiredMode = Schema.RequiredMode.REQUIRED)
    private List<Long> knowledgeBaseIds;

    @Schema(description = "查询文本变量名", example = "userQuery")
    private String queryVariable;

    @Min(1) @Max(50)
    @Schema(description = "返回结果数量", example = "5")
    private Integer topK;

    @Min(0) @Max(1)
    @Schema(description = "相似度阈值，低于此值的结果将被过滤", example = "0.7")
    private Double similarityThreshold;

    @Schema(description = "检索模式", example = "HYBRID", 
            allowableValues = {"VECTOR", "KEYWORD", "HYBRID"})
    private String retrievalMode;

    @Schema(description = "混合检索时向量检索权重", example = "0.7")
    private Double vectorWeight;

    @Schema(description = "是否启用重排序", example = "true")
    private Boolean enableRerank;

    @Schema(description = "重排序模型", example = "bge-reranker")
    private String rerankModel;

    @Schema(description = "输出变量名，用于存储检索结果", example = "retrievedDocs")
    private String outputVariable;

    @Schema(description = "是否返回文档元数据", example = "true")
    private Boolean includeMetadata;

    @Schema(description = "是否返回相似度分数", example = "true")
    private Boolean includeScore;

    @Schema(description = "文档过滤条件")
    private DocumentFilterDTO filter;

    @Data
    @Schema(description = "文档过滤条件")
    public static class DocumentFilterDTO {
        @Schema(description = "文档类型过滤", example = "[\"pdf\", \"docx\"]")
        private List<String> documentTypes;

        @Schema(description = "标签过滤")
        private List<String> tags;

        @Schema(description = "创建时间范围-开始")
        private String createTimeStart;

        @Schema(description = "创建时间范围-结束")
        private String createTimeEnd;
    }
}
