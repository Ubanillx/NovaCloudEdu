package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.TemplateNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 模板渲染节点执行器单元测试
 */
@DisplayName("TemplateNodeExecutor 单元测试")
class TemplateNodeExecutorTest {

    private TemplateNodeExecutor executor;

    @BeforeEach
    void setUp() {
        executor = new TemplateNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回TEMPLATE")
    void getNodeType_shouldReturnTemplate() {
        assertEquals(NodeType.TEMPLATE, executor.getNodeType());
    }

    @Test
    @DisplayName("简单变量替换")
    void execute_simpleVariableReplacement_shouldWork() {
        Map<String, Object> config = new HashMap<>();
        config.put("template", "你好，{{name}}！欢迎来到{{city}}。");
        config.put("outputVariable", "greeting");

        WorkflowNode node = WorkflowNode.builder()
                .id("template_1")
                .type(NodeType.TEMPLATE)
                .name("问候模板")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "张三");
        input.put("city", "北京");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("你好，张三！欢迎来到北京。", result.get("greeting"));
    }

    @Test
    @DisplayName("多次使用同一变量")
    void execute_sameVariableMultipleTimes_shouldReplaceAll() {
        Map<String, Object> config = new HashMap<>();
        config.put("template", "{{name}}说：我是{{name}}，很高兴认识你。");
        config.put("outputVariable", "message");

        WorkflowNode node = WorkflowNode.builder()
                .id("template_1")
                .type(NodeType.TEMPLATE)
                .name("自我介绍")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "李四");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("李四说：我是李四，很高兴认识你。", result.get("message"));
    }

    @Test
    @DisplayName("变量不存在时保留占位符或替换为空")
    void execute_missingVariable_shouldHandleGracefully() {
        Map<String, Object> config = new HashMap<>();
        config.put("template", "用户：{{name}}，邮箱：{{email}}");
        config.put("outputVariable", "info");

        WorkflowNode node = WorkflowNode.builder()
                .id("template_1")
                .type(NodeType.TEMPLATE)
                .name("用户信息")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "王五");
        // email 未提供

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        String info = (String) result.get("info");
        // 根据实现，可能保留{{email}}或替换为空字符串
        assertTrue(info.contains("王五"));
    }

    @Test
    @DisplayName("数字变量替换")
    void execute_numericVariable_shouldConvertToString() {
        Map<String, Object> config = new HashMap<>();
        config.put("template", "订单号：{{orderId}}，金额：{{amount}}元");
        config.put("outputVariable", "orderInfo");

        WorkflowNode node = WorkflowNode.builder()
                .id("template_1")
                .type(NodeType.TEMPLATE)
                .name("订单信息")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("orderId", 12345);
        input.put("amount", 99.99);

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        String orderInfo = (String) result.get("orderInfo");
        assertTrue(orderInfo.contains("12345"));
        assertTrue(orderInfo.contains("99.99"));
    }

    @Test
    @DisplayName("空模板应返回空字符串")
    void execute_emptyTemplate_shouldReturnEmptyString() {
        Map<String, Object> config = new HashMap<>();
        config.put("template", "");
        config.put("outputVariable", "result");

        WorkflowNode node = WorkflowNode.builder()
                .id("template_1")
                .type(NodeType.TEMPLATE)
                .name("空模板")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("", result.get("result"));
    }

    @Test
    @DisplayName("验证 - 缺少template配置应抛出异常")
    void validate_missingTemplate_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("outputVariable", "result");

        WorkflowNode node = WorkflowNode.builder()
                .id("template_1")
                .type(NodeType.TEMPLATE)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }
}
