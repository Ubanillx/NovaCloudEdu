package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群成员持久化对象
 */
@Data
@TableName("chat_group_member")
public class ChatGroupMemberPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long groupId;
    private Integer memberType;
    private Long userId;
    private Long aiRoleId;
    private Integer role;
    private String nickname;
    private Integer isMute;
    private LocalDateTime muteUntil;
    private LocalDateTime joinTime;
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
