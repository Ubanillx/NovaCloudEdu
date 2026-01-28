package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Min;
import lombok.Data;

/**
 * 循环节点配置请求
 */
@Data
@Schema(description = "循环节点配置")
public class LoopNodeConfigRequest {

    @Schema(description = "循环类型", example = "FOR_EACH", 
            allowableValues = {"FOR_EACH", "WHILE", "FOR_COUNT"})
    private String loopType;

    @Schema(description = "遍历的数组变量名（FOR_EACH模式）", example = "documents")
    private String iterableVariable;

    @Schema(description = "当前迭代项变量名", example = "currentDoc")
    private String itemVariable;

    @Schema(description = "当前索引变量名", example = "index")
    private String indexVariable;

    @Schema(description = "循环条件表达式（WHILE模式）", example = "${retryCount} < 3")
    private String whileCondition;

    @Min(1)
    @Schema(description = "循环次数（FOR_COUNT模式）", example = "10")
    private Integer loopCount;

    @Schema(description = "循环计数器变量名（FOR_COUNT模式）", example = "i")
    private String counterVariable;

    @Min(1)
    @Schema(description = "最大循环次数限制，防止死循环", example = "100")
    private Integer maxIterations;

    @Schema(description = "循环体内的起始节点ID")
    private String loopBodyStartNodeId;

    @Schema(description = "循环结束后的下一个节点ID")
    private String loopEndNodeId;

    @Schema(description = "是否并行执行循环体", example = "false")
    private Boolean parallel;

    @Schema(description = "并行执行时的最大并发数", example = "5")
    private Integer parallelLimit;

    @Schema(description = "收集循环结果的变量名", example = "loopResults")
    private String resultVariable;
}
