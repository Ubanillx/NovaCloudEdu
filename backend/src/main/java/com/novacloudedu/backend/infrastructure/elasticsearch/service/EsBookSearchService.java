package com.novacloudedu.backend.infrastructure.elasticsearch.service;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.SearchRequest;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;
import co.elastic.clients.elasticsearch.core.search.HighlightField;
import com.novacloudedu.backend.config.SearchProperties;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.BookDocument;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.ChapterDocument;
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
public class EsBookSearchService {

    private final ElasticsearchClient client;
    private final SearchProperties props;

    /**
     * 搜索书籍（标题 + 作者，支持拼音）
     */
    public SearchResult<BookDocument> searchBooks(String keyword, int page, int size) {
        try {
            SearchResponse<BookDocument> response = client.search(SearchRequest.of(s -> s
                    .index(props.getBookIndex())
                    .query(q -> q.bool(b -> b
                            .must(mu -> mu.multiMatch(m -> m
                                    .query(keyword)
                                    .fields("title^3", "title.pinyin^2", "author^2", "author.pinyin")
                                    .type(co.elastic.clients.elasticsearch._types.query_dsl.TextQueryType.BestFields)
                            ))
                            .filter(f -> f.term(t -> t.field("status").value(2))) // 只搜索就绪状态的书
                    ))
                    .highlight(h -> h
                            .preTags(props.getHighlightPreTag())
                            .postTags(props.getHighlightPostTag())
                            .fields("title", HighlightField.of(hf -> hf))
                            .fields("author", HighlightField.of(hf -> hf)))
                    .from((page - 1) * size)
                    .size(size)
            ), BookDocument.class);

            List<SearchHit<BookDocument>> hits = new ArrayList<>();
            for (Hit<BookDocument> hit : response.hits().hits()) {
                BookDocument doc = hit.source();
                Map<String, List<String>> highlights = new HashMap<>();
                if (hit.highlight() != null) {
                    hit.highlight().forEach(highlights::put);
                }
                hits.add(new SearchHit<>(doc, hit.score(), highlights));
            }
            long total = response.hits().total() != null ? response.hits().total().value() : 0;
            return new SearchResult<>(hits, total, page, size);
        } catch (IOException e) {
            log.error("ES 搜索书籍失败: keyword={}", keyword, e);
            return new SearchResult<>(List.of(), 0, page, size);
        }
    }

    /**
     * 搜索章节内容（全文检索）
     */
    public SearchResult<ChapterDocument> searchChapters(String keyword, Long bookId, int page, int size) {
        try {
            SearchResponse<ChapterDocument> response = client.search(SearchRequest.of(s -> {
                s.index(props.getChapterIndex())
                        .query(q -> {
                            if (bookId != null) {
                                return q.bool(b -> b
                                        .must(mu -> mu.multiMatch(m -> m
                                                .query(keyword)
                                                .fields("title^3", "content")
                                                .type(co.elastic.clients.elasticsearch._types.query_dsl.TextQueryType.BestFields)))
                                        .filter(f -> f.term(t -> t.field("bookId").value(bookId))));
                            } else {
                                return q.multiMatch(m -> m
                                        .query(keyword)
                                        .fields("title^3", "content")
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
            }), ChapterDocument.class);

            List<SearchHit<ChapterDocument>> hits = new ArrayList<>();
            for (Hit<ChapterDocument> hit : response.hits().hits()) {
                ChapterDocument doc = hit.source();
                Map<String, List<String>> highlights = new HashMap<>();
                if (hit.highlight() != null) {
                    hit.highlight().forEach(highlights::put);
                }
                hits.add(new SearchHit<>(doc, hit.score(), highlights));
            }
            long total = response.hits().total() != null ? response.hits().total().value() : 0;
            return new SearchResult<>(hits, total, page, size);
        } catch (IOException e) {
            log.error("ES 搜索章节失败: keyword={}", keyword, e);
            return new SearchResult<>(List.of(), 0, page, size);
        }
    }

    // ==================== 内部数据结构 ====================

    public record SearchHit<T>(T document, Double score, Map<String, List<String>> highlights) {}

    public record SearchResult<T>(List<SearchHit<T>> hits, long total, int page, int size) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / size);
        }
    }
}
