package com.novacloudedu.backend.interfaces.rest.book;

import com.novacloudedu.backend.application.book.command.UpdateReadingProgressCommand;
import com.novacloudedu.backend.application.book.dto.UserShelfDTO;
import com.novacloudedu.backend.application.book.service.ReadingProgressApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "阅读进度管理", description = "书架管理、阅读进度同步等接口")
@RestController
@RequestMapping("/api/reading")
@RequiredArgsConstructor
public class ReadingProgressController {

    private final ReadingProgressApplicationService readingProgressApplicationService;

    @Operation(summary = "添加书籍到书架")
    @PostMapping("/shelf")
    public BaseResponse<Void> addToShelf(
            @RequestParam Long userId,
            @RequestParam Long bookId) {
        readingProgressApplicationService.addToShelf(userId, bookId);
        return ResultUtils.success(null);
    }

    @Operation(summary = "更新阅读进度")
    @PutMapping("/progress")
    public BaseResponse<Void> updateProgress(@Valid @RequestBody UpdateReadingProgressCommand command) {
        readingProgressApplicationService.updateProgress(command);
        return ResultUtils.success(null);
    }

    @Operation(summary = "获取用户书架")
    @GetMapping("/shelf/{userId}")
    public BaseResponse<List<UserShelfDTO>> getUserShelf(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        List<UserShelfDTO> shelf = readingProgressApplicationService.getUserShelf(userId, page, size);
        return ResultUtils.success(shelf);
    }

    @Operation(summary = "从书架移除书籍")
    @DeleteMapping("/shelf")
    public BaseResponse<Void> removeFromShelf(
            @RequestParam Long userId,
            @RequestParam Long bookId) {
        readingProgressApplicationService.removeFromShelf(userId, bookId);
        return ResultUtils.success(null);
    }
}
