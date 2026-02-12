package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 文件写入节点执行器
 * 将工作流中的文本内容写入 OSS 对象存储
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class FileWriteNodeExecutor implements NodeExecutor {

    private final OssService ossService;

    @Override
    public NodeType getNodeType() {
        return NodeType.FILE_WRITE;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();

        // 写入内容来源：优先从上游变量获取，其次从配置中获取
        String contentVariable = (String) config.get("contentVariable");
        String content = null;

        if (contentVariable != null && !contentVariable.isBlank() && input.containsKey(contentVariable)) {
            Object rawContent = input.get(contentVariable);
            content = rawContent != null ? String.valueOf(rawContent) : "";
        }

        if (content == null) {
            String contentTemplate = (String) config.get("content");
            content = contentTemplate != null ? replaceVariables(contentTemplate, input) : "";
        }

        // 文件名（支持变量替换）
        String fileNameTemplate = (String) config.getOrDefault("fileName", "output.txt");
        String fileName = replaceVariables(fileNameTemplate, input);

        String encoding = (String) config.getOrDefault("encoding", "UTF-8");

        // 追加模式：如果指定了 appendToUrl，先读取旧内容再拼接
        Boolean append = (Boolean) config.getOrDefault("append", false);
        String appendToUrl = (String) config.get("appendToUrl");
        String appendToUrlVariable = (String) config.get("appendToUrlVariable");

        if (append != null && append) {
            String existingUrl = appendToUrl;
            if (appendToUrlVariable != null && !appendToUrlVariable.isBlank() && input.containsKey(appendToUrlVariable)) {
                existingUrl = String.valueOf(input.get(appendToUrlVariable));
            }
            if (existingUrl != null && !existingUrl.isBlank() && ossService.fileExists(existingUrl)) {
                String existingContent = ossService.readFileAsString(existingUrl, encoding);
                content = existingContent + content;
            }
        }

        // 上传到 OSS
        String fileUrl = ossService.uploadString(content, fileName, encoding, FileBusinessType.WORKFLOW_FILE);
        long fileSize = content.getBytes(java.nio.charset.Charset.forName(encoding)).length;

        log.info("文件写入完成: nodeId={}, url={}, fileName={}, size={}", node.getId(), fileUrl, fileName, fileSize);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("fileUrl", fileUrl);
        result.put("fileName", fileName);
        result.put("fileSize", fileSize);

        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            throw new IllegalArgumentException("文件写入节点缺少配置");
        }
        // 写入内容必须有来源：contentVariable 或 content
        String contentVariable = (String) config.get("contentVariable");
        String content = (String) config.get("content");
        if ((contentVariable == null || contentVariable.isBlank()) && (content == null || content.isBlank())) {
            throw new IllegalArgumentException("文件写入节点必须指定 contentVariable 或 content");
        }
    }

    private String replaceVariables(String template, Map<String, Object> variables) {
        if (template == null) return null;
        String result = template;
        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            String value = entry.getValue() != null ? String.valueOf(entry.getValue()) : "";
            result = result.replace(placeholder, value);
        }
        return result;
    }
}
