package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 响应输出节点配置请求
 */
@Data
@Schema(description = "响应输出节点配置")
public class ResponseNodeConfigRequest {

    @Schema(description = "响应类型", example = "JSON", 
            allowableValues = {"JSON", "TEXT", "STREAM", "FILE"})
    private String responseType;

    @Schema(description = "响应内容模板（TEXT类型）", example = "处理完成，结果：${result}")
    private String contentTemplate;

    @Schema(description = "响应JSON结构（JSON类型）")
    private Map<String, Object> jsonStructure;

    @Schema(description = "响应字段映射，将变量映射到响应字段")
    private List<ResponseFieldDTO> fields;

    @Schema(description = "流式输出的变量名（STREAM类型）", example = "streamContent")
    private String streamVariable;

    @Schema(description = "文件变量名（FILE类型）", example = "outputFile")
    private String fileVariable;

    @Schema(description = "HTTP状态码", example = "200")
    private Integer statusCode;

    @Schema(description = "响应头")
    private Map<String, String> headers;

    @Schema(description = "是否包含执行元数据", example = "false")
    private Boolean includeMetadata;

    @Data
    @Schema(description = "响应字段配置")
    public static class ResponseFieldDTO {
        @Schema(description = "响应字段名", example = "answer")
        private String fieldName;

        @Schema(description = "源变量名", example = "llmResponse")
        private String sourceVariable;

        @Schema(description = "字段路径（从对象中提取）", example = "data.content")
        private String fieldPath;

        @Schema(description = "默认值")
        private Object defaultValue;

        @Schema(description = "是否必需", example = "true")
        private Boolean required;
    }
}
