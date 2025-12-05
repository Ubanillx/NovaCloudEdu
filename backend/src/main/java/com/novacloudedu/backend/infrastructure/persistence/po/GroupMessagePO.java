package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群消息持久化对象
 */
@Data
@TableName("group_message")
public class GroupMessagePO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long groupId;
    private Integer senderType;
    private Long senderId;
    private Long aiRoleId;
    private String content;
    private String type;
    private Long replyTo;
    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;
}
