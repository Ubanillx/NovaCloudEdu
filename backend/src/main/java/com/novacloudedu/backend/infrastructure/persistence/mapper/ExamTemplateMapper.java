package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ExamTemplatePO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 试卷模板数据库操作Mapper
 */
@Mapper
public interface ExamTemplateMapper extends BaseMapper<ExamTemplatePO> {

}
