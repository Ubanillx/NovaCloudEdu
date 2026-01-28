package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.ai.DashScopeLlmService;
import com.novacloudedu.backend.infrastructure.workflow.executor.IntentRecognitionNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

/**
 * 意图识别节点执行器单元测试
 */
@DisplayName("IntentRecognitionNodeExecutor 单元测试")
class IntentRecognitionNodeExecutorTest {

    @Mock
    private DashScopeLlmService llmService;

    private IntentRecognitionNodeExecutor executor;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        executor = new IntentRecognitionNodeExecutor(llmService);
    }

    @Test
    @DisplayName("获取节点类型应返回INTENT_RECOGNITION")
    void getNodeType_shouldReturnIntentRecognition() {
        assertEquals(NodeType.INTENT_RECOGNITION, executor.getNodeType());
    }

    @Test
    @DisplayName("执行 - 应调用LLM并识别意图")
    void execute_shouldCallLlmAndRecognizeIntent() {
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("{\"intent\":\"GREETING\",\"confidence\":0.95}");

        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("intents", List.of(
                Map.of("name", "GREETING", "description", "问候"),
                Map.of("name", "QUERY", "description", "查询")
        ));
        config.put("outputVariable", "intent");

        WorkflowNode node = WorkflowNode.builder()
                .id("intent_1")
                .type(NodeType.INTENT_RECOGNITION)
                .name("意图识别")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "你好");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("GREETING", result.get("intent"));
        assertEquals(0.95, (Double) result.get("confidence"), 0.01);
    }

    @Test
    @DisplayName("执行 - 低置信度应返回UNKNOWN")
    void execute_lowConfidence_shouldReturnUnknown() {
        when(llmService.chatWithSystemPrompt(anyString(), anyString()))
                .thenReturn("{\"intent\":\"GREETING\",\"confidence\":0.3}");

        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("intents", List.of(
                Map.of("name", "GREETING", "description", "问候")
        ));
        config.put("confidenceThreshold", 0.6);

        WorkflowNode node = WorkflowNode.builder()
                .id("intent_1")
                .type(NodeType.INTENT_RECOGNITION)
                .name("意图识别")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "随便说点什么");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("UNKNOWN", result.get("intent"));
    }

    @Test
    @DisplayName("执行 - 空文本应返回UNKNOWN")
    void execute_emptyText_shouldReturnUnknown() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("intents", List.of(
                Map.of("name", "GREETING", "description", "问候")
        ));

        WorkflowNode node = WorkflowNode.builder()
                .id("intent_1")
                .type(NodeType.INTENT_RECOGNITION)
                .name("意图识别")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("text", "");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("UNKNOWN", result.get("intent"));
        assertEquals(0.0, (Double) result.get("confidence"), 0.01);
    }

    @Test
    @DisplayName("验证 - 缺少textVariable配置应抛出异常")
    void validate_missingTextVariable_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("intents", List.of(Map.of("name", "GREETING")));

        WorkflowNode node = WorkflowNode.builder()
                .id("intent_1")
                .type(NodeType.INTENT_RECOGNITION)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少intents配置应抛出异常")
    void validate_missingIntents_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");

        WorkflowNode node = WorkflowNode.builder()
                .id("intent_1")
                .type(NodeType.INTENT_RECOGNITION)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 完整配置应通过")
    void validate_withCompleteConfig_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("textVariable", "text");
        config.put("intents", List.of(Map.of("name", "GREETING", "description", "问候")));

        WorkflowNode node = WorkflowNode.builder()
                .id("intent_1")
                .type(NodeType.INTENT_RECOGNITION)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
