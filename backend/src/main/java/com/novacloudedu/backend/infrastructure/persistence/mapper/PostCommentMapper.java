package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostCommentPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 帖子评论 Mapper
 */
@Mapper
public interface PostCommentMapper extends BaseMapper<PostCommentPO> {
}
