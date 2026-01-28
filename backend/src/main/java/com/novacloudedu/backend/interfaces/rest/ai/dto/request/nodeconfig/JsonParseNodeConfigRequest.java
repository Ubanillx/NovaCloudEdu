package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * JSON解析节点配置请求
 */
@Data
@Schema(description = "JSON解析节点配置")
public class JsonParseNodeConfigRequest {

    @Schema(description = "输入JSON变量名", example = "rawJson")
    private String inputVariable;

    @Schema(description = "解析模式", example = "EXTRACT", 
            allowableValues = {"EXTRACT", "TRANSFORM", "VALIDATE"})
    private String parseMode;

    @Schema(description = "字段提取配置列表")
    private List<FieldExtractionDTO> extractions;

    @Schema(description = "JSONPath表达式（用于复杂提取）", example = "$.data.items[*].name")
    private String jsonPath;

    @Schema(description = "输出变量名", example = "parsedData")
    private String outputVariable;

    @Schema(description = "JSON Schema（用于验证）")
    private String jsonSchema;

    @Schema(description = "解析失败时的处理策略", example = "ERROR", 
            allowableValues = {"ERROR", "DEFAULT_VALUE", "SKIP"})
    private String errorStrategy;

    @Schema(description = "默认值（errorStrategy为DEFAULT_VALUE时使用）")
    private Object defaultValue;

    @Data
    @Schema(description = "字段提取配置")
    public static class FieldExtractionDTO {
        @Schema(description = "JSON字段路径", example = "data.user.name")
        private String fieldPath;

        @Schema(description = "输出变量名", example = "userName")
        private String outputVariable;

        @Schema(description = "数据类型", example = "STRING", 
                allowableValues = {"STRING", "INTEGER", "DOUBLE", "BOOLEAN", "ARRAY", "OBJECT"})
        private String dataType;

        @Schema(description = "是否必需", example = "true")
        private Boolean required;

        @Schema(description = "默认值")
        private Object defaultValue;
    }
}
