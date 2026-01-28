package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 帖子 Mapper
 */
@Mapper
public interface PostMapper extends BaseMapper<PostPO> {

    @Select("SELECT COALESCE(SUM(thumb_num), 0) FROM post WHERE user_id = #{userId} AND is_delete = 0")
    Long sumLikesByUserId(@Param("userId") Long userId);
}
