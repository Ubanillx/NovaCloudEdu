package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "scraper_task")
@Data
public class ScraperTaskPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long configId;

    private String configName;

    private Integer status;

    private Integer totalArticles;

    private Integer successCount;

    private Integer failCount;

    private String createdArticleIds;

    private String errorMessage;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private Long durationMs;

    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
