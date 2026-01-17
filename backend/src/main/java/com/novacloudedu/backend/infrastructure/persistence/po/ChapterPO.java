package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "chapter")
@Data
public class ChapterPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long bookId;

    private String title;

    private Integer chapterIndex;

    private Integer wordCount;

    private String content;

    private String contentHash;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
