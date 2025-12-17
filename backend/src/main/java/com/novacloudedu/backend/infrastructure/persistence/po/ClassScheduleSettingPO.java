package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;
import com.novacloudedu.backend.infrastructure.persistence.handler.JsonbTypeHandler;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@TableName(value = "class_schedule_setting", autoResultMap = true)
@Data
public class ClassScheduleSettingPO implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long classId;

    private String semester;

    private LocalDate startDate;

    private Integer totalWeeks;

    private Integer daysPerWeek;

    private Integer sectionsPerDay;

    @TableField(typeHandler = JsonbTypeHandler.class)
    private List<TimeConfigItem> timeConfig;

    private Integer isActive;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
