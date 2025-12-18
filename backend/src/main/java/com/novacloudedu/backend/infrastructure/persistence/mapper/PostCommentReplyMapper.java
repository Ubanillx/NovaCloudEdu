package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostCommentReplyPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 帖子评论回复 Mapper
 */
@Mapper
public interface PostCommentReplyMapper extends BaseMapper<PostCommentReplyPO> {
}
