package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostThumbPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 帖子点赞 Mapper
 */
@Mapper
public interface PostThumbMapper extends BaseMapper<PostThumbPO> {
}
