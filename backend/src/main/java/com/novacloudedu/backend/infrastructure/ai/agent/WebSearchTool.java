package com.novacloudedu.backend.infrastructure.ai.agent;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.agent.tool.P;
import dev.langchain4j.agent.tool.Tool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Map;

/**
 * 联网搜索工具 — 供 Agent 自主调用
 *
 * 通过 Tavily Search API 进行联网搜索，返回与查询主题相关的权威内容摘要。
 * Tavily 专为 AI Agent 设计，返回结构化、高质量的搜索结果。
 */
@Slf4j
@Component
public class WebSearchTool {

    private static final String TAVILY_API_URL = "https://api.tavily.com/search";
    private static final HttpClient HTTP_CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();
    private static final ObjectMapper MAPPER = new ObjectMapper();

    @Value("${tavily.api-key:}")
    private String tavilyApiKey;

    @Tool("搜索互联网获取与指定主题相关的最新、权威信息。返回内容摘要，适合用于PPT内容素材收集。")
    public String searchWeb(
            @P("搜索查询关键词，尽量具体明确") String query) {

        log.info("Tavily searchWeb: query={}", query);
        return callTavily(query, "basic", 5);
    }

    @Tool("对指定主题进行深度研究，搜索多个角度的信息并汇总为结构化报告。适合为PPT某个章节收集详细素材。")
    public String deepResearch(
            @P("研究主题") String topic,
            @P("需要关注的具体方面，用逗号分隔") String aspects) {

        log.info("Tavily deepResearch: topic={}, aspects={}", topic, aspects);
        String combinedQuery = topic + " " + aspects;
        return callTavily(combinedQuery, "advanced", 8);
    }

    /**
     * 调用 Tavily Search API
     */
    private String callTavily(String query, String searchDepth, int maxResults) {
        if (tavilyApiKey == null || tavilyApiKey.isBlank()) {
            log.warn("Tavily API key 未配置，跳过搜索");
            return "搜索不可用：Tavily API key 未配置";
        }

        try {
            Map<String, Object> body = Map.of(
                    "query", query,
                    "search_depth", searchDepth,
                    "max_results", maxResults,
                    "include_answer", true
            );

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(TAVILY_API_URL))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + tavilyApiKey)
                    .POST(HttpRequest.BodyPublishers.ofString(MAPPER.writeValueAsString(body)))
                    .timeout(Duration.ofSeconds(30))
                    .build();

            HttpResponse<String> response = HTTP_CLIENT.send(
                    request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                log.error("Tavily API 返回错误: status={}, body={}",
                        response.statusCode(), response.body());
                return "搜索失败: HTTP " + response.statusCode();
            }

            return formatTavilyResponse(response.body(), query);

        } catch (Exception e) {
            log.error("Tavily 搜索异常: query={}", query, e);
            return "搜索异常: " + e.getMessage();
        }
    }

    /**
     * 将 Tavily 响应格式化为 Agent 友好的文本
     */
    private String formatTavilyResponse(String responseBody, String query) {
        try {
            JsonNode root = MAPPER.readTree(responseBody);
            StringBuilder sb = new StringBuilder();

            // Tavily 的 AI 汇总答案
            String answer = root.path("answer").asText("");
            if (!answer.isBlank()) {
                sb.append("## Summary\n").append(answer).append("\n\n");
            }

            // 逐条搜索结果
            JsonNode results = root.path("results");
            if (results.isArray() && !results.isEmpty()) {
                sb.append("## Sources\n");
                for (int i = 0; i < results.size(); i++) {
                    JsonNode r = results.get(i);
                    String title = r.path("title").asText("");
                    String url = r.path("url").asText("");
                    String content = r.path("content").asText("");
                    sb.append(String.format("### %d. %s\n", i + 1, title));
                    sb.append(content).append("\n");
                    sb.append("Source: ").append(url).append("\n\n");
                }
            }

            String formatted = sb.toString();
            log.info("Tavily 搜索完成: query={}, 结果长度={}", query, formatted.length());
            return formatted.isBlank() ? "未找到相关结果" : formatted;

        } catch (Exception e) {
            log.warn("Tavily 响应解析失败，返回原始内容", e);
            return responseBody;
        }
    }
}
