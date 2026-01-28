package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.WorkflowTemplatePO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 工作流模板Mapper
 */
@Mapper
public interface WorkflowTemplateMapper extends BaseMapper<WorkflowTemplatePO> {
}
