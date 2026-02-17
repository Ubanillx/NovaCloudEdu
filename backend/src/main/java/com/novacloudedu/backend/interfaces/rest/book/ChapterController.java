package com.novacloudedu.backend.interfaces.rest.book;

import com.novacloudedu.backend.application.book.dto.ChapterContentDTO;
import com.novacloudedu.backend.application.book.dto.ChapterDTO;
import com.novacloudedu.backend.application.book.service.ChapterApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "章节管理", description = "章节查询、内容获取等接口")
@RestController
@RequestMapping("/api/books/{bookId}/chapters")
@RequiredArgsConstructor
public class ChapterController {

    private final ChapterApplicationService chapterApplicationService;

    @Operation(summary = "获取书籍章节列表")
    @GetMapping
    public BaseResponse<List<ChapterDTO>> getBookChapters(@PathVariable Long bookId) {
        List<ChapterDTO> chapters = chapterApplicationService.getBookChapters(bookId);
        return ResultUtils.success(chapters);
    }

    @Operation(summary = "获取章节内容")
    @GetMapping("/{chapterIndex}")
    public BaseResponse<ChapterContentDTO> getChapterContent(
            @PathVariable Long bookId,
            @PathVariable Integer chapterIndex) {
        ChapterContentDTO content = chapterApplicationService.getChapterContent(bookId, chapterIndex);
        return ResultUtils.success(content);
    }

    @Operation(summary = "加密章节内容", description = "对指定章节的内容进行AES加密存储")
    @PostMapping("/{chapterIndex}/encrypt")
    public BaseResponse<Void> encryptChapterContent(
            @PathVariable Long bookId,
            @PathVariable Integer chapterIndex) {
        chapterApplicationService.encryptChapterContent(bookId, chapterIndex);
        return ResultUtils.success(null);
    }

    @Operation(summary = "批量加密所有章节", description = "对整本书所有未加密章节进行AES加密存储")
    @PostMapping("/encrypt-all")
    public BaseResponse<Integer> encryptAllChapters(@PathVariable Long bookId) {
        int count = chapterApplicationService.encryptAllChapters(bookId);
        return ResultUtils.success(count);
    }
}
