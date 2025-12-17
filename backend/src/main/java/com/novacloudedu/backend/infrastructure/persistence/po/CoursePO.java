package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@TableName(value = "course")
@Data
public class CoursePO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String title;

    private String subtitle;

    private String description;

    private String coverImage;

    private BigDecimal price;

    private Integer courseType;

    private Integer difficulty;

    private Integer status;

    private Long teacherId;

    private Integer totalDuration;

    private Integer totalChapters;

    private Integer totalSections;

    private Integer studentCount;

    private BigDecimal ratingScore;

    private String tags;

    private Long adminId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
