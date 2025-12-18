package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 帖子持久化对象
 */
@Data
@TableName("post")
public class PostPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String title;
    private String content;
    private String tags;
    private Integer thumbNum;
    private Integer favourNum;
    private Integer commentNum;
    private Long userId;
    private String ipAddress;
    private String postType;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
