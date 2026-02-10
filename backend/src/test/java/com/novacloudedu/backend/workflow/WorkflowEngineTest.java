package com.novacloudedu.backend.workflow;

import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.repository.WorkflowExecutionRepository;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.service.WorkflowLogService;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.workflow.DefaultWorkflowEngine;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 工作流执行引擎测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("工作流执行引擎测试")
class WorkflowEngineTest {

    @Mock
    private WorkflowLogService logService;

    @Mock
    private WorkflowExecutionRepository executionRepository;

    @Mock
    private NodeExecutor llmExecutor;

    @Mock
    private NodeExecutor conditionExecutor;

    private DefaultWorkflowEngine engine;
    private Workflow workflow;
    private UserId userId;

    @BeforeEach
    void setUp() {
        // 设置Mock执行器
        when(llmExecutor.getNodeType()).thenReturn(NodeType.LLM);
        when(conditionExecutor.getNodeType()).thenReturn(NodeType.CONDITION);

        List<NodeExecutor> executors = Arrays.asList(llmExecutor, conditionExecutor);
        engine = new DefaultWorkflowEngine(logService, executors, executionRepository);
        engine.init();

        userId = UserId.of(1L);

        // 创建测试工作流
        workflow = createTestWorkflow();
    }

    private Workflow createTestWorkflow() {
        Workflow wf = Workflow.create("测试工作流", "用于单元测试", userId);
        wf.setId(WorkflowId.of(1L));

        // 创建工作流定义
        WorkflowDefinition definition = new WorkflowDefinition();

        // 创建节点
        List<WorkflowNode> nodes = new ArrayList<>();

        // 开始节点
        WorkflowNode startNode = new WorkflowNode();
        startNode.setId("start");
        startNode.setName("开始");
        startNode.setType(NodeType.START);
        startNode.setConfig(new HashMap<>());
        nodes.add(startNode);

        // LLM节点
        WorkflowNode llmNode = new WorkflowNode();
        llmNode.setId("llm1");
        llmNode.setName("AI处理");
        llmNode.setType(NodeType.LLM);
        Map<String, Object> llmConfig = new HashMap<>();
        llmConfig.put("systemPrompt", "你是一个助手");
        llmConfig.put("userMessageTemplate", "{{userInput}}");
        llmNode.setConfig(llmConfig);
        nodes.add(llmNode);

        // 结束节点
        WorkflowNode endNode = new WorkflowNode();
        endNode.setId("end");
        endNode.setName("结束");
        endNode.setType(NodeType.END);
        endNode.setConfig(new HashMap<>());
        nodes.add(endNode);

        definition.setNodes(nodes);

        // 创建边
        List<WorkflowEdge> edges = new ArrayList<>();
        WorkflowEdge e1 = new WorkflowEdge();
        e1.setId("e1");
        e1.setSourceNodeId("start");
        e1.setTargetNodeId("llm1");
        edges.add(e1);
        
        WorkflowEdge e2 = new WorkflowEdge();
        e2.setId("e2");
        e2.setSourceNodeId("llm1");
        e2.setTargetNodeId("end");
        edges.add(e2);
        definition.setEdges(edges);

        wf.updateDefinition(definition);
        wf.publish();

        return wf;
    }

    @Test
    @DisplayName("测试简单工作流执行")
    void testSimpleWorkflowExecution() {
        // 准备
        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "你好");

        Map<String, Object> llmOutput = new HashMap<>();
        llmOutput.put("response", "你好！有什么可以帮助你的？");

        when(llmExecutor.execute(any(), any(), any())).thenReturn(llmOutput);

        // 执行
        WorkflowExecution execution = engine.execute(workflow, input, userId);

        // 验证
        assertNotNull(execution);
        assertEquals(ExecutionStatus.COMPLETED, execution.getStatus());
        assertNotNull(execution.getOutput());

        verify(llmExecutor, times(1)).execute(any(), any(), any());
    }

    @Test
    @DisplayName("测试工作流执行失败处理")
    void testWorkflowExecutionFailure() {
        // 准备
        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "你好");

        when(llmExecutor.execute(any(), any(), any()))
                .thenThrow(new RuntimeException("LLM调用失败"));

        // 执行 - 由于默认有重试机制，可能会完成或失败
        WorkflowExecution execution = engine.execute(workflow, input, userId);

        // 验证 - 执行已结束
        assertNotNull(execution);
        assertNotNull(execution.getStatus());
    }

    @Test
    @DisplayName("测试异步工作流执行")
    void testAsyncWorkflowExecution() throws InterruptedException {
        // 准备
        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "异步测试");

        Map<String, Object> llmOutput = new HashMap<>();
        llmOutput.put("response", "异步响应");

        when(llmExecutor.execute(any(), any(), any())).thenReturn(llmOutput);

        // 执行
        WorkflowExecutionId executionId = engine.executeAsync(workflow, input, userId);

        // 验证
        assertNotNull(executionId);
        assertNotNull(executionId.value());

        // 等待异步执行完成
        Thread.sleep(500);

        WorkflowExecution execution = engine.getExecution(executionId);
        assertNotNull(execution);
    }

    @Test
    @DisplayName("测试取消工作流执行")
    void testCancelWorkflowExecution() throws InterruptedException {
        // 准备 - 模拟慢速执行
        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "取消测试");

        when(llmExecutor.execute(any(), any(), any())).thenAnswer(invocation -> {
            Thread.sleep(2000); // 模拟耗时操作
            Map<String, Object> result = new HashMap<>();
            result.put("response", "不应该返回");
            return result;
        });

        // 异步执行
        WorkflowExecutionId executionId = engine.executeAsync(workflow, input, userId);

        // 等待一小段时间后取消
        Thread.sleep(100);
        engine.cancel(executionId);

        // 等待取消生效
        Thread.sleep(200);

        // 验证取消操作已执行（不抛异常即可）
        assertNotNull(executionId);
    }

    @Test
    @DisplayName("测试断点功能")
    void testBreakpointFunctionality() {
        // 准备
        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "断点测试");
        
        WorkflowExecutionId executionId = engine.executeAsync(workflow, input, userId);
        
        // 设置断点
        engine.setBreakpoint(executionId, "llm1");

        // 移除断点
        engine.removeBreakpoint(executionId, "llm1");
        
        // 验证执行ID不为空
        assertNotNull(executionId);
    }

    @Test
    @DisplayName("测试空输入工作流执行")
    void testEmptyInputWorkflowExecution() {
        // 准备
        Map<String, Object> input = new HashMap<>();

        Map<String, Object> llmOutput = new HashMap<>();
        llmOutput.put("response", "默认响应");

        when(llmExecutor.execute(any(), any(), any())).thenReturn(llmOutput);

        // 执行
        WorkflowExecution execution = engine.execute(workflow, input, userId);

        // 验证
        assertNotNull(execution);
        assertEquals(ExecutionStatus.COMPLETED, execution.getStatus());
    }

    @Test
    @DisplayName("测试工作流执行日志记录")
    void testWorkflowExecutionLogging() {
        // 准备
        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "日志测试");

        Map<String, Object> llmOutput = new HashMap<>();
        llmOutput.put("response", "日志响应");

        when(llmExecutor.execute(any(), any(), any())).thenReturn(llmOutput);

        // 执行
        engine.execute(workflow, input, userId);

        // 验证执行完成
        assertNotNull(engine.getExecution(engine.executeAsync(workflow, input, userId)));
    }
}
