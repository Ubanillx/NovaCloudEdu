package com.novacloudedu.backend.infrastructure.elasticsearch.service;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.SearchRequest;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;
import co.elastic.clients.elasticsearch.core.search.HighlightField;
import com.novacloudedu.backend.config.SearchProperties;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.PostDocument;
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
public class EsPostSearchService {

    private final ElasticsearchClient client;
    private final SearchProperties props;

    /**
     * 搜索帖子（标题 + 内容 + 标签，支持拼音）
     */
    public EsBookSearchService.SearchResult<PostDocument> searchPosts(String keyword, String postType, int page, int size) {
        try {
            SearchResponse<PostDocument> response = client.search(SearchRequest.of(s -> {
                s.index(props.getPostIndex())
                        .query(q -> {
                            if (postType != null && !postType.isEmpty()) {
                                return q.bool(b -> b
                                        .must(mu -> mu.multiMatch(m -> m
                                                .query(keyword)
                                                .fields("title^3", "title.pinyin^2", "content", "tags^2")
                                                .type(co.elastic.clients.elasticsearch._types.query_dsl.TextQueryType.BestFields)))
                                        .filter(f -> f.term(t -> t.field("postType").value(postType))));
                            } else {
                                return q.multiMatch(m -> m
                                        .query(keyword)
                                        .fields("title^3", "title.pinyin^2", "content", "tags^2")
                                        .type(co.elastic.clients.elasticsearch._types.query_dsl.TextQueryType.BestFields));
                            }
                        })
                        .highlight(h -> h
                                .preTags(props.getHighlightPreTag())
                                .postTags(props.getHighlightPostTag())
                                .fields("title", HighlightField.of(hf -> hf))
                                .fields("content", HighlightField.of(hf -> hf
                                        .fragmentSize(props.getFragmentSize())
                                        .numberOfFragments(props.getNumberOfFragments()))))
                        .from((page - 1) * size)
                        .size(size);
                return s;
            }), PostDocument.class);

            List<EsBookSearchService.SearchHit<PostDocument>> hits = new ArrayList<>();
            for (Hit<PostDocument> hit : response.hits().hits()) {
                PostDocument doc = hit.source();
                Map<String, List<String>> highlights = new HashMap<>();
                if (hit.highlight() != null) {
                    hit.highlight().forEach(highlights::put);
                }
                hits.add(new EsBookSearchService.SearchHit<>(doc, hit.score(), highlights));
            }
            long total = response.hits().total() != null ? response.hits().total().value() : 0;
            return new EsBookSearchService.SearchResult<>(hits, total, page, size);
        } catch (IOException e) {
            log.error("ES 搜索帖子失败: keyword={}", keyword, e);
            return new EsBookSearchService.SearchResult<>(List.of(), 0, page, size);
        }
    }
}
