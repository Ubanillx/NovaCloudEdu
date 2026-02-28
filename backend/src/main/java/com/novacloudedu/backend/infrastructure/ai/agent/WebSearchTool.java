package com.novacloudedu.backend.infrastructure.ai.agent;

import dev.langchain4j.agent.tool.P;
import dev.langchain4j.agent.tool.Tool;
import com.novacloudedu.backend.infrastructure.ai.ChatModelFactory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 联网搜索工具 — 供 Agent 自主调用
 *
 * 利用 DashScope 模型内置的 enableSearch 能力进行联网搜索，
 * 返回与查询主题相关的权威内容摘要。
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class WebSearchTool {

    private final ChatModelFactory chatModelFactory;

    private static final String SEARCH_MODEL = "dashscope/qwen-max";

    @Tool("搜索互联网获取与指定主题相关的最新、权威信息。返回内容摘要，适合用于PPT内容素材收集。")
    public String searchWeb(
            @P("搜索查询关键词，尽量具体明确") String query) {

        log.info("Agent WebSearchTool 调用: query={}", query);

        try {
            var model = chatModelFactory.createStreamingModelWithParams(
                    SEARCH_MODEL, 0.3, 0.8, 2000, true);

            List<dev.langchain4j.data.message.ChatMessage> messages = List.of(
                    dev.langchain4j.data.message.SystemMessage.from(
                            "你是一个研究助手。根据用户的搜索查询，利用联网搜索能力获取最新、准确的信息。" +
                            "返回结构化的内容摘要，包含关键数据、事实和引用来源。" +
                            "回复使用中文，内容要适合放入PPT演示文稿。"),
                    dev.langchain4j.data.message.UserMessage.from(query)
            );

            StringBuilder result = new StringBuilder();
            final Object lock = new Object();
            final boolean[] done = {false};
            final Throwable[] error = {null};

            model.chat(messages, new dev.langchain4j.model.chat.response.StreamingChatResponseHandler() {
                @Override
                public void onPartialResponse(String token) {
                    result.append(token);
                }

                @Override
                public void onCompleteResponse(dev.langchain4j.model.chat.response.ChatResponse response) {
                    synchronized (lock) {
                        done[0] = true;
                        lock.notifyAll();
                    }
                }

                @Override
                public void onError(Throwable throwable) {
                    synchronized (lock) {
                        error[0] = throwable;
                        done[0] = true;
                        lock.notifyAll();
                    }
                }
            });

            synchronized (lock) {
                while (!done[0]) {
                    lock.wait(60000);
                }
            }

            if (error[0] != null) {
                log.error("联网搜索失败: query={}", query, error[0]);
                return "搜索失败: " + error[0].getMessage();
            }

            String searchResult = result.toString();
            log.info("联网搜索完成: query={}, 结果长度={}", query, searchResult.length());
            return searchResult;

        } catch (Exception e) {
            log.error("联网搜索异常: query={}", query, e);
            return "搜索异常: " + e.getMessage();
        }
    }

    @Tool("对指定主题进行深度研究，搜索多个角度的信息并汇总为结构化报告。适合为PPT某个章节收集详细素材。")
    public String deepResearch(
            @P("研究主题") String topic,
            @P("需要关注的具体方面，用逗号分隔") String aspects) {

        log.info("Agent deepResearch 调用: topic={}, aspects={}", topic, aspects);

        String query = String.format(
                "请深入研究以下主题：「%s」\n需要关注的方面：%s\n" +
                "请从多个角度搜索信息，汇总为结构化报告，包含：\n" +
                "1. 核心概念与定义\n" +
                "2. 关键数据与统计\n" +
                "3. 最新发展趋势\n" +
                "4. 典型案例或应用\n" +
                "5. 权威观点与引用",
                topic, aspects);

        return searchWeb(query);
    }
}
