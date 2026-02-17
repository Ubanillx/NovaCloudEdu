package com.novacloudedu.backend.interfaces.rest.book;

import com.novacloudedu.backend.application.book.command.CreateReadingNoteCommand;
import com.novacloudedu.backend.application.book.dto.ReadingNoteDTO;
import com.novacloudedu.backend.application.book.service.ReadingNoteApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Tag(name = "阅读笔记", description = "阅读笔记的创建、查询、更新、删除等接口")
@RestController
@RequestMapping("/api/books/{bookId}/notes")
@RequiredArgsConstructor
public class ReadingNoteController {

    private final ReadingNoteApplicationService readingNoteApplicationService;

    @Operation(summary = "创建阅读笔记")
    @PostMapping
    public BaseResponse<ReadingNoteDTO> createNote(
            @PathVariable Long bookId,
            @Valid @RequestBody CreateReadingNoteCommand command) {
        ReadingNoteDTO note = readingNoteApplicationService.createNote(bookId, command);
        return ResultUtils.success(note);
    }

    @Operation(summary = "获取用户在该书的笔记列表")
    @GetMapping
    public BaseResponse<List<ReadingNoteDTO>> getNotesByBook(
            @PathVariable Long bookId,
            @RequestParam Long userId) {
        List<ReadingNoteDTO> notes = readingNoteApplicationService.getNotesByBook(bookId, userId);
        return ResultUtils.success(notes);
    }

    @Operation(summary = "获取用户在该章节的笔记")
    @GetMapping("/chapters/{chapterId}")
    public BaseResponse<List<ReadingNoteDTO>> getNotesByChapter(
            @PathVariable Long bookId,
            @PathVariable Long chapterId,
            @RequestParam Long userId) {
        List<ReadingNoteDTO> notes = readingNoteApplicationService.getNotesByChapter(bookId, chapterId, userId);
        return ResultUtils.success(notes);
    }

    @Operation(summary = "更新笔记内容/颜色")
    @PutMapping("/{noteId}")
    public BaseResponse<ReadingNoteDTO> updateNote(
            @PathVariable Long bookId,
            @PathVariable Long noteId,
            @RequestBody Map<String, String> request) {
        String noteContent = request.get("noteContent");
        String noteColor = request.get("noteColor");
        ReadingNoteDTO note = readingNoteApplicationService.updateNote(noteId, noteContent, noteColor);
        return ResultUtils.success(note);
    }

    @Operation(summary = "删除笔记")
    @DeleteMapping("/{noteId}")
    public BaseResponse<Void> deleteNote(
            @PathVariable Long bookId,
            @PathVariable Long noteId) {
        readingNoteApplicationService.deleteNote(noteId);
        return ResultUtils.success(null);
    }
}
