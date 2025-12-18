package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

@TableName(value = "daily_word")
@Data
public class DailyWordPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String word;

    private String pronunciation;

    private String audioUrl;

    private String translation;

    private String example;

    private String exampleTranslation;

    private Integer difficulty;

    private String category;

    private String notes;

    private LocalDate publishDate;

    private Long adminId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
