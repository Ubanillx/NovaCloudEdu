package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 代码执行节点配置请求
 */
@Data
@Schema(description = "代码执行节点配置")
public class CodeNodeConfigRequest {

    @Schema(description = "编程语言", example = "JAVASCRIPT", 
            allowableValues = {"JAVASCRIPT", "PYTHON", "GROOVY"})
    private String language;

    @Schema(description = "代码内容", example = "return input.toUpperCase();")
    private String code;

    @Schema(description = "输入变量列表，这些变量将在代码中可用")
    private List<String> inputVariables;

    @Schema(description = "输入参数映射，将工作流变量映射到代码参数")
    private Map<String, String> inputMapping;

    @Schema(description = "输出变量名", example = "codeResult")
    private String outputVariable;

    @Schema(description = "输出字段映射，将代码返回值的字段映射到工作流变量")
    private Map<String, String> outputMapping;

    @Schema(description = "执行超时时间（毫秒）", example = "10000")
    private Long timeout;

    @Schema(description = "是否启用沙箱模式", example = "true")
    private Boolean sandbox;

    @Schema(description = "允许的模块/包列表（沙箱模式下）")
    private List<String> allowedModules;

    @Schema(description = "内存限制（MB）", example = "128")
    private Integer memoryLimit;

    @Schema(description = "是否捕获控制台输出", example = "true")
    private Boolean captureConsole;

    @Schema(description = "控制台输出变量名", example = "consoleOutput")
    private String consoleOutputVariable;
}
