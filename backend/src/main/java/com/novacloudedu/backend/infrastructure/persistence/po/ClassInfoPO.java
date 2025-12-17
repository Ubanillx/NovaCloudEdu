package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("class_info")
public class ClassInfoPO {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String className;
    private String description;
    private Long creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    
    @TableLogic
    private Integer isDelete;
}
