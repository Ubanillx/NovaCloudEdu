package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

@TableName(value = "daily_article")
@Data
public class DailyArticlePO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String title;

    private String content;

    private String summary;

    private String coverImage;

    private String author;

    private String source;

    private String sourceUrl;

    private String category;

    private String tags;

    private Integer difficulty;

    private Integer readTime;

    private LocalDate publishDate;

    private Long adminId;

    private Integer viewCount;

    private Integer likeCount;

    private Integer collectCount;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
