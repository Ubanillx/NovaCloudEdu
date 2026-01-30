package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserFollowPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户关注数据库操作Mapper
 */
@Mapper
public interface UserFollowMapper extends BaseMapper<UserFollowPO> {

}
