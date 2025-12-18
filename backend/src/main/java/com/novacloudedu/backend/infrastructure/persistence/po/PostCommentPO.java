package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 帖子评论持久化对象
 */
@Data
@TableName("post_comment")
public class PostCommentPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long postId;
    private Long userId;
    private String content;
    private String ipAddress;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
