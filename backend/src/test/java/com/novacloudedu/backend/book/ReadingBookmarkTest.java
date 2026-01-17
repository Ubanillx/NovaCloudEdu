package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.entity.ReadingBookmark;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("阅读书签实体测试")
class ReadingBookmarkTest {

    @Test
    @DisplayName("创建书签成功")
    void createBookmark_Success() {
        ReadingBookmark bookmark = ReadingBookmark.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(5L),
                5,
                1500,
                "重要章节",
                "需要重点复习"
        );

        assertNotNull(bookmark);
        assertEquals(1L, bookmark.getUserId().value());
        assertEquals(100L, bookmark.getBookId().value());
        assertEquals(5L, bookmark.getChapterId().value());
        assertEquals(5, bookmark.getChapterIndex());
        assertEquals(1500, bookmark.getPosition());
        assertEquals("重要章节", bookmark.getBookmarkTitle());
        assertEquals("需要重点复习", bookmark.getNote());
        assertNotNull(bookmark.getCreateTime());
    }

    @Test
    @DisplayName("创建书签时用户ID为空应抛出异常")
    void createBookmark_NullUserId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingBookmark.create(
                        null,
                        BookId.of(100L),
                        ChapterId.of(5L),
                        5,
                        1500,
                        "书签标题",
                        "备注"
                )
        );
    }

    @Test
    @DisplayName("创建书签时书籍ID为空应抛出异常")
    void createBookmark_NullBookId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingBookmark.create(
                        UserId.of(1L),
                        null,
                        ChapterId.of(5L),
                        5,
                        1500,
                        "书签标题",
                        "备注"
                )
        );
    }

    @Test
    @DisplayName("创建书签时章节ID为空应抛出异常")
    void createBookmark_NullChapterId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingBookmark.create(
                        UserId.of(1L),
                        BookId.of(100L),
                        null,
                        5,
                        1500,
                        "书签标题",
                        "备注"
                )
        );
    }

    @Test
    @DisplayName("创建书签时章节索引无效应抛出异常")
    void createBookmark_InvalidChapterIndex_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingBookmark.create(
                        UserId.of(1L),
                        BookId.of(100L),
                        ChapterId.of(5L),
                        -1,
                        1500,
                        "书签标题",
                        "备注"
                )
        );
    }

    @Test
    @DisplayName("创建书签时位置无效应抛出异常")
    void createBookmark_InvalidPosition_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingBookmark.create(
                        UserId.of(1L),
                        BookId.of(100L),
                        ChapterId.of(5L),
                        5,
                        -1,
                        "书签标题",
                        "备注"
                )
        );
    }

    @Test
    @DisplayName("更新书签备注成功")
    void updateNote_Success() {
        ReadingBookmark bookmark = ReadingBookmark.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(5L),
                5,
                1500,
                "书签标题",
                "原始备注"
        );

        bookmark.updateNote("更新后的备注");

        assertEquals("更新后的备注", bookmark.getNote());
    }

    @Test
    @DisplayName("更新书签标题成功")
    void updateTitle_Success() {
        ReadingBookmark bookmark = ReadingBookmark.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(5L),
                5,
                1500,
                "原始标题",
                "备注"
        );

        bookmark.updateTitle("新标题");

        assertEquals("新标题", bookmark.getBookmarkTitle());
    }

    @Test
    @DisplayName("默认书签标题应包含章节信息")
    void createBookmark_DefaultTitle() {
        ReadingBookmark bookmark = ReadingBookmark.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(5L),
                5,
                1500,
                null,
                "备注"
        );

        assertEquals("书签 - 第6章", bookmark.getBookmarkTitle());
    }
}
