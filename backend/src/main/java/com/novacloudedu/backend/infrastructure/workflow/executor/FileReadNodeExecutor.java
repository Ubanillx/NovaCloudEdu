package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.infrastructure.ai.DocumentParseService;
import com.novacloudedu.backend.infrastructure.ai.DocumentParseService.ParsedDocument;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 文件读取节点执行器
 * <p>
 * 支持三种解析模式：
 * <ul>
 *   <li><b>URL_ONLY</b> — 仅传递文件 URL 和基本元信息，不下载/解析内容（适用于图片、视频、音频等）</li>
 *   <li><b>PARSE</b> — 下载文件并调用 DocumentParseService 解析文档提取文字（支持 PDF/DOCX/TXT/MD/HTML/CSV/JSON 等）</li>
 *   <li><b>RAW_TEXT</b> — 通过 OSS 直接读取原始文本内容（纯文本文件，可指定编码）</li>
 * </ul>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class FileReadNodeExecutor implements NodeExecutor {

    private final OssService ossService;
    private final DocumentParseService documentParseService;

    @Override
    public NodeType getNodeType() {
        return NodeType.FILE_READ;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();

        // --- 解析文件 URL ---
        String fileUrl = resolveFileUrl(config, input);
        if (fileUrl == null || fileUrl.isBlank()) {
            throw new IllegalArgumentException("文件读取节点缺少文件URL（fileUrl 或 fileUrlVariable）");
        }

        String parseMode = (String) config.getOrDefault("parseMode", "PARSE");
        String outputVariable = (String) config.getOrDefault("outputVariable", "fileContent");

        // 从 URL 提取文件名
        String fileName = extractFileName(fileUrl);
        // 推断文件类型
        String fileExtension = extractExtension(fileName).toLowerCase();

        Map<String, Object> result = new HashMap<>();
        result.put("fileUrl", fileUrl);
        result.put("fileName", fileName);
        result.put("fileExtension", fileExtension);

        switch (parseMode.toUpperCase()) {
            case "URL_ONLY" -> {
                // 仅传递 URL，不下载/解析
                log.info("文件读取(URL_ONLY): nodeId={}, url={}", node.getId(), fileUrl);
                result.put(outputVariable, fileUrl);
                result.put("parseMode", "URL_ONLY");
            }
            case "PARSE" -> {
                // 使用 DocumentParseService 解析文档提取文字
                log.info("文件读取(PARSE): nodeId={}, url={}, ext={}", node.getId(), fileUrl, fileExtension);
                ParsedDocument parsed = documentParseService.parseFromUrl(fileUrl);

                result.put(outputVariable, parsed.getTextContent());
                result.put("documentType", parsed.getDocumentType().name());
                result.put("documentTypeLabel", parsed.getDocumentType().getLabel());
                result.put("title", parsed.getTitle());
                result.put("author", parsed.getAuthor());
                result.put("pageCount", parsed.getPageCount());
                result.put("fileSize", parsed.getFileSizeBytes());
                result.put("truncated", parsed.isTruncated());
                result.put("parseMode", "PARSE");
            }
            case "RAW_TEXT" -> {
                // 通过 OSS 直接读取原始文本
                String encoding = (String) config.getOrDefault("encoding", "UTF-8");

                if (!ossService.fileExists(fileUrl)) {
                    throw new IllegalArgumentException("OSS文件不存在: " + fileUrl);
                }

                String content = ossService.readFileAsString(fileUrl, encoding);
                long fileSize = ossService.getFileSize(fileUrl);

                log.info("文件读取(RAW_TEXT): nodeId={}, url={}, size={}", node.getId(), fileUrl, fileSize);

                result.put(outputVariable, content);
                result.put("fileSize", fileSize);
                result.put("parseMode", "RAW_TEXT");
            }
            default -> throw new IllegalArgumentException("不支持的解析模式: " + parseMode);
        }

        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            throw new IllegalArgumentException("文件读取节点缺少配置");
        }
        String fileUrl = (String) config.get("fileUrl");
        String fileUrlVariable = (String) config.get("fileUrlVariable");
        if ((fileUrl == null || fileUrl.isBlank()) && (fileUrlVariable == null || fileUrlVariable.isBlank())) {
            throw new IllegalArgumentException("文件读取节点必须指定 fileUrl 或 fileUrlVariable");
        }
    }

    /**
     * 从配置和上游输入中解析最终的文件 URL
     */
    private String resolveFileUrl(Map<String, Object> config, Map<String, Object> input) {
        String fileUrl = (String) config.get("fileUrl");
        String fileUrlVariable = (String) config.get("fileUrlVariable");

        // 优先从上游变量获取
        if (fileUrlVariable != null && !fileUrlVariable.isBlank() && input.containsKey(fileUrlVariable)) {
            fileUrl = String.valueOf(input.get(fileUrlVariable));
        }

        // 替换 URL 中的变量占位符
        return replaceVariables(fileUrl, input);
    }

    private String extractFileName(String url) {
        if (url == null) return "unknown";
        String path = url;
        int queryIndex = path.indexOf('?');
        if (queryIndex > 0) path = path.substring(0, queryIndex);
        int lastSlash = path.lastIndexOf('/');
        if (lastSlash >= 0) path = path.substring(lastSlash + 1);
        try {
            path = java.net.URLDecoder.decode(path, java.nio.charset.StandardCharsets.UTF_8);
        } catch (Exception ignored) {}
        return path.isEmpty() ? "unknown" : path;
    }

    private String extractExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        return dotIndex >= 0 ? fileName.substring(dotIndex + 1) : "";
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
