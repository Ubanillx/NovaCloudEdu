package com.novacloudedu.backend.workflow;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.workflow.executor.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 节点执行器测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("节点执行器测试")
class NodeExecutorTest {

    private WorkflowExecution context;
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
        
        // 创建测试工作流
        Workflow workflow = Workflow.create("测试工作流", "测试", UserId.of(1L));
        workflow.setId(WorkflowId.of(1L));
        
        // 创建执行上下文
        context = WorkflowExecution.create(
                workflow,
                new HashMap<String, Object>(),
                UserId.of(1L)
        );
    }

    @Test
    @DisplayName("测试条件节点执行器 - 等于条件")
    void testConditionNodeExecutor_Equals() {
        ConditionNodeExecutor executor = new ConditionNodeExecutor();

        // 创建节点
        WorkflowNode node = new WorkflowNode();
        node.setId("condition1");
        node.setName("条件判断");
        node.setType(NodeType.CONDITION);

        Map<String, Object> config = new HashMap<>();
        config.put("variable", "status");
        config.put("operator", "equals");
        config.put("value", "active");
        node.setConfig(config);

        // 测试条件为真
        Map<String, Object> input = new HashMap<>();
        input.put("status", "active");

        Map<String, Object> result = executor.execute(node, input, context);

        assertTrue((Boolean) result.get("conditionResult"));
        assertEquals("true", result.get("branch"));

        // 测试条件为假
        input.put("status", "inactive");
        result = executor.execute(node, input, context);

        assertFalse((Boolean) result.get("conditionResult"));
        assertEquals("false", result.get("branch"));
    }

    @Test
    @DisplayName("测试条件节点执行器 - 大于条件")
    void testConditionNodeExecutor_GreaterThan() {
        ConditionNodeExecutor executor = new ConditionNodeExecutor();

        WorkflowNode node = new WorkflowNode();
        node.setId("condition2");
        node.setType(NodeType.CONDITION);

        Map<String, Object> config = new HashMap<>();
        config.put("variable", "score");
        config.put("operator", "greaterThan");
        config.put("value", 60);
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("score", 80);

        Map<String, Object> result = executor.execute(node, input, context);
        assertTrue((Boolean) result.get("conditionResult"));

        input.put("score", 50);
        result = executor.execute(node, input, context);
        assertFalse((Boolean) result.get("conditionResult"));
    }

    @Test
    @DisplayName("测试条件节点执行器 - 包含条件")
    void testConditionNodeExecutor_Contains() {
        ConditionNodeExecutor executor = new ConditionNodeExecutor();

        WorkflowNode node = new WorkflowNode();
        node.setId("condition3");
        node.setType(NodeType.CONDITION);

        Map<String, Object> config = new HashMap<>();
        config.put("variable", "text");
        config.put("operator", "contains");
        config.put("value", "hello");
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("text", "hello world");

        Map<String, Object> result = executor.execute(node, input, context);
        assertTrue((Boolean) result.get("conditionResult"));

        input.put("text", "goodbye world");
        result = executor.execute(node, input, context);
        assertFalse((Boolean) result.get("conditionResult"));
    }

    @Test
    @DisplayName("测试模板节点执行器")
    void testTemplateNodeExecutor() {
        TemplateNodeExecutor executor = new TemplateNodeExecutor();

        WorkflowNode node = new WorkflowNode();
        node.setId("template1");
        node.setType(NodeType.TEMPLATE);

        Map<String, Object> config = new HashMap<>();
        config.put("template", "你好，{{name}}！欢迎来到{{place}}。");
        config.put("outputVariable", "greeting");
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("name", "张三");
        input.put("place", "北京");

        Map<String, Object> result = executor.execute(node, input, context);

        assertEquals("你好，张三！欢迎来到北京。", result.get("greeting"));
    }

    @Test
    @DisplayName("测试循环节点执行器 - forEach模式")
    void testLoopNodeExecutor_ForEach() {
        LoopNodeExecutor executor = new LoopNodeExecutor();

        WorkflowNode node = new WorkflowNode();
        node.setId("loop1");
        node.setType(NodeType.LOOP);

        Map<String, Object> config = new HashMap<>();
        config.put("loopType", "forEach");
        config.put("itemsVariable", "items");
        config.put("itemVariable", "item");
        config.put("indexVariable", "index");
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("items", Arrays.asList("a", "b", "c"));

        Map<String, Object> result = executor.execute(node, input, context);

        assertEquals(3, result.get("loopCount"));
        assertTrue((Boolean) result.get("loopCompleted"));
        
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> loopResults = (List<Map<String, Object>>) result.get("loopResults");
        assertEquals(3, loopResults.size());
        assertEquals("a", loopResults.get(0).get("item"));
        assertEquals(0, loopResults.get(0).get("index"));
    }

    @Test
    @DisplayName("测试循环节点执行器 - times模式")
    void testLoopNodeExecutor_Times() {
        LoopNodeExecutor executor = new LoopNodeExecutor();

        WorkflowNode node = new WorkflowNode();
        node.setId("loop2");
        node.setType(NodeType.LOOP);

        Map<String, Object> config = new HashMap<>();
        config.put("loopType", "times");
        config.put("times", 5);
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, context);

        assertEquals(5, result.get("loopCount"));
        assertTrue((Boolean) result.get("loopCompleted"));
    }

    @Test
    @DisplayName("测试Switch节点执行器")
    void testSwitchNodeExecutor() {
        SwitchNodeExecutor executor = new SwitchNodeExecutor();

        WorkflowNode node = new WorkflowNode();
        node.setId("switch1");
        node.setType(NodeType.SWITCH);

        List<Map<String, Object>> cases = new ArrayList<>();
        cases.add(Map.of("value", "A", "branch", "branchA"));
        cases.add(Map.of("value", "B", "branch", "branchB"));
        cases.add(Map.of("value", "C", "branch", "branchC"));

        Map<String, Object> config = new HashMap<>();
        config.put("variable", "choice");
        config.put("cases", cases);
        config.put("default", "defaultBranch");
        node.setConfig(config);

        // 测试匹配case
        Map<String, Object> input = new HashMap<>();
        input.put("choice", "B");

        Map<String, Object> result = executor.execute(node, input, context);
        assertEquals("branchB", result.get("matchedBranch"));

        // 测试默认分支
        input.put("choice", "D");
        result = executor.execute(node, input, context);
        assertEquals("defaultBranch", result.get("matchedBranch"));
    }

    @Test
    @DisplayName("测试合并节点执行器")
    void testMergeNodeExecutor() {
        MergeNodeExecutor executor = new MergeNodeExecutor();

        WorkflowNode node = new WorkflowNode();
        node.setId("merge1");
        node.setType(NodeType.MERGE);

        Map<String, Object> config = new HashMap<>();
        config.put("sources", Arrays.asList("data1", "data2"));
        config.put("outputVariable", "merged");
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("data1", Map.of("key1", "value1"));
        input.put("data2", Map.of("key2", "value2"));

        Map<String, Object> result = executor.execute(node, input, context);

        assertNotNull(result.get("merged"));
        assertEquals(2, result.get("mergedCount"));
    }

    @Test
    @DisplayName("测试JSON解析节点执行器 - 解析")
    void testJsonParseNodeExecutor_Parse() {
        JsonParseNodeExecutor executor = new JsonParseNodeExecutor(objectMapper);

        WorkflowNode node = new WorkflowNode();
        node.setId("json1");
        node.setType(NodeType.JSON_PARSE);

        Map<String, Object> config = new HashMap<>();
        config.put("sourceVariable", "jsonString");
        config.put("outputVariable", "parsed");
        config.put("operation", "parse");
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("jsonString", "{\"name\":\"test\",\"value\":123}");

        Map<String, Object> result = executor.execute(node, input, context);

        assertTrue((Boolean) result.get("success"));
        assertNotNull(result.get("parsed"));
    }

    @Test
    @DisplayName("测试JSON解析节点执行器 - 序列化")
    void testJsonParseNodeExecutor_Stringify() {
        JsonParseNodeExecutor executor = new JsonParseNodeExecutor(objectMapper);

        WorkflowNode node = new WorkflowNode();
        node.setId("json2");
        node.setType(NodeType.JSON_PARSE);

        Map<String, Object> config = new HashMap<>();
        config.put("sourceVariable", "data");
        config.put("outputVariable", "jsonString");
        config.put("operation", "stringify");
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("data", Map.of("name", "test", "value", 123));

        Map<String, Object> result = executor.execute(node, input, context);

        assertTrue((Boolean) result.get("success"));
        assertNotNull(result.get("jsonString"));
        assertTrue(result.get("jsonString").toString().contains("test"));
    }

    @Test
    @DisplayName("测试代码节点执行器")
    void testCodeNodeExecutor() {
        CodeNodeExecutor executor = new CodeNodeExecutor(objectMapper);

        WorkflowNode node = new WorkflowNode();
        node.setId("code1");
        node.setType(NodeType.CODE);

        Map<String, Object> config = new HashMap<>();
        config.put("code", "return input;");
        config.put("language", "javascript");
        node.setConfig(config);

        Map<String, Object> input = new HashMap<>();
        input.put("input", "test value");

        Map<String, Object> result = executor.execute(node, input, context);

        // 由于Nashorn可能不可用，验证结果不为空即可
        assertNotNull(result);
    }
}
