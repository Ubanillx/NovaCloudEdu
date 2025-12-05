package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 公告阅读记录持久化对象
 */
@TableName("announcement_read")
@Data
public class AnnouncementReadPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long announcementId;

    private Long userId;

    private LocalDateTime createTime;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
