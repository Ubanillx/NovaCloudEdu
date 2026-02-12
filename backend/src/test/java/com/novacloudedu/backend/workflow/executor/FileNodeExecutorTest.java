package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.infrastructure.ai.DocumentParseService;
import com.novacloudedu.backend.infrastructure.workflow.executor.FileReadNodeExecutor;
import com.novacloudedu.backend.infrastructure.workflow.executor.FileWriteNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 文件读写节点执行器单元测试（OSS版）
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("FileRead/WriteNodeExecutor 单元测试")
class FileNodeExecutorTest {

    @Mock
    private OssService ossService;

    @Mock
    private DocumentParseService documentParseService;

    private FileReadNodeExecutor readExecutor;
    private FileWriteNodeExecutor writeExecutor;

    @BeforeEach
    void setUp() {
        readExecutor = new FileReadNodeExecutor(ossService, documentParseService);
        writeExecutor = new FileWriteNodeExecutor(ossService);
    }

    @Test
    @DisplayName("FileReadNodeExecutor 节点类型应返回 FILE_READ")
    void readExecutor_getNodeType_shouldReturnFileRead() {
        assertEquals(NodeType.FILE_READ, readExecutor.getNodeType());
    }

    @Test
    @DisplayName("FileWriteNodeExecutor 节点类型应返回 FILE_WRITE")
    void writeExecutor_getNodeType_shouldReturnFileWrite() {
        assertEquals(NodeType.FILE_WRITE, writeExecutor.getNodeType());
    }

    @Test
    @DisplayName("读取验证 - 缺少 fileUrl 和 fileUrlVariable 应抛出异常")
    void readValidate_missingFileUrl_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();

        WorkflowNode node = WorkflowNode.builder()
                .id("file_1")
                .type(NodeType.FILE_READ)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> readExecutor.validate(node));
    }

    @Test
    @DisplayName("读取验证 - 缺少 config 应抛出异常")
    void readValidate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("file_1")
                .type(NodeType.FILE_READ)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> readExecutor.validate(node));
    }

    @Test
    @DisplayName("读取验证 - 有 fileUrl 配置应通过")
    void readValidate_withFileUrl_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("fileUrl", "https://oss.example.com/workflow/file/test.txt");

        WorkflowNode node = WorkflowNode.builder()
                .id("file_1")
                .type(NodeType.FILE_READ)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> readExecutor.validate(node));
    }

    @Test
    @DisplayName("写入验证 - 缺少 contentVariable 和 content 应抛出异常")
    void writeValidate_missingContent_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();

        WorkflowNode node = WorkflowNode.builder()
                .id("file_2")
                .type(NodeType.FILE_WRITE)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> writeExecutor.validate(node));
    }

    @Test
    @DisplayName("写入验证 - 有 contentVariable 应通过")
    void writeValidate_withContentVariable_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("contentVariable", "llmOutput");
        config.put("fileName", "result.txt");

        WorkflowNode node = WorkflowNode.builder()
                .id("file_2")
                .type(NodeType.FILE_WRITE)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> writeExecutor.validate(node));
    }
}
