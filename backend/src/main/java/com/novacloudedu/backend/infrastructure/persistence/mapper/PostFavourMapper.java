package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostFavourPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 帖子收藏 Mapper
 */
@Mapper
public interface PostFavourMapper extends BaseMapper<PostFavourPO> {
}
