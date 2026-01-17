package com.novacloudedu.backend.application.book.command;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class UpdateReadingProgressCommand {

    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @NotNull(message = "书籍ID不能为空")
    private Long bookId;

    @NotNull(message = "章节序号不能为空")
    @Min(value = 0, message = "章节序号不能为负数")
    private Integer chapterIndex;

    @NotNull(message = "阅读位置不能为空")
    @Min(value = 0, message = "阅读位置不能为负数")
    private Integer position;
}
