package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * 实体抽取节点配置请求
 */
@Data
@Schema(description = "实体抽取节点配置")
public class EntityExtractionNodeConfigRequest {

    @Schema(description = "输入文本变量名", example = "userInput")
    private String inputVariable;

    @Schema(description = "抽取模型", example = "RULE_BASED", 
            allowableValues = {"RULE_BASED", "NER_MODEL", "LLM_BASED"})
    private String extractionModel;

    @Schema(description = "要抽取的实体类型列表")
    private List<EntityTypeDTO> entityTypes;

    @Schema(description = "LLM模型名称（LLM_BASED模式）", example = "gpt-4")
    private String llmModel;

    @Schema(description = "实体抽取提示词（LLM_BASED模式）")
    private String llmPrompt;

    @Schema(description = "是否合并相邻同类实体", example = "true")
    private Boolean mergeAdjacent;

    @Schema(description = "输出变量名", example = "extractedEntities")
    private String outputVariable;

    @Schema(description = "是否返回实体位置信息", example = "true")
    private Boolean includePosition;

    @Data
    @Schema(description = "实体类型定义")
    public static class EntityTypeDTO {
        @Schema(description = "实体类型名称", example = "PHONE_NUMBER")
        private String name;

        @Schema(description = "实体类型描述", example = "电话号码")
        private String description;

        @Schema(description = "正则表达式模式", example = "1[3-9]\\d{9}")
        private String pattern;

        @Schema(description = "示例值列表")
        private List<String> examples;

        @Schema(description = "输出变量名", example = "phoneNumber")
        private String outputVariable;

        @Schema(description = "是否必需", example = "false")
        private Boolean required;

        @Schema(description = "验证规则")
        private String validationRule;
    }
}
