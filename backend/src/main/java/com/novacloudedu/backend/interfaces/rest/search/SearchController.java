package com.novacloudedu.backend.interfaces.rest.search;

import com.novacloudedu.backend.application.search.SearchApplicationService;
import com.novacloudedu.backend.application.search.dto.SearchResultDTO;
import com.novacloudedu.backend.application.search.dto.SearchSuggestionDTO;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Tag(name = "全文搜索", description = "基于 Elasticsearch 的全文搜索、搜索建议和索引管理接口")
@RestController
@RequestMapping("/api/search")
@RequiredArgsConstructor
@ConditionalOnProperty(name = "search.elasticsearch.enabled", havingValue = "true")
public class SearchController {

    private final SearchApplicationService searchApplicationService;

    @Operation(summary = "聚合搜索（书籍+章节+帖子）")
    @GetMapping
    public BaseResponse<SearchResultDTO.PageResult> searchAll(
            @RequestParam String q,
            @RequestParam(defaultValue = "all") String type,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        SearchResultDTO.PageResult result;
        switch (type) {
            case "book" -> result = searchApplicationService.searchBooks(q, page, size);
            case "chapter" -> result = searchApplicationService.searchChapters(q, null, page, size);
            case "post" -> result = searchApplicationService.searchPosts(q, null, page, size);
            default -> result = searchApplicationService.searchAll(q, page, size);
        }
        return ResultUtils.success(result);
    }

    @Operation(summary = "搜索书籍")
    @GetMapping("/books")
    public BaseResponse<SearchResultDTO.PageResult> searchBooks(
            @RequestParam String q,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResultUtils.success(searchApplicationService.searchBooks(q, page, size));
    }

    @Operation(summary = "搜索章节内容")
    @GetMapping("/chapters")
    public BaseResponse<SearchResultDTO.PageResult> searchChapters(
            @RequestParam String q,
            @RequestParam(required = false) Long bookId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResultUtils.success(searchApplicationService.searchChapters(q, bookId, page, size));
    }

    @Operation(summary = "搜索帖子")
    @GetMapping("/posts")
    public BaseResponse<SearchResultDTO.PageResult> searchPosts(
            @RequestParam String q,
            @RequestParam(required = false) String postType,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResultUtils.success(searchApplicationService.searchPosts(q, postType, page, size));
    }

    @Operation(summary = "书内搜索")
    @GetMapping("/books/{bookId}/chapters")
    public BaseResponse<SearchResultDTO.PageResult> searchBookChapters(
            @PathVariable Long bookId,
            @RequestParam String q,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResultUtils.success(searchApplicationService.searchChapters(q, bookId, page, size));
    }

    @Operation(summary = "搜索建议（即时联想）")
    @GetMapping("/suggest")
    public BaseResponse<List<SearchSuggestionDTO>> suggest(
            @RequestParam String q,
            @RequestParam(defaultValue = "all") String type) {
        return ResultUtils.success(searchApplicationService.suggest(q, type));
    }

    @Operation(summary = "全量重建索引（管理员）")
    @PostMapping("/admin/reindex")
    @PreAuthorize("hasRole('ADMIN')")
    public BaseResponse<Map<String, Integer>> reindex(
            @RequestParam(defaultValue = "all") String type) {
        return ResultUtils.success(searchApplicationService.reindex(type));
    }
}
