package com.novacloudedu.backend.infrastructure.elasticsearch.service;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.SearchRequest;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.CompletionSuggestOption;
import co.elastic.clients.elasticsearch.core.search.Suggestion;
import com.novacloudedu.backend.config.SearchProperties;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
@ConditionalOnProperty(name = "search.elasticsearch.enabled", havingValue = "true")
public class SearchSuggestionService {

    private final ElasticsearchClient client;
    private final SearchProperties props;

    /**
     * 获取搜索建议（支持中文 + 拼音全拼 + 首字母）
     * @param prefix 用户输入的前缀
     * @param type   "book", "post", "all"
     * @return 建议列表
     */
    public List<SuggestionItem> suggest(String prefix, String type) {
        List<SuggestionItem> results = new ArrayList<>();

        if ("book".equals(type) || "all".equals(type)) {
            results.addAll(suggestFromIndex(prefix, props.getBookIndex(), "title.suggest", "book"));
            results.addAll(suggestFromIndex(prefix, props.getBookIndex(), "author.suggest", "author"));
        }

        if ("post".equals(type) || "all".equals(type)) {
            results.addAll(suggestFromIndex(prefix, props.getPostIndex(), "title.suggest", "post"));
        }

        // 去重并截取
        return results.stream()
                .distinct()
                .limit(props.getSuggestSize())
                .toList();
    }

    private List<SuggestionItem> suggestFromIndex(String prefix, String index, String field, String itemType) {
        try {
            SearchResponse<Void> response = client.search(SearchRequest.of(s -> s
                    .index(index)
                    .size(0)
                    .suggest(su -> su
                            .suggesters("completion-suggest", sg -> sg
                                    .prefix(prefix)
                                    .completion(c -> c
                                            .field(field)
                                            .size(props.getSuggestSize())
                                            .skipDuplicates(true)
                                            .fuzzy(f -> f.fuzziness("AUTO"))))
                    )
            ), Void.class);

            List<SuggestionItem> items = new ArrayList<>();
            Map<String, List<Suggestion<Void>>> suggest = response.suggest();
            if (suggest != null && suggest.containsKey("completion-suggest")) {
                List<Suggestion<Void>> suggestions = suggest.get("completion-suggest");
                for (Suggestion<Void> suggestion : suggestions) {
                    if (suggestion.isCompletion()) {
                        for (CompletionSuggestOption<Void> option : suggestion.completion().options()) {
                            items.add(new SuggestionItem(option.text(), itemType, null));
                        }
                    }
                }
            }
            return items;
        } catch (IOException e) {
            log.error("ES 搜索建议失败: prefix={}, index={}", prefix, index, e);
            return List.of();
        }
    }

    public record SuggestionItem(String text, String type, Long id) {
        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof SuggestionItem that)) return false;
            return Objects.equals(text, that.text) && Objects.equals(type, that.type);
        }

        @Override
        public int hashCode() {
            return Objects.hash(text, type);
        }
    }
}
