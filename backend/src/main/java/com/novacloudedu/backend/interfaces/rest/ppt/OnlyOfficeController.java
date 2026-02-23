package com.novacloudedu.backend.interfaces.rest.ppt;

import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.crypto.SecretKey;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.HexFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * OnlyOffice 文档在线编辑控制器
 * - GET  /api/onlyoffice/config   前端获取编辑器配置
 * - POST /api/onlyoffice/callback OnlyOffice 保存回调（白名单，无需认证）
 */
@Slf4j
@RestController
@RequestMapping("/api/onlyoffice")
@RequiredArgsConstructor
@Tag(name = "OnlyOffice在线编辑", description = "PPTX在线编辑集成")
public class OnlyOfficeController {

    private final OssService ossService;

    @Value("${onlyoffice.document-server-url:http://localhost:9980}")
    private String documentServerUrl;

    @Value("${onlyoffice.callback-url:http://host.docker.internal:8080/api/onlyoffice/callback}")
    private String callbackUrl;

    @Value("${onlyoffice.jwt-secret:}")
    private String jwtSecret;

    /**
     * 获取 OnlyOffice 编辑器配置
     */
    @GetMapping("/config")
    @Operation(summary = "获取OnlyOffice编辑器配置")
    public Map<String, Object> getEditorConfig(
            @RequestParam String fileUrl,
            @RequestParam(required = false, defaultValue = "演示文稿.pptx") String fileName) {

        String documentKey = generateDocumentKey(fileUrl);

        Map<String, Object> document = new HashMap<>();
        document.put("fileType", "pptx");
        document.put("key", documentKey);
        document.put("title", fileName);
        document.put("url", fileUrl);

        Map<String, Object> editorConfig = new HashMap<>();
        editorConfig.put("callbackUrl", callbackUrl);
        editorConfig.put("lang", "zh-CN");
        editorConfig.put("mode", "edit");

        Map<String, Object> customization = new HashMap<>();
        customization.put("autosave", true);
        customization.put("forcesave", true);
        editorConfig.put("customization", customization);

        Map<String, Object> config = new HashMap<>();
        config.put("document", document);
        config.put("editorConfig", editorConfig);
        config.put("documentType", "slide");
        config.put("type", "desktop");

        // 如果配置了 JWT secret，签名 config
        if (jwtSecret != null && !jwtSecret.isBlank()) {
            String token = generateOnlyOfficeToken(config);
            config.put("token", token);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("documentServerUrl", documentServerUrl);
        result.put("config", config);

        return result;
    }

    /**
     * OnlyOffice 文档保存回调
     * 当用户关闭编辑器（或自动保存触发）后，OnlyOffice 会 POST 到此端点
     * status=2 表示文档已就绪可下载
     */
    @PostMapping("/callback")
    @Operation(summary = "OnlyOffice保存回调", description = "无需认证，由OnlyOffice服务器调用")
    public Map<String, Object> handleCallback(@RequestBody Map<String, Object> body) {
        int status = 0;
        Object statusObj = body.get("status");
        if (statusObj instanceof Number) {
            status = ((Number) statusObj).intValue();
        }

        log.info("OnlyOffice callback: status={}, body keys={}", status, body.keySet());

        // status=2: 文档编辑完成，可以下载保存
        // status=6: 强制保存
        if (status == 2 || status == 6) {
            String downloadUrl = (String) body.get("url");
            if (downloadUrl != null && !downloadUrl.isBlank()) {
                try {
                    // 从 OnlyOffice 下载编辑后的文件
                    HttpClient httpClient = HttpClient.newHttpClient();
                    HttpRequest request = HttpRequest.newBuilder()
                            .uri(URI.create(downloadUrl))
                            .GET()
                            .build();
                    HttpResponse<byte[]> response = httpClient.send(
                            request, HttpResponse.BodyHandlers.ofByteArray());

                    if (response.statusCode() == 200) {
                        byte[] fileBytes = response.body();
                        // 上传到 OSS
                        String newUrl = ossService.uploadBytes(
                                fileBytes, ".pptx", FileBusinessType.PPT_GENERATED);
                        log.info("OnlyOffice 编辑后文件已上传 OSS: {} ({} bytes)", newUrl, fileBytes.length);
                    } else {
                        log.error("从OnlyOffice下载编辑后文件失败, HTTP {}", response.statusCode());
                    }
                } catch (Exception e) {
                    log.error("处理OnlyOffice回调失败", e);
                }
            }
        }

        // 必须返回 {"error": 0} 表示成功，否则 OnlyOffice 会重试
        Map<String, Object> result = new HashMap<>();
        result.put("error", 0);
        return result;
    }

    /**
     * 使用 OnlyOffice JWT secret 对 config 进行签名
     */
    private String generateOnlyOfficeToken(Map<String, Object> config) {
        SecretKey key = Keys.hmacShaKeyFor(jwtSecret.getBytes(StandardCharsets.UTF_8));
        return Jwts.builder()
                .claims(config)
                .signWith(key)
                .compact();
    }

    private String generateDocumentKey(String fileUrl) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest((fileUrl + "_" + System.currentTimeMillis()).getBytes());
            return HexFormat.of().formatHex(hash).substring(0, 20);
        } catch (Exception e) {
            return String.valueOf(fileUrl.hashCode()) + System.currentTimeMillis();
        }
    }
}
