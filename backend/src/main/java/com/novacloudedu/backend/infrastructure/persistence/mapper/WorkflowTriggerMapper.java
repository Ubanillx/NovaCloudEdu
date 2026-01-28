package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowTriggerPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 工作流触发器Mapper
 */
@Mapper
public interface WorkflowTriggerMapper extends BaseMapper<WorkflowTriggerPO> {
}
