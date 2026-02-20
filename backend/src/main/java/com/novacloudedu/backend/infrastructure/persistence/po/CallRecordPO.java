package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 通话记录持久化对象
 */
@Data
@TableName("call_record")
public class CallRecordPO {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String callId;
    private Long callerId;
    private Long calleeId;
    private String mediaType;
    private String status;
    private String mode;
    private LocalDateTime startedAt;
    private LocalDateTime endedAt;
    private Integer duration;
    private LocalDateTime createTime;
}
