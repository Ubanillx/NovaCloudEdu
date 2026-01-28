package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * 开始节点配置请求
 */
@Data
@Schema(description = "开始节点配置")
public class StartNodeConfigRequest {

    @Schema(description = "输入参数定义列表")
    private List<InputParameterDTO> inputParameters;

    @Schema(description = "是否验证输入参数", example = "true")
    private Boolean validateInput;

    @Schema(description = "触发方式", example = "API", 
            allowableValues = {"API", "WEBHOOK", "SCHEDULE", "EVENT"})
    private String triggerType;

    @Data
    @Schema(description = "输入参数定义")
    public static class InputParameterDTO {
        @Schema(description = "参数名", example = "query")
        private String name;

        @Schema(description = "参数类型", example = "STRING", 
                allowableValues = {"STRING", "NUMBER", "BOOLEAN", "OBJECT", "ARRAY"})
        private String type;

        @Schema(description = "参数描述", example = "用户查询问题")
        private String description;

        @Schema(description = "是否必需", example = "true")
        private Boolean required;

        @Schema(description = "默认值")
        private Object defaultValue;

        @Schema(description = "验证规则（正则表达式）")
        private String validationPattern;

        @Schema(description = "最小长度（字符串）")
        private Integer minLength;

        @Schema(description = "最大长度（字符串）")
        private Integer maxLength;

        @Schema(description = "最小值（数字）")
        private Double minValue;

        @Schema(description = "最大值（数字）")
        private Double maxValue;

        @Schema(description = "枚举值列表")
        private List<Object> enumValues;
    }
}
