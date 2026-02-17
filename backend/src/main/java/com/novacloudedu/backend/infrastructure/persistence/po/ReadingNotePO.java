package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "reading_note")
@Data
public class ReadingNotePO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long userId;

    private Long bookId;

    private Long chapterId;

    private Integer chapterIndex;

    private String noteContent;

    private String selectedText;

    @TableField("position_start")
    private Integer positionStart;

    @TableField("position_end")
    private Integer positionEnd;

    private String noteColor;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
