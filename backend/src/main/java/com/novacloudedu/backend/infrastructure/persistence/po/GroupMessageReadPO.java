package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群消息已读记录持久化对象
 */
@Data
@TableName("group_message_read")
public class GroupMessageReadPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long messageId;
    private Long userId;
    private LocalDateTime readTime;
}
