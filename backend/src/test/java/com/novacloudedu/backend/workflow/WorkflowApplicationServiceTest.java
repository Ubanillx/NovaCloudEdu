package com.novacloudedu.backend.workflow;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.application.service.WorkflowApplicationService;
import com.novacloudedu.backend.domain.ai.entity.Workflow;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.repository.WorkflowRepository;
import com.novacloudedu.backend.domain.ai.service.WorkflowEngine;
import com.novacloudedu.backend.domain.ai.service.WorkflowLogService;
import com.novacloudedu.backend.domain.ai.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 工作流应用服务测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("工作流应用服务测试")
class WorkflowApplicationServiceTest {

    @Mock
    private WorkflowRepository workflowRepository;

    @Mock
    private WorkflowEngine workflowEngine;

    @Mock
    private WorkflowLogService logService;

    @Spy
    private ObjectMapper objectMapper = new ObjectMapper();

    @InjectMocks
    private WorkflowApplicationService service;

    private Workflow testWorkflow;
    private UserId userId;

    @BeforeEach
    void setUp() {
        userId = UserId.of(1L);
        testWorkflow = createTestWorkflow();
    }

    private Workflow createTestWorkflow() {
        Workflow wf = Workflow.create("测试工作流", "测试描述", userId);
        wf.setId(WorkflowId.of(1L));
        return wf;
    }

    @Test
    @DisplayName("测试创建工作流")
    void testCreateWorkflow() {
        // 准备
        when(workflowRepository.save(any(Workflow.class))).thenAnswer(invocation -> {
            Workflow wf = invocation.getArgument(0);
            wf.setId(WorkflowId.of(1L));
            return wf;
        });

        // 执行
        WorkflowApplicationService.WorkflowVO result = service.create(1L, "新工作流", "描述");

        // 验证
        assertNotNull(result);
        assertEquals("新工作流", result.getName());
        assertEquals("描述", result.getDescription());
        verify(workflowRepository, times(1)).save(any(Workflow.class));
    }

    @Test
    @DisplayName("测试获取工作流详情")
    void testGetWorkflowById() {
        // 准备
        when(workflowRepository.findById(WorkflowId.of(1L)))
                .thenReturn(Optional.of(testWorkflow));

        // 执行
        WorkflowApplicationService.WorkflowVO result = service.getById(1L);

        // 验证
        assertNotNull(result);
        assertEquals(1L, result.getId());
        assertEquals("测试工作流", result.getName());
    }

    @Test
    @DisplayName("测试获取不存在的工作流")
    void testGetNonExistentWorkflow() {
        // 准备
        when(workflowRepository.findById(WorkflowId.of(999L)))
                .thenReturn(Optional.empty());

        // 执行 & 验证
        assertThrows(IllegalArgumentException.class, () -> service.getById(999L));
    }

    @Test
    @DisplayName("测试更新工作流基本信息")
    void testUpdateWorkflowBasicInfo() {
        // 准备
        when(workflowRepository.findById(WorkflowId.of(1L)))
                .thenReturn(Optional.of(testWorkflow));
        when(workflowRepository.save(any(Workflow.class)))
                .thenReturn(testWorkflow);

        // 执行
        WorkflowApplicationService.WorkflowVO result = service.updateBasicInfo(1L, "更新后名称", "更新后描述");

        // 验证
        assertNotNull(result);
        verify(workflowRepository, times(1)).save(any(Workflow.class));
    }

    @Test
    @DisplayName("测试发布工作流")
    void testPublishWorkflow() {
        // 准备
        when(workflowRepository.findById(WorkflowId.of(1L)))
                .thenReturn(Optional.of(testWorkflow));
        when(workflowRepository.save(any(Workflow.class)))
                .thenReturn(testWorkflow);

        // 执行
        WorkflowApplicationService.WorkflowVO result = service.publish(1L);

        // 验证
        assertNotNull(result);
        verify(workflowRepository, times(1)).save(any(Workflow.class));
    }

