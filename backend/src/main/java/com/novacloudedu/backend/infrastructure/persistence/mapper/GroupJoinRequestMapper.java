package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupJoinRequestPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 群申请 Mapper
 */
@Mapper
public interface GroupJoinRequestMapper extends BaseMapper<GroupJoinRequestPO> {
}
