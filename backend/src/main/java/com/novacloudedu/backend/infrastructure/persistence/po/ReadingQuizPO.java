package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 阅读测试持久化对象
 */
@Data
@TableName(value = "reading_quiz", autoResultMap = true)
public class ReadingQuizPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long chapterId;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<Map<String, Object>> questions;

    private String aiModel;

    private LocalDateTime createTime;

    private Integer isDelete;
}
