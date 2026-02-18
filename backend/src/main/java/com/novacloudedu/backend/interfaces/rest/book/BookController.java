package com.novacloudedu.backend.interfaces.rest.book;

import com.novacloudedu.backend.application.book.command.UploadBookCommand;
import com.novacloudedu.backend.application.book.dto.BookDTO;
import com.novacloudedu.backend.application.service.BookApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Tag(name = "书籍管理", description = "书籍上传、查询、删除等管理接口")
@RestController
@RequestMapping("/api/books")
@RequiredArgsConstructor
public class BookController {

    private final BookApplicationService bookApplicationService;

    @Operation(summary = "上传书籍")
    @PostMapping("/upload")
    @PreAuthorize("hasRole('ADMIN')")
    public BaseResponse<BookDTO> uploadBook(@Valid @ModelAttribute UploadBookCommand command) {
        BookDTO book = bookApplicationService.uploadBook(command);
        return ResultUtils.success(book);
    }

    @Operation(summary = "获取书籍详情")
    @GetMapping("/{bookId}")
    public BaseResponse<BookDTO> getBook(@PathVariable Long bookId) {
        BookDTO book = bookApplicationService.getBook(bookId);
        return ResultUtils.success(book);
    }

    @Operation(summary = "获取书籍列表")
    @GetMapping
    public BaseResponse<List<BookDTO>> listBooks(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        List<BookDTO> books = bookApplicationService.listBooks(page, size);
        return ResultUtils.success(books);
    }

    @Operation(summary = "搜索书籍")
    @GetMapping("/search")
    public BaseResponse<List<BookDTO>> searchBooks(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        List<BookDTO> books = bookApplicationService.searchBooks(keyword, page, size);
        return ResultUtils.success(books);
    }

    @Operation(summary = "编辑书籍信息")
    @PutMapping("/{bookId}")
    @PreAuthorize("hasRole('ADMIN')")
    public BaseResponse<BookDTO> updateBook(
            @PathVariable Long bookId,
            @RequestBody java.util.Map<String, String> body) {
        BookDTO book = bookApplicationService.updateBook(bookId, body.get("title"), body.get("author"));
        return ResultUtils.success(book);
    }

    @Operation(summary = "更新书籍封面")
    @PutMapping("/{bookId}/cover")
    @PreAuthorize("hasRole('ADMIN')")
    public BaseResponse<BookDTO> updateBookCover(
            @PathVariable Long bookId,
            @RequestParam("cover") MultipartFile cover) {
        BookDTO book = bookApplicationService.updateBookCover(bookId, cover);
        return ResultUtils.success(book);
    }

    @Operation(summary = "获取PDF预签名URL")
    @GetMapping("/{bookId}/pdf-url")
    public BaseResponse<String> getPdfUrl(@PathVariable Long bookId) {
        String url = bookApplicationService.getPdfPresignedUrl(bookId);
        return ResultUtils.success(url);
    }

    @Operation(summary = "删除书籍")
    @DeleteMapping("/{bookId}")
    @PreAuthorize("hasRole('ADMIN')")
    public BaseResponse<Void> deleteBook(@PathVariable Long bookId) {
        bookApplicationService.deleteBook(bookId);
        return ResultUtils.success(null);
    }
}
