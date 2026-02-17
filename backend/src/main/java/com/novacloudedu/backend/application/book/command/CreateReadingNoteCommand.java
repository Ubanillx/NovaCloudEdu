package com.novacloudedu.backend.application.book.command;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CreateReadingNoteCommand {

    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @NotNull(message = "章节ID不能为空")
    private Long chapterId;

    private Integer chapterIndex;

    @NotNull(message = "笔记内容不能为空")
    private String noteContent;

    private String selectedText;

    private Integer startPosition;

    private Integer endPosition;

    private String noteColor;
}
