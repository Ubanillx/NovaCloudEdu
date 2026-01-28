package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Min;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * HTTP请求节点配置请求
 */
@Data
@Schema(description = "HTTP请求节点配置")
public class HttpRequestNodeConfigRequest {

    @Schema(description = "请求URL，支持变量替换", example = "https://api.example.com/users/${userId}")
    private String url;

    @Schema(description = "HTTP方法", example = "POST", 
            allowableValues = {"GET", "POST", "PUT", "DELETE", "PATCH", "HEAD", "OPTIONS"})
    private String method;

    @Schema(description = "请求头")
    private Map<String, String> headers;

    @Schema(description = "查询参数")
    private Map<String, String> queryParams;

    @Schema(description = "请求体类型", example = "JSON", 
            allowableValues = {"JSON", "FORM", "XML", "TEXT", "BINARY"})
    private String bodyType;

    @Schema(description = "请求体内容，支持变量替换")
    private String body;

    @Schema(description = "请求体JSON对象（bodyType为JSON时使用）")
    private Map<String, Object> jsonBody;

    @Schema(description = "表单字段（bodyType为FORM时使用）")
    private List<FormFieldDTO> formFields;

    @Min(1000)
    @Schema(description = "连接超时时间（毫秒）", example = "5000")
    private Integer connectTimeout;

    @Min(1000)
    @Schema(description = "读取超时时间（毫秒）", example = "30000")
    private Integer readTimeout;

    @Schema(description = "是否跟随重定向", example = "true")
    private Boolean followRedirects;

    @Schema(description = "重试次数", example = "3")
    private Integer retryCount;

    @Schema(description = "认证类型", example = "BEARER", 
            allowableValues = {"NONE", "BASIC", "BEARER", "API_KEY", "OAUTH2"})
    private String authType;

    @Schema(description = "认证配置")
    private AuthConfigDTO authConfig;

    @Schema(description = "输出变量名，存储响应结果", example = "httpResponse")
    private String outputVariable;

    @Schema(description = "是否解析JSON响应", example = "true")
    private Boolean parseJsonResponse;

    @Schema(description = "响应字段映射，将响应字段映射到变量")
    private Map<String, String> responseMapping;

    @Schema(description = "成功状态码列表", example = "[200, 201, 204]")
    private List<Integer> successStatusCodes;

    @Data
    @Schema(description = "表单字段")
    public static class FormFieldDTO {
        @Schema(description = "字段名")
        private String name;

        @Schema(description = "字段值")
        private String value;

        @Schema(description = "是否为文件字段")
        private Boolean isFile;

        @Schema(description = "文件变量名（isFile为true时）")
        private String fileVariable;
    }

    @Data
    @Schema(description = "认证配置")
    public static class AuthConfigDTO {
        @Schema(description = "用户名（BASIC认证）")
        private String username;

        @Schema(description = "密码（BASIC认证）")
        private String password;

        @Schema(description = "Token（BEARER认证）")
        private String token;

        @Schema(description = "Token变量名")
        private String tokenVariable;

        @Schema(description = "API Key名称")
        private String apiKeyName;

        @Schema(description = "API Key值")
        private String apiKeyValue;

        @Schema(description = "API Key位置", allowableValues = {"HEADER", "QUERY"})
        private String apiKeyLocation;
    }
}