    @Test
    @DisplayName("测试归档工作流")
    void testArchiveWorkflow() {
        // 准备
        testWorkflow.publish(); // 先发布
        when(workflowRepository.findById(WorkflowId.of(1L)))
                .thenReturn(Optional.of(testWorkflow));
        when(workflowRepository.save(any(Workflow.class)))
                .thenReturn(testWorkflow);

        // 执行
        WorkflowApplicationService.WorkflowVO result = service.archive(1L);

        // 验证
        assertNotNull(result);
        verify(workflowRepository, times(1)).save(any(Workflow.class));
    }

    @Test
    @DisplayName("测试删除工作流")
    void testDeleteWorkflow() {
        // 执行
        service.delete(1L);

        // 验证
        verify(workflowRepository, times(1)).delete(WorkflowId.of(1L));
    }

    @Test
    @DisplayName("测试执行工作流")
    void testExecuteWorkflow() {
        // 准备
        testWorkflow.publish();
        when(workflowRepository.findById(WorkflowId.of(1L)))
                .thenReturn(Optional.of(testWorkflow));

        WorkflowExecution execution = WorkflowExecution.create(
                testWorkflow,
                new HashMap<String, Object>(),
                userId
        );
        execution.start();
        execution.complete(Map.of("result", "success"));

        when(workflowEngine.execute(any(Workflow.class), any(), any(UserId.class)))
                .thenReturn(execution);

        // 执行
        Map<String, Object> input = Map.of("userInput", "测试输入");
        WorkflowApplicationService.ExecutionResultVO result = service.execute(1L, input, 1L);

        // 验证
        assertNotNull(result);
        assertNotNull(result.getStatus());
        verify(workflowEngine, times(1)).execute(any(), any(), any());
    }

    @Test
    @DisplayName("测试异步执行工作流")
    void testExecuteWorkflowAsync() {
        // 准备
        testWorkflow.publish();
        when(workflowRepository.findById(WorkflowId.of(1L)))
                .thenReturn(Optional.of(testWorkflow));

        WorkflowExecutionId executionId = WorkflowExecutionId.of("exec-123");
        when(workflowEngine.executeAsync(any(Workflow.class), any(), any(UserId.class)))
                .thenReturn(executionId);

        // 执行
        Map<String, Object> input = Map.of("userInput", "异步测试");
        String result = service.executeAsync(1L, input, 1L);

        // 验证
        assertNotNull(result);
        assertEquals("exec-123", result);
        verify(workflowEngine, times(1)).executeAsync(any(), any(), any());
    }

    @Test
    @DisplayName("测试获取执行状态")
    void testGetExecutionStatus() {
        // 准备
        WorkflowExecution execution = WorkflowExecution.create(
                testWorkflow,
                new HashMap<String, Object>(),
                userId
        );

        when(workflowEngine.getExecution(any(WorkflowExecutionId.class)))
                .thenReturn(execution);

        // 执行
        WorkflowApplicationService.ExecutionResultVO result = service.getExecutionStatus("exec-123");

        // 验证
        assertNotNull(result);
        assertNotNull(result.getStatus());
    }

    @Test
    @DisplayName("测试取消执行")
    void testCancelExecution() {
        // 执行
        service.cancelExecution("exec-123");

        // 验证
        verify(workflowEngine, times(1)).cancel(any(WorkflowExecutionId.class));
    }

    @Test
    @DisplayName("测试获取用户工作流列表")
    void testListByUser() {
        // 准备
        List<Workflow> workflows = Arrays.asList(testWorkflow);
        when(workflowRepository.findByCreatorId(any(UserId.class), eq(0), eq(20)))
                .thenReturn(workflows);

        // 执行
        List<WorkflowApplicationService.WorkflowVO> result = service.listByUser(1L, 0, 20);

        // 验证
        assertNotNull(result);
        assertEquals(1, result.size());
    }

    @Test
    @DisplayName("测试获取公开工作流列表")
    void testListPublic() {
        // 准备
        testWorkflow.publish();
        testWorkflow.setPublic(true);
        List<Workflow> workflows = Arrays.asList(testWorkflow);
        when(workflowRepository.findPublicWorkflows(eq(0), eq(20)))
                .thenReturn(workflows);

        // 执行
        List<WorkflowApplicationService.WorkflowVO> result = service.listPublic(0, 20);

        // 验证
        assertNotNull(result);
        assertEquals(1, result.size());
    }
}
