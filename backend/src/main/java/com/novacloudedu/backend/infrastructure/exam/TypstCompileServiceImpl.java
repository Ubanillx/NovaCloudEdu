package com.novacloudedu.backend.infrastructure.exam;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

/**
 * Typst 编译服务 - 调用 typst-service 微服务
 */
@Slf4j
@Service
public class TypstCompileServiceImpl {

    @Value("${typst.service.url:http://localhost:8200}")
    private String typstServiceUrl;

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    public TypstCompileServiceImpl(ObjectMapper objectMapper) {
        this.restTemplate = new RestTemplate();
        this.objectMapper = objectMapper;
    }

    /**
     * 编译试卷为 PDF
     *
     * @param template 模板名称 (exam_paper / answer_key)
     * @param data     试卷数据
     * @return PDF 字节数组
     */
    public byte[] compile(String template, Map<String, Object> data) {
        String url = typstServiceUrl + "/compile";

        try {
            Map<String, Object> requestBody = Map.of(
                    "template", template,
                    "data", data
            );

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            String jsonBody = objectMapper.writeValueAsString(requestBody);
            HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

            ResponseEntity<byte[]> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    entity,
                    byte[].class
            );

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                log.info("Typst 编译成功, template={}, pdf_size={}bytes", template, response.getBody().length);
                return response.getBody();
            } else {
                throw new RuntimeException("Typst 编译失败: HTTP " + response.getStatusCode());
            }
        } catch (Exception e) {
            log.error("调用 typst-service 失败: {}", e.getMessage(), e);
            throw new RuntimeException("试卷 PDF 生成失败: " + e.getMessage(), e);
        }
    }

    /**
     * 使用自定义模板源码编译 PDF
     *
     * @param templateContent Typst 模板源码
     * @param data            试卷数据
     * @return PDF 字节数组
     */
    public byte[] compileWithTemplate(String templateContent, Map<String, Object> data) {
        String url = typstServiceUrl + "/compile-with-template";

        try {
            Map<String, Object> requestBody = Map.of(
                    "template_content", templateContent,
                    "data", data
            );

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            String jsonBody = objectMapper.writeValueAsString(requestBody);
            HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

            ResponseEntity<byte[]> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    entity,
                    byte[].class
            );

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                log.info("Typst 自定义模板编译成功, pdf_size={}bytes", response.getBody().length);
                return response.getBody();
            } else {
                throw new RuntimeException("Typst 编译失败: HTTP " + response.getStatusCode());
            }
        } catch (Exception e) {
            log.error("调用 typst-service /compile-with-template 失败: {}", e.getMessage(), e);
            throw new RuntimeException("试卷 PDF 生成失败: " + e.getMessage(), e);
        }
    }

    /**
     * 渲染 Typst 绘图代码为 PNG（用于几何图形）
     *
     * @param typstCode Typst 绘图代码（cetz 等）
     * @return PNG 字节数组
     */
    public byte[] renderPng(String typstCode) {
        return renderPng(typstCode, "geometry");
    }

    /**
     * 渲染 Typst 绘图代码为 PNG（指定模板）
     */
    public byte[] renderPng(String typstCode, String template) {
        String url = typstServiceUrl + "/render-png";

        try {
            Map<String, Object> requestBody = Map.of(
                    "code", typstCode,
                    "template", template
            );

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            String jsonBody = objectMapper.writeValueAsString(requestBody);
            HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

            ResponseEntity<byte[]> response = restTemplate.exchange(
                    url, HttpMethod.POST, entity, byte[].class
            );

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                log.info("Typst 几何图形渲染成功, template={}, png_size={}bytes", template, response.getBody().length);
                return response.getBody();
            } else {
                throw new RuntimeException("Typst 渲染失败: HTTP " + response.getStatusCode());
            }
        } catch (Exception e) {
            log.error("调用 typst-service /render-png 失败: {}", e.getMessage(), e);
            throw new RuntimeException("几何图形渲染失败: " + e.getMessage(), e);
        }
    }
}
