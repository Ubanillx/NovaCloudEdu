package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ChatGroupPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 群聊 Mapper
 */
@Mapper
public interface ChatGroupMapper extends BaseMapper<ChatGroupPO> {
}
