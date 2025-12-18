package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 反馈回复持久化对象
 */
@TableName("user_feedback_reply")
@Data
public class FeedbackReplyPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long feedbackId;

    private Long senderId;

    private Integer senderRole;

    private String content;

    private String attachment;

    private Integer isRead;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
