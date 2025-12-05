package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群申请持久化对象
 */
@Data
@TableName("group_join_request")
public class GroupJoinRequestPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long groupId;
    private Long userId;
    private String message;
    private Integer status;
    private Long handlerId;
    private LocalDateTime handleTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
