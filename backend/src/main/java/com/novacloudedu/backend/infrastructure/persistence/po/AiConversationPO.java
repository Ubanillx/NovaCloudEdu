package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * AI对话持久化对象
 */
@Data
@TableName(value = "ai_conversation", autoResultMap = true)
public class AiConversationPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private Long bookId;

    private Long chapterId;

    private String conversationType;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<Map<String, String>> messages;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private Integer isDelete;
}
