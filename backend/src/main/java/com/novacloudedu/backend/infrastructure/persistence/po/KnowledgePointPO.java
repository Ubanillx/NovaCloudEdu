package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 知识点持久化对象
 */
@Data
@TableName("knowledge_point")
public class KnowledgePointPO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long chapterId;

    private String pointType;

    private String name;

    private String description;

    private Integer position;

    private LocalDateTime createTime;

    private Integer isDelete;
}
