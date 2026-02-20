package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 直播间聊天消息持久化对象
 */
@Data
@TableName("live_room_message")
public class LiveRoomMessagePO {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long roomId;
    private Long senderId;
    private String content;
    private String messageType;
    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;
}
