package com.novacloudedu.backend.infrastructure.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.McpServer;
import jakarta.annotation.PreDestroy;
import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * MCP (Model Context Protocol) 客户端服务
 * <p>
 * 支持两种传输方式：
 * <ul>
 *   <li>stdio — 启动本地进程，通过 stdin/stdout 通信（Claude Code 风格）</li>
 *   <li>streamable-http — 通过 HTTP 与远程 MCP 服务器通信</li>
 * </ul>
 * configJson 中有 "command" 字段时使用 stdio，有 "url" 字段或 McpServer.url 非空时使用 HTTP。
 */
@Slf4j
@Service
public class McpClientService {

    private final ObjectMapper objectMapper = new ObjectMapper();

    /** stdio 连接池: serverId -> StdioConnection */
    private final Map<Long, StdioMcpConnection> stdioConnections = new ConcurrentHashMap<>();

    /** 工具列表缓存: serverId -> CachedTools */
    private final Map<Long, CachedTools> toolsCache = new ConcurrentHashMap<>();

    private static final long CACHE_TTL_MS = 5 * 60 * 1000; // 5分钟缓存

    /** HTTP 客户端（用于 streamable-http 传输） */
    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(15))
            .followRedirects(HttpClient.Redirect.NORMAL)
            .build();

    // ==================== 公开 API ====================

    /**
     * 从 MCP 服务器获取可用工具列表
     */
    public List<McpTool> listTools(McpServer server) {
        Long serverId = server.getId();
        CachedTools cached = toolsCache.get(serverId);
        if (cached != null && !cached.isExpired()) {
            log.debug("MCP 工具列表命中缓存: name={}, toolCount={}", server.getName(), cached.tools.size());
            return cached.tools;
        }

        try {
            JsonNode response = sendJsonRpc(server, "tools/list", Map.of());
            JsonNode result = response.get("result");
            if (result == null || !result.has("tools")) {
                log.warn("MCP 服务器返回空工具列表: name={}", server.getName());
                return Collections.emptyList();
            }

            List<McpTool> tools = new ArrayList<>();
            for (JsonNode toolNode : result.get("tools")) {
                tools.add(McpTool.builder()
                        .name(toolNode.has("name") ? toolNode.get("name").asText() : "")
                        .description(toolNode.has("description") ? toolNode.get("description").asText() : "")
                        .inputSchema(toolNode.has("inputSchema") ? toolNode.get("inputSchema") : null)
                        .build());
            }

            toolsCache.put(serverId, new CachedTools(tools, System.currentTimeMillis()));
            log.info("MCP 工具列表获取成功: name={}, toolCount={}", server.getName(), tools.size());
            return tools;

        } catch (Exception e) {
            log.error("MCP 工具列表获取失败: name={}, error={}", server.getName(), e.getMessage(), e);
            throw new RuntimeException("MCP 服务器连接失败: " + e.getMessage(), e);
        }
    }

    /**
     * 调用 MCP 服务器上的工具
     */
    public String callTool(McpServer server, String toolName, Map<String, Object> arguments) {
        try {
            Map<String, Object> params = new LinkedHashMap<>();
            params.put("name", toolName);
            params.put("arguments", arguments != null ? arguments : Map.of());

            JsonNode response = sendJsonRpc(server, "tools/call", params);
            JsonNode result = response.get("result");
            if (result == null) {
                JsonNode error = response.get("error");
                if (error != null) {
                    String errorMsg = error.has("message") ? error.get("message").asText() : "未知错误";
                    log.error("MCP 工具调用返回错误: tool={}, error={}", toolName, errorMsg);
                    return "[MCP工具调用错误: " + errorMsg + "]";
                }
                return "[MCP工具调用返回空结果]";
            }

            // 解析 content 数组
            if (result.has("content") && result.get("content").isArray()) {
                StringBuilder sb = new StringBuilder();
                for (JsonNode contentItem : result.get("content")) {
                    String type = contentItem.has("type") ? contentItem.get("type").asText() : "text";
                    if ("text".equals(type) && contentItem.has("text")) {
                        if (sb.length() > 0) sb.append("\n");
                        sb.append(contentItem.get("text").asText());
                    } else if ("image".equals(type) && contentItem.has("data")) {
                        if (sb.length() > 0) sb.append("\n");
                        sb.append("[图片数据: ").append(contentItem.get("mimeType").asText("image/png")).append("]");
                    }
                }
                return sb.toString();
            }

            return result.isTextual() ? result.asText() : objectMapper.writeValueAsString(result);

        } catch (Exception e) {
            log.error("MCP 工具调用失败: tool={}, error={}", toolName, e.getMessage(), e);
            return "[MCP工具调用异常: " + e.getMessage() + "]";
        }
    }

    /**
     * 测试 MCP 服务器连接
     */
    public Map<String, String> testConnection(McpServer server) {
        // 对于 stdio，需要先确保连接建立（会自动 initialize）
        // 对于 HTTP，发送 initialize 请求
        if (isStdioTransport(server)) {
            getOrCreateStdioConnection(server); // initialize 在建立连接时自动执行
            Map<String, String> info = new LinkedHashMap<>();
            info.put("transport", "stdio");
            info.put("command", extractCommand(server));
            info.put("status", "connected");
            return info;
        } else {
            JsonNode response = sendHttpJsonRpc(server, "initialize", buildInitializeParams());
            return parseInitializeResult(response);
        }
    }

    /**
     * 清除指定服务器的工具缓存和 stdio 连接
     */
    public void clearToolsCache(Long serverId) {
        toolsCache.remove(serverId);
        StdioMcpConnection conn = stdioConnections.remove(serverId);
        if (conn != null) {
            conn.close();
            log.info("已关闭 MCP stdio 连接: serverId={}", serverId);
        }
    }

    /**
     * 应用关闭时清理所有 stdio 进程
     */
    @PreDestroy
    public void shutdown() {
        log.info("正在关闭所有 MCP stdio 连接, count={}", stdioConnections.size());
        stdioConnections.forEach((id, conn) -> {
            try {
                conn.close();
            } catch (Exception e) {
                log.warn("关闭 MCP stdio 连接失败: serverId={}", id, e);
            }
        });
        stdioConnections.clear();
        toolsCache.clear();
    }

    // ==================== 配置解析 ====================

    /**
     * 解析 configJson，兼容两种格式：
     * <ul>
     *   <li>扁平格式：{"command":"npx","args":[...],"env":{...}}</li>
     *   <li>Claude Code 嵌套格式：{"mcpServers":{"serverName":{"command":"npx","args":[...]}}}</li>
     * </ul>
     * 嵌套格式时自动提取第一个服务器的配置。
     */
    private JsonNode resolveServerConfig(McpServer server) {
        try {
            JsonNode root = objectMapper.readTree(
                    server.getConfigJson() != null ? server.getConfigJson() : "{}");
            // 嵌套格式：{"mcpServers": {"name": {actual config}}}
            if (root.has("mcpServers") && root.get("mcpServers").isObject()) {
                JsonNode mcpServers = root.get("mcpServers");
                Iterator<Map.Entry<String, JsonNode>> fields = mcpServers.fields();
                if (fields.hasNext()) {
                    return fields.next().getValue();
                }
            }
            return root;
        } catch (Exception e) {
            return objectMapper.createObjectNode();
        }
    }

    private boolean isStdioTransport(McpServer server) {
        return resolveServerConfig(server).has("command");
    }

    private String extractCommand(McpServer server) {
        JsonNode config = resolveServerConfig(server);
        return config.has("command") ? config.get("command").asText() : "";
    }

    // ==================== 统一 JSON-RPC 入口 ====================

    private JsonNode sendJsonRpc(McpServer server, String method, Map<String, Object> params) {
        if (isStdioTransport(server)) {
            return sendStdioJsonRpc(server, method, params);
        } else {
            return sendHttpJsonRpc(server, method, params);
        }
    }

    // ==================== Stdio 传输 ====================

    private JsonNode sendStdioJsonRpc(McpServer server, String method, Map<String, Object> params) {
        StdioMcpConnection conn = getOrCreateStdioConnection(server);
        return conn.sendRequest(method, params);
    }

    private synchronized StdioMcpConnection getOrCreateStdioConnection(McpServer server) {
        Long serverId = server.getId();
        StdioMcpConnection existing = stdioConnections.get(serverId);
        if (existing != null && existing.isAlive()) {
            return existing;
        }

        // 解析 configJson（兼容嵌套 mcpServers 格式）
        try {
            JsonNode config = resolveServerConfig(server);
            String command = config.get("command").asText();
            List<String> args = new ArrayList<>();
            if (config.has("args") && config.get("args").isArray()) {
                for (JsonNode arg : config.get("args")) {
                    args.add(arg.asText());
                }
            }
            Map<String, String> env = new LinkedHashMap<>();
            if (config.has("env") && config.get("env").isObject()) {
                config.get("env").fields().forEachRemaining(entry ->
                        env.put(entry.getKey(), entry.getValue().asText()));
            }

            StdioMcpConnection conn = new StdioMcpConnection(objectMapper);
            conn.start(command, args, env);
            conn.initialize();
            stdioConnections.put(serverId, conn);
            log.info("MCP stdio 连接已建立: name={}, command={}", server.getName(), command);
            return conn;

        } catch (Exception e) {
            throw new RuntimeException("启动 MCP stdio 进程失败: " + e.getMessage(), e);
        }
    }

    /**
     * Stdio MCP 连接：管理一个本地进程，通过 stdin/stdout 进行 JSON-RPC 2.0 通信
     */
    private static class StdioMcpConnection {
        private Process process;
        private BufferedWriter stdin;
        private BufferedReader stdout;
        private final ObjectMapper objectMapper;
        private final AtomicInteger requestIdCounter = new AtomicInteger(1);
        /** 收集 stderr 最近的输出，用于在进程异常退出时提供诊断信息 */
        private final List<String> stderrBuffer = Collections.synchronizedList(new ArrayList<>());
        private static final int MAX_STDERR_LINES = 20;

        StdioMcpConnection(ObjectMapper objectMapper) {
            this.objectMapper = objectMapper;
        }

        void start(String command, List<String> args, Map<String, String> env) throws IOException {
            List<String> cmd = new ArrayList<>();
            cmd.add(command);
            cmd.addAll(args);

            ProcessBuilder pb = new ProcessBuilder(cmd);
            pb.redirectErrorStream(false);
            if (env != null && !env.isEmpty()) {
                pb.environment().putAll(env);
            }

            process = pb.start();
            stdin = new BufferedWriter(new OutputStreamWriter(process.getOutputStream()));
            stdout = new BufferedReader(new InputStreamReader(process.getInputStream()));

            // stderr 收集+日志线程
            Thread stderrThread = new Thread(() -> {
                try (BufferedReader errReader = new BufferedReader(
                        new InputStreamReader(process.getErrorStream()))) {
                    String line;
                    while ((line = errReader.readLine()) != null) {
                        log.debug("[MCP-stderr] {}", line);
                        if (!line.isBlank()) {
                            stderrBuffer.add(line);
                            if (stderrBuffer.size() > MAX_STDERR_LINES) {
                                stderrBuffer.remove(0);
                            }
                        }
                    }
                } catch (Exception ignored) {}
            });
            stderrThread.setDaemon(true);
            stderrThread.setName("mcp-stderr-" + process.pid());
            stderrThread.start();

            // 短暂等待，检测进程是否立即退出（如命令不存在、Docker 镜像缺失等）
            try {
                Thread.sleep(500);
            } catch (InterruptedException ignored) {
                Thread.currentThread().interrupt();
            }
            if (!process.isAlive()) {
                int exitCode = process.exitValue();
                String stderrMsg = getStderrSummary();
                throw new IOException("进程立即退出 (exit=" + exitCode + ")"
                        + (stderrMsg.isEmpty() ? "" : ": " + stderrMsg));
            }
        }

        synchronized JsonNode sendRequest(String method, Map<String, Object> params) {
            try {
                int id = requestIdCounter.getAndIncrement();
                Map<String, Object> request = new LinkedHashMap<>();
                request.put("jsonrpc", "2.0");
                request.put("id", id);
                request.put("method", method);
                request.put("params", params != null ? params : Map.of());

                String json = objectMapper.writeValueAsString(request);
                stdin.write(json);
                stdin.newLine();
                stdin.flush();

                // 读取响应，跳过通知（没有 id 的消息）直到匹配我们的请求 id
                while (true) {
                    String line = stdout.readLine();
                    if (line == null) {
                        String stderrMsg = getStderrSummary();
                        throw new RuntimeException("MCP 进程已终止"
                                + (stderrMsg.isEmpty() ? "" : ": " + stderrMsg));
                    }
                    if (line.isBlank()) continue;

                    JsonNode response = objectMapper.readTree(line);
                    // 跳过通知（没有 id 字段的消息）
                    if (!response.has("id")) continue;
                    if (response.get("id").asInt() == id) {
                        // 检查错误
                        if (response.has("error") && !response.get("error").isNull()) {
                            JsonNode error = response.get("error");
                            String errorMsg = error.has("message") ? error.get("message").asText() : "未知错误";
                            log.error("MCP JSON-RPC 错误: code={}, message={}",
                                    error.has("code") ? error.get("code").asInt() : -1, errorMsg);
                        }
                        return response;
                    }
                    // 不匹配的响应，继续读取
                }
            } catch (RuntimeException e) {
                throw e;
            } catch (Exception e) {
                throw new RuntimeException("MCP stdio 通信异常: " + e.getMessage(), e);
            }
        }

        private String getStderrSummary() {
            if (stderrBuffer.isEmpty()) return "";
            return String.join(" | ", stderrBuffer);
        }

        synchronized void sendNotification(String method, Map<String, Object> params) {
            try {
                Map<String, Object> notification = new LinkedHashMap<>();
                notification.put("jsonrpc", "2.0");
                notification.put("method", method);
                if (params != null) {
                    notification.put("params", params);
                }
                String json = objectMapper.writeValueAsString(notification);
                stdin.write(json);
                stdin.newLine();
                stdin.flush();
            } catch (Exception e) {
                throw new RuntimeException("MCP stdio 发送通知失败: " + e.getMessage(), e);
            }
        }

        void initialize() {
            Map<String, Object> params = new LinkedHashMap<>();
            params.put("protocolVersion", "2024-11-05");
            params.put("capabilities", Map.of());
            params.put("clientInfo", Map.of("name", "NovaCloudEdu", "version", "1.0.0"));

            sendRequest("initialize", params);
            sendNotification("notifications/initialized", null);
        }

        boolean isAlive() {
            return process != null && process.isAlive();
        }

        void close() {
            try { if (stdin != null) stdin.close(); } catch (Exception ignored) {}
            try {
                if (process != null) {
                    process.destroyForcibly();
                    process.waitFor(5, java.util.concurrent.TimeUnit.SECONDS);
                }
            } catch (Exception ignored) {}
        }
    }

    // ==================== HTTP 传输 ====================

    private final AtomicInteger httpRequestIdCounter = new AtomicInteger(1);

    private JsonNode sendHttpJsonRpc(McpServer server, String method, Map<String, Object> params) {
        try {
            String url = resolveHttpUrl(server);
            Map<String, String> headers = extractHttpHeaders(server);
            String apiKey = extractHttpApiKey(server);

            Map<String, Object> jsonRpcRequest = new LinkedHashMap<>();
            jsonRpcRequest.put("jsonrpc", "2.0");
            jsonRpcRequest.put("id", httpRequestIdCounter.getAndIncrement());
            jsonRpcRequest.put("method", method);
            jsonRpcRequest.put("params", params != null ? params : Map.of());

            String body = objectMapper.writeValueAsString(jsonRpcRequest);

            HttpRequest.Builder reqBuilder = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .timeout(Duration.ofSeconds(30))
                    .header("Content-Type", "application/json")
                    .header("Accept", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body));

            if (apiKey != null && !apiKey.isBlank()) {
                reqBuilder.header("Authorization", "Bearer " + apiKey);
            }
            if (headers != null) {
                headers.forEach(reqBuilder::header);
            }

            HttpResponse<String> httpResponse = httpClient.send(reqBuilder.build(),
                    HttpResponse.BodyHandlers.ofString());

            if (httpResponse.statusCode() != 200) {
                throw new RuntimeException("MCP HTTP " + httpResponse.statusCode() + ": " + httpResponse.body());
            }

            String responseBody = httpResponse.body();
            if (responseBody.startsWith("data:") || responseBody.contains("\ndata:")) {
                responseBody = extractLastSseData(responseBody);
            }

            return objectMapper.readTree(responseBody);

        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("MCP HTTP 通信异常: " + e.getMessage(), e);
        }
    }

    private String resolveHttpUrl(McpServer server) {
        JsonNode config = resolveServerConfig(server);
        if (config.has("url")) {
            return config.get("url").asText();
        }
        if (server.getUrl() != null && !server.getUrl().isBlank()) {
            return server.getUrl();
        }
        throw new RuntimeException("MCP HTTP 传输缺少 url 配置");
    }

    @SuppressWarnings("unchecked")
    private Map<String, String> extractHttpHeaders(McpServer server) {
        JsonNode config = resolveServerConfig(server);
        if (config.has("headers") && config.get("headers").isObject()) {
            Map<String, String> headers = objectMapper.convertValue(config.get("headers"), Map.class);
            headers.remove("Authorization");
            return headers.isEmpty() ? null : headers;
        }
        return null;
    }

    private String extractHttpApiKey(McpServer server) {
        JsonNode config = resolveServerConfig(server);
        if (config.has("headers") && config.get("headers").isObject()) {
            JsonNode headers = config.get("headers");
            if (headers.has("Authorization")) {
                String auth = headers.get("Authorization").asText("");
                if (auth.startsWith("Bearer ")) {
                    return auth.substring(7).trim();
                }
            }
        }
        return null;
    }

    private Map<String, Object> buildInitializeParams() {
        Map<String, Object> params = new LinkedHashMap<>();
        params.put("protocolVersion", "2024-11-05");
        params.put("capabilities", Map.of());
        params.put("clientInfo", Map.of("name", "NovaCloudEdu", "version", "1.0.0"));
        return params;
    }

    private Map<String, String> parseInitializeResult(JsonNode response) {
        JsonNode result = response.get("result");
        Map<String, String> info = new LinkedHashMap<>();
        if (result != null && result.has("serverInfo")) {
            JsonNode serverInfo = result.get("serverInfo");
            info.put("name", serverInfo.has("name") ? serverInfo.get("name").asText() : "unknown");
            info.put("version", serverInfo.has("version") ? serverInfo.get("version").asText() : "unknown");
        }
        info.put("protocolVersion", result != null && result.has("protocolVersion")
                ? result.get("protocolVersion").asText() : "unknown");
        info.put("transport", "streamable-http");
        return info;
    }

    private String extractLastSseData(String sseBody) {
        String lastData = null;
        for (String line : sseBody.split("\n")) {
            if (line.startsWith("data:")) {
                lastData = line.substring(5).trim();
            }
        }
        return lastData != null ? lastData : sseBody;
    }

    // ==================== 数据模型 ====================

    @Data
    @Builder
    public static class McpTool {
        private String name;
        private String description;
        private JsonNode inputSchema;
    }

    private static class CachedTools {
        final List<McpTool> tools;
        final long timestamp;

        CachedTools(List<McpTool> tools, long timestamp) {
            this.tools = tools;
            this.timestamp = timestamp;
        }

        boolean isExpired() {
            return System.currentTimeMillis() - timestamp > CACHE_TTL_MS;
        }
    }
}
