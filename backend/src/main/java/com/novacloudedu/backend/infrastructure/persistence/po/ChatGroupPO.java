package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群聊持久化对象
 */
@Data
@TableName("chat_group")
public class ChatGroupPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String groupName;
    private String avatar;
    private String description;
    private Long ownerId;
    private Long classId;
    private Integer maxMembers;
    private Integer memberCount;
    private Integer inviteMode;
    private Integer joinMode;
    private Integer isMute;
    private String announcement;
    private LocalDateTime announcementTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
