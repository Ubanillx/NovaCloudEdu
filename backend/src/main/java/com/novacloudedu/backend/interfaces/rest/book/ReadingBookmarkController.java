package com.novacloudedu.backend.interfaces.rest.book;

import com.novacloudedu.backend.application.book.dto.ReadingBookmarkDTO;
import com.novacloudedu.backend.application.service.ReadingBookmarkApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Tag(name = "阅读书签", description = "阅读书签的创建、查询、更新、删除等接口")
@RestController
@RequestMapping("/api/books/{bookId}/bookmarks")
@RequiredArgsConstructor
public class ReadingBookmarkController {

    private final ReadingBookmarkApplicationService readingBookmarkApplicationService;

    @Operation(summary = "创建书签")
    @PostMapping
    public BaseResponse<ReadingBookmarkDTO> createBookmark(
            @PathVariable Long bookId,
            @RequestBody Map<String, Object> request) {
        Long userId = Long.parseLong(String.valueOf(request.get("userId")));
        Long chapterId = Long.parseLong(String.valueOf(request.get("chapterId")));
        Integer chapterIndex = request.get("chapterIndex") != null ?
                Integer.parseInt(String.valueOf(request.get("chapterIndex"))) : 0;
        Integer position = request.get("position") != null ?
                Integer.parseInt(String.valueOf(request.get("position"))) : 0;
        String bookmarkTitle = request.get("bookmarkTitle") != null ?
                String.valueOf(request.get("bookmarkTitle")) : null;
        String note = request.get("note") != null ?
                String.valueOf(request.get("note")) : null;

        ReadingBookmarkDTO bookmark = readingBookmarkApplicationService.createBookmark(
                bookId, userId, chapterId, chapterIndex, position, bookmarkTitle, note);
        return ResultUtils.success(bookmark);
    }

    @Operation(summary = "获取用户在该书的书签列表")
    @GetMapping
    public BaseResponse<List<ReadingBookmarkDTO>> getBookmarksByBook(
            @PathVariable Long bookId,
            @RequestParam Long userId) {
        List<ReadingBookmarkDTO> bookmarks = readingBookmarkApplicationService.getBookmarksByBook(bookId, userId);
        return ResultUtils.success(bookmarks);
    }

    @Operation(summary = "更新书签备注/标题")
    @PutMapping("/{bookmarkId}")
    public BaseResponse<ReadingBookmarkDTO> updateBookmark(
            @PathVariable Long bookId,
            @PathVariable Long bookmarkId,
            @RequestBody Map<String, String> request) {
        String bookmarkTitle = request.get("bookmarkTitle");
        String note = request.get("note");
        ReadingBookmarkDTO bookmark = readingBookmarkApplicationService.updateBookmark(bookmarkId, bookmarkTitle, note);
        return ResultUtils.success(bookmark);
    }

    @Operation(summary = "删除书签")
    @DeleteMapping("/{bookmarkId}")
    public BaseResponse<Void> deleteBookmark(
            @PathVariable Long bookId,
            @PathVariable Long bookmarkId) {
        readingBookmarkApplicationService.deleteBookmark(bookmarkId);
        return ResultUtils.success(null);
    }
}
