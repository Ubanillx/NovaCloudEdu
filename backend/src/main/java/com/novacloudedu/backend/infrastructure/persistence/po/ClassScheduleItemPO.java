package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@TableName(value = "class_schedule_item")
@Data
public class ClassScheduleItemPO implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long settingId;

    private Long classId;

    private Long userId;

    private Integer courseType;

    private String courseName;

    private String teacherName;

    private String location;

    private Long courseId;

    private Long teacherId;

    private Integer dayOfWeek;

    private Integer startSection;

    private Integer endSection;

    private Integer startWeek;

    private Integer endWeek;

    private Integer weekType;

    private String color;

    private String remark;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
