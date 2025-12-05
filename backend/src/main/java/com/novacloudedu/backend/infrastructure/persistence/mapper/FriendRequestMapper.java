package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.FriendRequestPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 好友申请数据库操作Mapper
 */
@Mapper
public interface FriendRequestMapper extends BaseMapper<FriendRequestPO> {

}
