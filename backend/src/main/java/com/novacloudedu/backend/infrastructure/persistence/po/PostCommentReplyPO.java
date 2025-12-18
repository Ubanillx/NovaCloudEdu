package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 帖子评论回复持久化对象
 */
@Data
@TableName("post_comment_reply")
public class PostCommentReplyPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long postId;
    private Long commentId;
    private Long userId;
    private String content;
    private String ipAddress;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
