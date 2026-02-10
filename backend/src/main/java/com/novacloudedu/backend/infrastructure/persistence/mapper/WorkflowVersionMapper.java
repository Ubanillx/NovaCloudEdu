package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowVersionPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 工作流版本历史Mapper
 */
@Mapper
public interface WorkflowVersionMapper extends BaseMapper<WorkflowVersionPO> {
}
