package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "reading_bookmark")
@Data
public class ReadingBookmarkPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long userId;

    private Long bookId;

    private Long chapterId;

    private Integer chapterIndex;

    private Integer position;

    @TableField("bookmark_name")
    private String bookmarkName;

    private String note;

    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
