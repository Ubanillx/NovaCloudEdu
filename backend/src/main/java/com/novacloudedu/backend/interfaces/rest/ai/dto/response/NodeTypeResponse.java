package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

/**
 * 节点类型响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "节点类型响应")
public class NodeTypeResponse {

    @Schema(description = "节点类型枚举值", example = "LLM")
    private String type;

    @Schema(description = "节点类型描述", example = "大语言模型")
    private String description;

    @Schema(description = "节点分类", example = "AI节点")
    private String category;

    @Schema(description = "节点图标", example = "brain")
    private String icon;

    @Schema(description = "配置参数模板")
    private List<ConfigFieldDTO> configFields;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "配置字段定义")
    public static class ConfigFieldDTO {
        @Schema(description = "字段名", example = "model")
        private String name;

        @Schema(description = "字段标签", example = "模型")
        private String label;

        @Schema(description = "字段类型", example = "select", 
                allowableValues = {"text", "textarea", "number", "select", "boolean", "json"})
        private String fieldType;

        @Schema(description = "是否必填", example = "true")
        private boolean required;

        @Schema(description = "默认值", example = "gpt-4")
        private Object defaultValue;

        @Schema(description = "字段描述", example = "选择要使用的AI模型")
        private String description;

        @Schema(description = "选项列表（select类型时使用）")
        private List<OptionDTO> options;

        @Schema(description = "验证规则")
        private Map<String, Object> validation;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "选项")
    public static class OptionDTO {
        @Schema(description = "选项值", example = "gpt-4")
        private String value;

        @Schema(description = "选项标签", example = "GPT-4")
        private String label;
    }
}
