package com.novacloudedu.backend.book;

import com.novacloudedu.backend.domain.book.entity.ReadingNote;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("阅读笔记实体测试")
class ReadingNoteTest {

    @Test
    @DisplayName("创建笔记成功")
    void createNote_Success() {
        ReadingNote note = ReadingNote.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(1L),
                0,
                "这段讲解很清晰",
                "神经网络是一种模仿人脑的计算模型",
                100,
                150,
                "#FFEB3B"
        );

        assertNotNull(note);
        assertEquals(1L, note.getUserId().value());
        assertEquals(100L, note.getBookId().value());
        assertEquals(1L, note.getChapterId().value());
        assertEquals(0, note.getChapterIndex());
        assertEquals("这段讲解很清晰", note.getNoteContent());
        assertEquals("神经网络是一种模仿人脑的计算模型", note.getSelectedText());
        assertEquals(100, note.getStartPosition());
        assertEquals(150, note.getEndPosition());
        assertEquals("#FFEB3B", note.getNoteColor());
        assertNotNull(note.getCreateTime());
        assertNotNull(note.getUpdateTime());
    }

    @Test
    @DisplayName("创建笔记时用户ID为空应抛出异常")
    void createNote_NullUserId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingNote.create(
                        null,
                        BookId.of(100L),
                        ChapterId.of(1L),
                        0,
                        "笔记内容",
                        "选中文本",
                        100,
                        150,
                        "#FFEB3B"
                )
        );
    }

    @Test
    @DisplayName("创建笔记时书籍ID为空应抛出异常")
    void createNote_NullBookId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingNote.create(
                        UserId.of(1L),
                        null,
                        ChapterId.of(1L),
                        0,
                        "笔记内容",
                        "选中文本",
                        100,
                        150,
                        "#FFEB3B"
                )
        );
    }

    @Test
    @DisplayName("创建笔记时章节ID为空应抛出异常")
    void createNote_NullChapterId_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingNote.create(
                        UserId.of(1L),
                        BookId.of(100L),
                        null,
                        0,
                        "笔记内容",
                        "选中文本",
                        100,
                        150,
                        "#FFEB3B"
                )
        );
    }

    @Test
    @DisplayName("创建笔记时内容为空应抛出异常")
    void createNote_EmptyContent_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () ->
                ReadingNote.create(
                        UserId.of(1L),
                        BookId.of(100L),
                        ChapterId.of(1L),
                        0,
                        "",
                        "选中文本",
                        100,
                        150,
                        "#FFEB3B"
                )
        );
    }

    @Test
    @DisplayName("更新笔记内容成功")
    void updateContent_Success() {
        ReadingNote note = ReadingNote.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(1L),
                0,
                "原始笔记",
                "选中文本",
                100,
                150,
                "#FFEB3B"
        );

        note.updateContent("更新后的笔记内容");

        assertEquals("更新后的笔记内容", note.getNoteContent());
    }

    @Test
    @DisplayName("更新笔记颜色成功")
    void updateColor_Success() {
        ReadingNote note = ReadingNote.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(1L),
                0,
                "笔记内容",
                "选中文本",
                100,
                150,
                "#FFEB3B"
        );

        note.updateColor("#FF5722");

        assertEquals("#FF5722", note.getNoteColor());
    }

    @Test
    @DisplayName("默认颜色应为黄色")
    void createNote_DefaultColor() {
        ReadingNote note = ReadingNote.create(
                UserId.of(1L),
                BookId.of(100L),
                ChapterId.of(1L),
                0,
                "笔记内容",
                "选中文本",
                100,
                150,
                null
        );

        assertEquals("#FFEB3B", note.getNoteColor());
    }
}
