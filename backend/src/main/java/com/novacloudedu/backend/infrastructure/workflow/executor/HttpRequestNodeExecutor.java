package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 * HTTP请求节点执行器
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class HttpRequestNodeExecutor implements NodeExecutor {

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public NodeType getNodeType() {
        return NodeType.HTTP_REQUEST;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String url = (String) config.getOrDefault("url", "");
        String method = (String) config.getOrDefault("method", "GET");
        Map<String, String> headers = (Map<String, String>) config.getOrDefault("headers", new HashMap<>());
        Object body = config.get("body");
        int timeout = (int) config.getOrDefault("timeout", 30000);

        // 变量替换
        url = replaceVariables(url, input);

        log.info("HTTP请求节点执行: method={}, url={}", method, url);

        try {
            HttpHeaders httpHeaders = new HttpHeaders();
            headers.forEach(httpHeaders::set);
            if (!httpHeaders.containsKey(HttpHeaders.CONTENT_TYPE)) {
                httpHeaders.setContentType(MediaType.APPLICATION_JSON);
            }

            HttpEntity<Object> entity = new HttpEntity<>(body, httpHeaders);
            
            ResponseEntity<String> response = restTemplate.exchange(
                    url,
                    HttpMethod.valueOf(method.toUpperCase()),
                    entity,
                    String.class
            );

            Map<String, Object> result = new HashMap<>();
            result.put("statusCode", response.getStatusCode().value());
            result.put("body", response.getBody());
            result.put("headers", response.getHeaders().toSingleValueMap());

            // 尝试解析JSON响应
            try {
                if (response.getBody() != null) {
                    Object jsonBody = objectMapper.readValue(response.getBody(), Object.class);
                    result.put("jsonBody", jsonBody);
                }
            } catch (Exception e) {
                // 非JSON响应，忽略
            }

            return result;

        } catch (Exception e) {
            log.error("HTTP请求失败: url={}", url, e);
            throw new RuntimeException("HTTP请求失败: " + e.getMessage(), e);
        }
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null || !config.containsKey("url")) {
            throw new IllegalArgumentException("HTTP请求节点缺少URL配置");
        }
    }

    private String replaceVariables(String template, Map<String, Object> variables) {
        if (template == null) return "";
        String result = template;
        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            String value = entry.getValue() != null ? String.valueOf(entry.getValue()) : "";
            result = result.replace(placeholder, value);
        }
        return result;
    }
}
