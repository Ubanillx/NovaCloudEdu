package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 章节总结持久化对象
 */
@Data
@TableName(value = "chapter_summary", autoResultMap = true)
public class ChapterSummaryPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long chapterId;

    private String summaryType;

    private String content;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> keyPoints;

    private String aiModel;

    private Boolean isCached;

    private LocalDateTime createTime;

    private Integer isDelete;
}
