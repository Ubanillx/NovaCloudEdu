package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * 文本向量化节点配置请求
 */
@Data
@Schema(description = "文本向量化节点配置")
public class TextEmbeddingNodeConfigRequest {

    @Schema(description = "输入文本变量名", example = "inputText")
    private String inputVariable;

    @Schema(description = "输入文本列表变量名（批量处理）", example = "textList")
    private String inputListVariable;

    @Schema(description = "向量化模型", example = "text-embedding-ada-002", 
            allowableValues = {"text-embedding-ada-002", "text-embedding-3-small", "text-embedding-3-large", "bge-large-zh", "m3e-base"})
    private String model;

    @Schema(description = "向量维度", example = "1536")
    private Integer dimensions;

    @Schema(description = "是否归一化向量", example = "true")
    private Boolean normalize;

    @Schema(description = "输出变量名", example = "embedding")
    private String outputVariable;

    @Schema(description = "批量处理时的批次大小", example = "100")
    private Integer batchSize;

    @Schema(description = "是否缓存向量结果", example = "true")
    private Boolean enableCache;

    @Schema(description = "缓存过期时间（秒）", example = "3600")
    private Integer cacheTtl;
}
