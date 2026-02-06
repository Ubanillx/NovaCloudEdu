package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "scraper_source_config")
@Data
public class ScraperSourceConfigPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String name;

    private String sourceCode;

    private String baseUrl;

    private String description;

    private String titleSelector;

    private String authorSelector;

    private String sourceSelector;

    private String contentSelector;

    private String dateSelector;

    private String imageSelector;

    private String linkSelector;

    private Integer maxDepth;

    private Integer maxPages;

    private Long delayMs;

    private Boolean useDynamic;

    private Integer waitForJsMs;

    private String cronExpression;

    private Boolean enabled;

    private Integer defaultMaxArticles;

    private String defaultCategory;

    private Integer defaultDifficulty;

    private Long creatorId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
