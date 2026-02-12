package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.McpServerPO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface McpServerMapper extends BaseMapper<McpServerPO> {
}
