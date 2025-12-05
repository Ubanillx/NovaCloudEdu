package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PrivateChatSessionPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 私聊会话数据库操作Mapper
 */
@Mapper
public interface PrivateChatSessionMapper extends BaseMapper<PrivateChatSessionPO> {

}
