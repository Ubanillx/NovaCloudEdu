package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * Webhook触发节点配置请求
 */
@Data
@Schema(description = "Webhook触发节点配置")
public class WebhookNodeConfigRequest {

    @Schema(description = "Webhook路径", example = "/webhook/order-notify")
    private String path;

    @Schema(description = "允许的HTTP方法", example = "[\"POST\"]")
    private List<String> allowedMethods;

    @Schema(description = "认证方式", example = "SIGNATURE", 
            allowableValues = {"NONE", "API_KEY", "SIGNATURE", "BASIC"})
    private String authType;

    @Schema(description = "API Key（API_KEY认证）")
    private String apiKey;

    @Schema(description = "签名密钥（SIGNATURE认证）")
    private String signatureSecret;

    @Schema(description = "签名算法", example = "HMAC-SHA256", 
            allowableValues = {"HMAC-SHA256", "HMAC-SHA1", "MD5"})
    private String signatureAlgorithm;

    @Schema(description = "签名头名称", example = "X-Signature")
    private String signatureHeader;

    @Schema(description = "请求体解析方式", example = "JSON", 
            allowableValues = {"JSON", "FORM", "XML", "RAW"})
    private String bodyParser;

    @Schema(description = "请求字段映射到变量")
    private Map<String, String> fieldMapping;

    @Schema(description = "IP白名单")
    private List<String> ipWhitelist;

    @Schema(description = "是否返回响应", example = "true")
    private Boolean sendResponse;

    @Schema(description = "响应内容")
    private String responseBody;

    @Schema(description = "响应状态码", example = "200")
    private Integer responseStatusCode;
}
