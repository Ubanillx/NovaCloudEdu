package com.novacloudedu.backend.infrastructure.ai;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.novacloudedu.backend.domain.ai.service.RerankService;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 基于 DashScope Rerank API 的文档重排序服务实现
 * 
 * API 文档: https://help.aliyun.com/zh/model-studio/text-rerank-api
 */
@Slf4j
@Service
public class DashScopeRerankService implements RerankService {

    private static final String RERANK_URL = "https://dashscope.aliyuncs.com/compatible-api/v1/reranks";
    private static final MediaType JSON_MEDIA_TYPE = MediaType.parse("application/json; charset=utf-8");
    private static final Gson gson = new Gson();

    private final OkHttpClient httpClient;

    @Value("${ai.dashscope.api-key}")
    private String apiKey;

    @Value("${ai.dashscope.rerank.model-name:gte-rerank}")
    private String modelName;

    @Value("${ai.dashscope.rerank.enabled:true}")
    private boolean enabled;

    public DashScopeRerankService() {
        this.httpClient = new OkHttpClient.Builder()
                .connectTimeout(30, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .writeTimeout(30, TimeUnit.SECONDS)
                .build();
    }

    @Override
    public List<RerankResult> rerank(String query, List<String> documents, int topN) {
        if (!enabled) {
            log.debug("Rerank 未启用，跳过重排序");
            return buildPassthroughResults(documents, topN);
        }

        if (query == null || query.trim().isEmpty() || documents == null || documents.isEmpty()) {
            log.warn("Rerank 参数无效: query为空或documents为空");
            return buildPassthroughResults(documents, topN);
        }

        log.info("执行 Rerank: model={}, query长度={}, documents数={}, topN={}",
                modelName, query.length(), documents.size(), topN);

        try {
            // 构建请求体
            JsonObject requestBody = new JsonObject();
            requestBody.addProperty("model", modelName);
            requestBody.addProperty("query", query);
            requestBody.addProperty("top_n", Math.min(topN, documents.size()));
            requestBody.addProperty("return_documents", true);

            JsonArray docsArray = new JsonArray();
            for (String doc : documents) {
                docsArray.add(doc);
            }
            requestBody.add("documents", docsArray);

            // 发送请求
            Request request = new Request.Builder()
                    .url(RERANK_URL)
                    .addHeader("Authorization", "Bearer " + apiKey)
                    .addHeader("Content-Type", "application/json")
                    .post(RequestBody.create(gson.toJson(requestBody), JSON_MEDIA_TYPE))
                    .build();

            try (Response response = httpClient.newCall(request).execute()) {
                if (!response.isSuccessful()) {
                    String errorBody = response.body() != null ? response.body().string() : "无响应体";
                    log.error("Rerank API 调用失败: status={}, body={}", response.code(), errorBody);
                    return buildPassthroughResults(documents, topN);
                }

                String responseBody = response.body().string();
                return parseRerankResponse(responseBody, documents);
            }

        } catch (IOException e) {
            log.error("Rerank API 网络异常", e);
            return buildPassthroughResults(documents, topN);
        } catch (Exception e) {
            log.error("Rerank 处理异常", e);
            return buildPassthroughResults(documents, topN);
        }
    }

    /**
     * 解析 Rerank API 响应
     */
    private List<RerankResult> parseRerankResponse(String responseBody, List<String> originalDocuments) {
        List<RerankResult> results = new ArrayList<>();

        try {
            JsonObject json = gson.fromJson(responseBody, JsonObject.class);
            JsonArray resultsArray = json.getAsJsonObject("output").getAsJsonArray("results");

            for (JsonElement element : resultsArray) {
                JsonObject result = element.getAsJsonObject();
                int index = result.get("index").getAsInt();
                double score = result.get("relevance_score").getAsDouble();

                // 优先使用返回的文档文本，回退到原始文档
                String documentText;
                if (result.has("document") && result.getAsJsonObject("document").has("text")) {
                    documentText = result.getAsJsonObject("document").get("text").getAsString();
                } else {
                    documentText = index < originalDocuments.size() ? originalDocuments.get(index) : "";
                }

                results.add(new RerankResult(index, score, documentText));
            }

            log.info("Rerank 完成: 返回{}个结果, 最高分={}, 最低分={}",
                    results.size(),
                    results.isEmpty() ? 0 : results.get(0).relevanceScore(),
                    results.isEmpty() ? 0 : results.get(results.size() - 1).relevanceScore());

        } catch (Exception e) {
            log.error("解析 Rerank 响应失败: {}", responseBody, e);
            return buildPassthroughResults(originalDocuments, originalDocuments.size());
        }

        return results;
    }

    /**
     * 当 Rerank 不可用时，按原始顺序返回结果（降级策略）
     */
    private List<RerankResult> buildPassthroughResults(List<String> documents, int topN) {
        if (documents == null || documents.isEmpty()) {
            return new ArrayList<>();
        }
        List<RerankResult> results = new ArrayList<>();
        int limit = Math.min(topN, documents.size());
        for (int i = 0; i < limit; i++) {
            results.add(new RerankResult(i, 1.0 - (i * 0.01), documents.get(i)));
        }
        return results;
    }

    /**
     * 是否启用了 Rerank
     */
    public boolean isEnabled() {
        return enabled;
    }
}
