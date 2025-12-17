package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "course_chapter")
@Data
public class CourseChapterPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long courseId;

    private String title;

    private String description;

    private Integer sort;

    private Long adminId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
