package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * 意图识别节点配置请求
 */
@Data
@Schema(description = "意图识别节点配置")
public class IntentRecognitionNodeConfigRequest {

    @Schema(description = "输入文本变量名", example = "userInput")
    private String inputVariable;

    @Schema(description = "识别模型", example = "RULE_BASED", 
            allowableValues = {"RULE_BASED", "ML_MODEL", "LLM_BASED"})
    private String recognitionModel;

    @Schema(description = "预定义意图列表")
    private List<IntentDefinitionDTO> intents;

    @Schema(description = "LLM模型名称（LLM_BASED模式）", example = "gpt-4")
    private String llmModel;

    @Schema(description = "意图识别提示词（LLM_BASED模式）")
    private String llmPrompt;

    @Schema(description = "置信度阈值", example = "0.7")
    private Double confidenceThreshold;

    @Schema(description = "是否返回多个意图", example = "false")
    private Boolean multiIntent;

    @Schema(description = "最大返回意图数", example = "3")
    private Integer maxIntents;

    @Schema(description = "输出意图变量名", example = "recognizedIntent")
    private String outputIntentVariable;

    @Schema(description = "输出置信度变量名", example = "intentConfidence")
    private String outputConfidenceVariable;

    @Schema(description = "未识别时的默认意图", example = "UNKNOWN")
    private String defaultIntent;

    @Data
    @Schema(description = "意图定义")
    public static class IntentDefinitionDTO {
        @Schema(description = "意图名称", example = "QUERY_ORDER")
        private String name;

        @Schema(description = "意图描述", example = "查询订单状态")
        private String description;

        @Schema(description = "关键词列表")
        private List<String> keywords;

        @Schema(description = "示例句子列表")
        private List<String> examples;

        @Schema(description = "正则表达式模式")
        private String pattern;
    }
}
