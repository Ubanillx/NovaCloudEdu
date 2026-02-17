package com.novacloudedu.backend.application.search;

import com.novacloudedu.backend.application.search.dto.SearchResultDTO;
import com.novacloudedu.backend.application.search.dto.SearchSuggestionDTO;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.BookDocument;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.ChapterDocument;
import com.novacloudedu.backend.infrastructure.elasticsearch.document.PostDocument;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.EsBookSearchService;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.EsBookSearchService.SearchHit;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.EsBookSearchService.SearchResult;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.EsPostSearchService;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.IndexSyncService;
import com.novacloudedu.backend.infrastructure.elasticsearch.service.SearchSuggestionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@ConditionalOnProperty(name = "search.elasticsearch.enabled", havingValue = "true")
public class SearchApplicationService {

    private final EsBookSearchService bookSearchService;
    private final EsPostSearchService postSearchService;
    private final SearchSuggestionService suggestionService;
    private final IndexSyncService indexSyncService;

    /**
     * 搜索书籍
     */
    public SearchResultDTO.PageResult searchBooks(String keyword, int page, int size) {
        SearchResult<BookDocument> result = bookSearchService.searchBooks(keyword, page, size);
        List<SearchResultDTO> items = result.hits().stream()
                .map(this::toBookResult)
                .toList();
        return SearchResultDTO.PageResult.builder()
                .items(items)
                .total(result.total())
                .page(page)
                .size(size)
                .totalPages(result.getTotalPages())
                .build();
    }

    /**
     * 搜索章节内容
     */
    public SearchResultDTO.PageResult searchChapters(String keyword, Long bookId, int page, int size) {
        SearchResult<ChapterDocument> result = bookSearchService.searchChapters(keyword, bookId, page, size);
        List<SearchResultDTO> items = result.hits().stream()
                .map(this::toChapterResult)
                .toList();
        return SearchResultDTO.PageResult.builder()
                .items(items)
                .total(result.total())
                .page(page)
                .size(size)
                .totalPages(result.getTotalPages())
                .build();
    }

    /**
     * 搜索帖子
     */
    public SearchResultDTO.PageResult searchPosts(String keyword, String postType, int page, int size) {
        SearchResult<PostDocument> result = postSearchService.searchPosts(keyword, postType, page, size);
        List<SearchResultDTO> items = result.hits().stream()
                .map(this::toPostResult)
                .toList();
        return SearchResultDTO.PageResult.builder()
                .items(items)
                .total(result.total())
                .page(page)
                .size(size)
                .totalPages(result.getTotalPages())
                .build();
    }

    /**
     * 聚合搜索（书籍+章节+帖子）
     */
    public SearchResultDTO.PageResult searchAll(String keyword, int page, int size) {
        // 每种类型各取一部分
        int partSize = Math.max(size / 3, 3);

        List<SearchResultDTO> allItems = new ArrayList<>();

        SearchResult<BookDocument> bookResult = bookSearchService.searchBooks(keyword, 1, partSize);
        allItems.addAll(bookResult.hits().stream().map(this::toBookResult).toList());

        SearchResult<ChapterDocument> chapterResult = bookSearchService.searchChapters(keyword, null, 1, partSize);
        allItems.addAll(chapterResult.hits().stream().map(this::toChapterResult).toList());

        SearchResult<PostDocument> postResult = postSearchService.searchPosts(keyword, null, 1, partSize);
        allItems.addAll(postResult.hits().stream().map(this::toPostResult).toList());

        // 按 score 降序排列
        allItems.sort((a, b) -> Double.compare(b.getScore() != null ? b.getScore() : 0,
                a.getScore() != null ? a.getScore() : 0));

        long total = bookResult.total() + chapterResult.total() + postResult.total();
        return SearchResultDTO.PageResult.builder()
                .items(allItems.stream().limit(size).toList())
                .total(total)
                .page(page)
                .size(size)
                .totalPages((int) Math.ceil((double) total / size))
                .build();
    }

    /**
     * 搜索建议
     */
    public List<SearchSuggestionDTO> suggest(String prefix, String type) {
        return suggestionService.suggest(prefix, type).stream()
                .map(item -> SearchSuggestionDTO.builder()
                        .text(item.text())
                        .type(item.type())
                        .id(item.id())
                        .build())
                .toList();
    }

    /**
     * 全量重建索引
     */
    public Map<String, Integer> reindex(String type) {
        Map<String, Integer> result = new java.util.HashMap<>();
        if ("book".equals(type) || "all".equals(type)) {
            result.put("books", indexSyncService.reindexBooks());
        }
        if ("chapter".equals(type) || "all".equals(type)) {
            result.put("chapters", indexSyncService.reindexChapters());
        }
        if ("post".equals(type) || "all".equals(type)) {
            result.put("posts", indexSyncService.reindexPosts());
        }
        return result;
    }

    // ==================== 转换方法 ====================

    private SearchResultDTO toBookResult(SearchHit<BookDocument> hit) {
        BookDocument doc = hit.document();
        return SearchResultDTO.builder()
                .type("book")
                .id(doc.getId())
                .title(doc.getTitle())
                .author(doc.getAuthor())
                .fileType(doc.getFileType())
                .coverUrl(doc.getCoverUrl())
                .totalChapters(doc.getTotalChapters())
                .score(hit.score())
                .highlights(hit.highlights())
                .createTime(doc.getCreateTime())
                .build();
    }

    private SearchResultDTO toChapterResult(SearchHit<ChapterDocument> hit) {
        ChapterDocument doc = hit.document();
        return SearchResultDTO.builder()
                .type("chapter")
                .id(doc.getId())
                .title(doc.getTitle())
                .bookId(doc.getBookId())
                .bookTitle(doc.getBookTitle())
                .chapterIndex(doc.getChapterIndex())
                .score(hit.score())
                .highlights(hit.highlights())
                .build();
    }

    private SearchResultDTO toPostResult(SearchHit<PostDocument> hit) {
        PostDocument doc = hit.document();
        return SearchResultDTO.builder()
                .type("post")
                .id(doc.getId())
                .title(doc.getTitle())
                .content(doc.getContent() != null && doc.getContent().length() > 200
                        ? doc.getContent().substring(0, 200) + "..."
                        : doc.getContent())
                .tags(doc.getTags())
                .postType(doc.getPostType())
                .thumbNum(doc.getThumbNum())
                .favourNum(doc.getFavourNum())
                .commentNum(doc.getCommentNum())
                .score(hit.score())
                .highlights(hit.highlights())
                .createTime(doc.getCreateTime())
                .build();
    }
}
