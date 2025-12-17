package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("class_member")
public class ClassMemberPO {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long classId;
    private Long userId;
    private String role;
    private LocalDateTime joinTime;
    
    @TableLogic
    private Integer isDelete;
}
