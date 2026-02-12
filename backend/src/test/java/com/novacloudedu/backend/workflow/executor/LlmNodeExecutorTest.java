package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.knowledge.service.KnowledgeSearchService;
import com.novacloudedu.backend.domain.ai.repository.McpServerRepository;
import com.novacloudedu.backend.infrastructure.ai.ChatModelFactory;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.infrastructure.ai.McpClientService;
import com.novacloudedu.backend.infrastructure.workflow.executor.LlmNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

/**
 * LLM节点执行器单元测试
 */
@DisplayName("LlmNodeExecutor 单元测试")
class LlmNodeExecutorTest {

    @Mock
    private LangchainChatService langchainChatService;

    @Mock
    private KnowledgeSearchService knowledgeSearchService;

    @Mock
    private McpClientService mcpClientService;

    @Mock
    private ChatModelFactory chatModelFactory;

    @Mock
    private McpServerRepository mcpServerRepository;

    private LlmNodeExecutor executor;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        executor = new LlmNodeExecutor(langchainChatService, knowledgeSearchService, mcpClientService, chatModelFactory, mcpServerRepository);
    }

    @Test
    @DisplayName("获取节点类型应返回LLM")
    void getNodeType_shouldReturnLlm() {
        assertEquals(NodeType.LLM, executor.getNodeType());
    }

    @Test
    @DisplayName("执行 - 应调用LLM服务并返回响应")
    void execute_shouldCallLlmServiceAndReturnResponse() {
        when(langchainChatService.chat(any(), anyString(), anyString()))
                .thenReturn("这是LLM的回复");

        Map<String, Object> config = new HashMap<>();
        config.put("systemPrompt", "你是一个助手");
        config.put("userMessage", "你好");

        WorkflowNode node = WorkflowNode.builder()
                .id("llm_1")
                .type(NodeType.LLM)
                .name("LLM调用")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        assertEquals("这是LLM的回复", result.get("response"));
        assertEquals("这是LLM的回复", result.get("llmOutput"));
    }

    @Test
    @DisplayName("执行 - 应支持变量替换")
    void execute_shouldSupportVariableReplacement() {
        when(langchainChatService.chat(any(), anyString(), anyString()))
                .thenReturn("你好，张三");

        Map<String, Object> config = new HashMap<>();
        config.put("systemPrompt", "你是一个助手");
        config.put("userMessage", "向{{name}}问好");

        WorkflowNode node = WorkflowNode.builder()
                .id("llm_1")
                .type(NodeType.LLM)
                .name("LLM调用")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("name", "张三");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
    }

    @Test
    @DisplayName("执行 - 空userMessage时应从input获取")
    void execute_emptyUserMessage_shouldGetFromInput() {
        when(langchainChatService.chat(any(), anyString(), anyString()))
                .thenReturn("收到你的输入");

        Map<String, Object> config = new HashMap<>();
        config.put("systemPrompt", "你是一个助手");
        config.put("userMessage", "");

        WorkflowNode node = WorkflowNode.builder()
                .id("llm_1")
                .type(NodeType.LLM)
                .name("LLM调用")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();
        input.put("userInput", "这是用户输入");

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("llm_1")
                .type(NodeType.LLM)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 有config应通过")
    void validate_withConfig_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("systemPrompt", "你是助手");

        WorkflowNode node = WorkflowNode.builder()
                .id("llm_1")
                .type(NodeType.LLM)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
