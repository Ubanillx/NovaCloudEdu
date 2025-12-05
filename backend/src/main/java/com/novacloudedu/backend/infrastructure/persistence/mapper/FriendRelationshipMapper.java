package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.FriendRelationshipPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 好友关系数据库操作Mapper
 */
@Mapper
public interface FriendRelationshipMapper extends BaseMapper<FriendRelationshipPO> {

}
