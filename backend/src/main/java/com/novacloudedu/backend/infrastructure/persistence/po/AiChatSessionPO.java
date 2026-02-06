package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * AI聊天会话持久化对象
 */
@Data
@TableName("ai_chat_session")
public class AiChatSessionPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;
    private String title;
    private String memorySummary;
    private Integer messageCount;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
