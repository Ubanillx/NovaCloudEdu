package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * AI聊天消息持久化对象
 */
@Data
@TableName("ai_chat_message")
public class AiChatMessagePO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long sessionId;
    private Long userId;
    private String role;
    private String content;
    private String attachments;
    private Integer isSummarized;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;
}
