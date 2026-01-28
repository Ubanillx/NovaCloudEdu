package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.HttpRequestNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * HTTP请求节点执行器单元测试
 */
@DisplayName("HttpRequestNodeExecutor 单元测试")
class HttpRequestNodeExecutorTest {

    private HttpRequestNodeExecutor executor;

    @BeforeEach
    void setUp() {
        executor = new HttpRequestNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回HTTP_REQUEST")
    void getNodeType_shouldReturnHttpRequest() {
        assertEquals(NodeType.HTTP_REQUEST, executor.getNodeType());
    }

    @Test
    @DisplayName("验证 - 缺少url配置应抛出异常")
    void validate_missingUrl_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("method", "GET");

        WorkflowNode node = WorkflowNode.builder()
                .id("http_1")
                .type(NodeType.HTTP_REQUEST)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("http_1")
                .type(NodeType.HTTP_REQUEST)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 有url配置应通过验证")
    void validate_withUrl_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("url", "https://api.example.com/test");
        config.put("method", "GET");

        WorkflowNode node = WorkflowNode.builder()
                .id("http_1")
                .type(NodeType.HTTP_REQUEST)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
