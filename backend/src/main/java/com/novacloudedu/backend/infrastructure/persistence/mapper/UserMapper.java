package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户数据库操作Mapper
 */
@Mapper
public interface UserMapper extends BaseMapper<UserPO> {

}
